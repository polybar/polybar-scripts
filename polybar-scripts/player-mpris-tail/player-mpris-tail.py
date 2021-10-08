#!/usr/bin/env python3

import sys
import dbus
import os
from operator import itemgetter
import argparse
import re
from urllib.parse import unquote
import time
from dbus.mainloop.glib import DBusGMainLoop
from gi.repository import GLib
DBusGMainLoop(set_as_default=True)


FORMAT_STRING = '{icon} {artist} - {title}'
FORMAT_REGEX = re.compile(r'(\{:(?P<tag>.*?)(:(?P<format>[wt])(?P<formatlen>\d+))?:(?P<text>.*?):\})', re.I)
FORMAT_TAG_REGEX = re.compile(r'(?P<format>[wt])(?P<formatlen>\d+)')
SAFE_TAG_REGEX = re.compile(r'[{}]')

class PlayerManager:
    def __init__(self, filter_list, block_mode = True, connect = True):
        self.filter_list = filter_list
        self.block_mode = block_mode
        self._connect = connect
        self._session_bus = dbus.SessionBus()
        self.players = {}

        self.print_queue = []
        self.connected = False
        self.player_states = {}

        self.refreshPlayerList()

        if self._connect:
            self.connect()
            loop = GLib.MainLoop()
            try:
                loop.run()
            except KeyboardInterrupt:
                print("interrupt received, stopping…")

    def connect(self):
        self._session_bus.add_signal_receiver(self.onOwnerChangedName, 'NameOwnerChanged')
        self._session_bus.add_signal_receiver(self.onChangedProperties, 'PropertiesChanged',
                                              path = '/org/mpris/MediaPlayer2',
                                              sender_keyword='sender')

    def onChangedProperties(self, interface, properties, signature, sender = None):
        if sender in self.players:
            player = self.players[sender]
            # If we know this player, but haven't been able to set up a signal handler
            if 'properties_changed' not in player._signals:
                # Then trigger the signal handler manually
                player.onPropertiesChanged(interface, properties, signature)
        else:
            # If we don't know this player, get its name and add it
            bus_name = self.getBusNameFromOwner(sender)
            if bus_name is None:
                return
            self.addPlayer(bus_name, sender)
            player = self.players[sender]
            player.onPropertiesChanged(interface, properties, signature)

    def onOwnerChangedName(self, bus_name, old_owner, new_owner):
        if self.busNameIsAPlayer(bus_name):
            if new_owner and not old_owner:
                self.addPlayer(bus_name, new_owner)
            elif old_owner and not new_owner:
                self.removePlayer(old_owner)
            else:
                self.changePlayerOwner(bus_name, old_owner, new_owner)

    def getBusNameFromOwner(self, owner):
        player_bus_names = [ bus_name for bus_name in self._session_bus.list_names() if self.busNameIsAPlayer(bus_name) ]
        for player_bus_name in player_bus_names:
            player_bus_owner = self._session_bus.get_name_owner(player_bus_name)
            if owner == player_bus_owner:
                return player_bus_name

    def busNameIsAPlayer(self, bus_name):
        if bus_name.startswith('org.mpris.MediaPlayer2') is False:
            return False
        name = bus_name.split('.')[3]
        if self.block_mode is True:
            return name not in self.filter_list
        return name in self.filter_list

    def refreshPlayerList(self):
        player_bus_names = [ bus_name for bus_name in self._session_bus.list_names() if self.busNameIsAPlayer(bus_name) ]
        for player_bus_name in player_bus_names:
            self.addPlayer(player_bus_name)
        if self.connected != True:
            self.connected = True
            self.printQueue()

    def addPlayer(self, bus_name, owner = None):
        player = Player(self._session_bus, bus_name, owner = owner, connect = self._connect, _print = self.print)
        self.players[player.owner] = player

    def removePlayer(self, owner):
        if owner in self.players:
            self.players[owner].disconnect()
            del self.players[owner]
        # If there are no more players, clear the output
        if len(self.players) == 0:
            _printFlush(ICON_NONE)
        # Else, print the output of the next active player
        else:
            players = self.getSortedPlayerOwnerList()
            if len(players) > 0:
                self.players[players[0]].printStatus()

    def changePlayerOwner(self, bus_name, old_owner, new_owner):
        player = Player(self._session_bus, bus_name, owner = new_owner, connect = self._connect, _print = self.print)
        self.players[new_owner] = player
        del self.players[old_owner]

    # Get a list of player owners sorted by current status and age
    def getSortedPlayerOwnerList(self):
        players = [
            {
                'number': int(owner.split('.')[-1]),
                'status': 2 if player.status == 'playing' else 1 if player.status == 'paused' else 0,
                'owner': owner
            }
            for owner, player in self.players.items()
        ]
        return [ info['owner'] for info in reversed(sorted(players, key=itemgetter('status', 'number'))) ]

    # Get latest player that's currently playing
    def getCurrentPlayer(self):
        playing_players = [
            player_owner for player_owner in self.getSortedPlayerOwnerList()
            if
                self.players[player_owner].status == 'playing' or
                self.players[player_owner].status == 'paused'
        ]
        return self.players[playing_players[0]] if playing_players else None

    def print(self, status, player):
        self.player_states[player.bus_name] = status

        if self.connected:
            current_player = self.getCurrentPlayer()
            if current_player != None:
                _printFlush(self.player_states[current_player.bus_name])
            else:
                _printFlush(ICON_STOPPED)
        else:
            self.print_queue.append([status, player])

    def printQueue(self):
        for args in self.print_queue:
            self.print(args[0], args[1])
        self.print_queue.clear()


class Player:
    def __init__(self, session_bus, bus_name, owner = None, connect = True, _print = None):
        self._session_bus = session_bus
        self.bus_name = bus_name
        self._disconnecting = False
        self.__print = _print

        self.metadata = {
            'artist' : '',
            'album'  : '',
            'title'  : '',
            'track'  : 0
        }

        self._rate = 1.
        self._positionAtLastUpdate = 0.
        self._timeAtLastUpdate = time.time()
        self._positionTimerRunning = False

        self._metadata = None
        self.status = 'stopped'
        self.icon = ICON_NONE
        self.icon_reversed = ICON_PLAYING
        if owner is not None:
            self.owner = owner
        else:
            self.owner = self._session_bus.get_name_owner(bus_name)
        self._obj = self._session_bus.get_object(self.bus_name, '/org/mpris/MediaPlayer2')
        self._properties_interface = dbus.Interface(self._obj, dbus_interface='org.freedesktop.DBus.Properties')
        self._introspect_interface = dbus.Interface(self._obj, dbus_interface='org.freedesktop.DBus.Introspectable')
        self._media_interface      = dbus.Interface(self._obj, dbus_interface='org.mpris.MediaPlayer2')
        self._player_interface     = dbus.Interface(self._obj, dbus_interface='org.mpris.MediaPlayer2.Player')
        self._introspect = self._introspect_interface.get_dbus_method('Introspect', dbus_interface=None)
        self._getProperty = self._properties_interface.get_dbus_method('Get', dbus_interface=None)
        self._playerPlay      = self._player_interface.get_dbus_method('Play', dbus_interface=None)
        self._playerPause     = self._player_interface.get_dbus_method('Pause', dbus_interface=None)
        self._playerPlayPause = self._player_interface.get_dbus_method('PlayPause', dbus_interface=None)
        self._playerStop      = self._player_interface.get_dbus_method('Stop', dbus_interface=None)
        self._playerPrevious  = self._player_interface.get_dbus_method('Previous', dbus_interface=None)
        self._playerNext      = self._player_interface.get_dbus_method('Next', dbus_interface=None)
        self._playerRaise     = self._media_interface.get_dbus_method('Raise', dbus_interface=None)
        self._signals = {}

        self.refreshPosition()
        self.refreshStatus()
        self.refreshMetadata()

        if connect:
            self.printStatus()
            self.connect()

    def play(self):
        self._playerPlay()
    def pause(self):
        self._playerPause()
    def playpause(self):
        self._playerPlayPause()
    def stop(self):
        self._playerStop()
    def previous(self):
        self._playerPrevious()
    def next(self):
        self._playerNext()
    def raisePlayer(self):
        self._playerRaise()

    def connect(self):
        if self._disconnecting is not True:
            introspect_xml = self._introspect(self.bus_name, '/')
            if 'TrackMetadataChanged' in introspect_xml:
                self._signals['track_metadata_changed'] = self._session_bus.add_signal_receiver(self.onMetadataChanged, 'TrackMetadataChanged', self.bus_name)
            self._signals['seeked'] = self._player_interface.connect_to_signal('Seeked', self.onSeeked)
            self._signals['properties_changed'] = self._properties_interface.connect_to_signal('PropertiesChanged', self.onPropertiesChanged)

    def disconnect(self):
        self._disconnecting = True
        for signal_name, signal_handler in list(self._signals.items()):
            signal_handler.remove()
            del self._signals[signal_name]

    def refreshStatus(self):
        # Some clients (VLC) will momentarily create a new player before removing it again
        # so we can't be sure the interface still exists
        try:
            self.status = str(self._getProperty('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')).lower()
            self.updateIcon()
            self.checkPositionTimer()
        except dbus.exceptions.DBusException:
            self.disconnect()

    def refreshMetadata(self):
        # Some clients (VLC) will momentarily create a new player before removing it again
        # so we can't be sure the interface still exists
        try:
            self._metadata = self._getProperty('org.mpris.MediaPlayer2.Player', 'Metadata')
            self._parseMetadata()
        except dbus.exceptions.DBusException:
            self.disconnect()

    def updateIcon(self):
        self.icon = (
            ICON_PLAYING if self.status == 'playing' else
            ICON_PAUSED if self.status == 'paused' else
            ICON_STOPPED if self.status == 'stopped' else
            ICON_NONE
        )
        self.icon_reversed = (
            ICON_PAUSED if self.status == 'playing' else
            ICON_PLAYING
        )

    def _print(self, status):
        self.__print(status, self)

    def _parseMetadata(self):
        if self._metadata != None:
            # Obtain properties from _metadata
            _artist     = _getProperty(self._metadata, 'xesam:artist', [''])
            _album      = _getProperty(self._metadata, 'xesam:album', '')
            _title      = _getProperty(self._metadata, 'xesam:title', '')
            _track      = _getProperty(self._metadata, 'xesam:trackNumber', '')
            _genre      = _getProperty(self._metadata, 'xesam:genre', [''])
            _disc       = _getProperty(self._metadata, 'xesam:discNumber', '')
            _length     = _getProperty(self._metadata, 'xesam:length', 0) or _getProperty(self._metadata, 'mpris:length', 0)
            _length_int = _length if type(_length) is int else int(float(_length))
            _fmt_length = ( # Formats using h:mm:ss if length > 1 hour, else m:ss
                f'{_length_int/1e6//60:.0f}:{_length_int/1e6%60:02.0f}'
                if _length_int < 3600*1e6 else
                f'{_length_int/1e6//3600:.0f}:{_length_int/1e6%3600//60:02.0f}:{_length_int/1e6%60:02.0f}'
            )
            _date       = _getProperty(self._metadata, 'xesam:contentCreated', '')
            _year       = _date[0:4] if len(_date) else ''
            _url        = _getProperty(self._metadata, 'xesam:url', '')
            _cover      = _getProperty(self._metadata, 'xesam:artUrl', '') or _getProperty(self._metadata, 'mpris:artUrl', '')
            _duration   = _getDuration(_length_int)
            # Update metadata
            self.metadata['artist']     = re.sub(SAFE_TAG_REGEX, """\1\1""", _metadataGetFirstItem(_artist))
            self.metadata['album']      = re.sub(SAFE_TAG_REGEX, """\1\1""", _metadataGetFirstItem(_album))
            self.metadata['title']      = re.sub(SAFE_TAG_REGEX, """\1\1""", _metadataGetFirstItem(_title))
            self.metadata['track']      = _track
            self.metadata['genre']      = re.sub(SAFE_TAG_REGEX, """\1\1""", _metadataGetFirstItem(_genre))
            self.metadata['disc']       = _disc
            self.metadata['date']       = re.sub(SAFE_TAG_REGEX, """\1\1""", _date)
            self.metadata['year']       = re.sub(SAFE_TAG_REGEX, """\1\1""", _year)
            self.metadata['url']        = _url
            self.metadata['filename']   = os.path.basename(_url)
            self.metadata['length']     = _length_int
            self.metadata['fmt-length'] = _fmt_length
            self.metadata['cover']      = re.sub(SAFE_TAG_REGEX, """\1\1""", _metadataGetFirstItem(_cover))
            self.metadata['duration']   = _duration

    def onMetadataChanged(self, track_id, metadata):
        self.refreshMetadata()
        self.printStatus()

    def onPropertiesChanged(self, interface, properties, signature):
        updated = False
        if dbus.String('Metadata') in properties:
            _metadata = properties[dbus.String('Metadata')]
            if _metadata != self._metadata:
                self._metadata = _metadata
                self._parseMetadata()
                updated = True
        if dbus.String('PlaybackStatus') in properties:
            status = str(properties[dbus.String('PlaybackStatus')]).lower()
            if status != self.status:
                self.status = status
                self.checkPositionTimer()
                self.updateIcon()
                updated = True
        if dbus.String('Rate') in properties and dbus.String('PlaybackStatus') not in properties:
            self.refreshStatus()
        if NEEDS_POSITION and dbus.String('Rate') in properties:
            rate = properties[dbus.String('Rate')]
            if rate != self._rate:
                self._rate = rate
                self.refreshPosition()

        if updated:
            self.refreshPosition()
            self.printStatus()

    def checkPositionTimer(self):
        if NEEDS_POSITION and self.status == 'playing' and not self._positionTimerRunning:
            self._positionTimerRunning = True
            GLib.timeout_add_seconds(1, self._positionTimer)

    def onSeeked(self, position):
        self.refreshPosition()
        self.printStatus()

    def _positionTimer(self):
        self.printStatus()
        self._positionTimerRunning = self.status == 'playing'
        return self._positionTimerRunning

    def refreshPosition(self):
        try:
            time_us = self._getProperty('org.mpris.MediaPlayer2.Player', 'Position')
        except dbus.exceptions.DBusException:
            time_us = 0

        self._timeAtLastUpdate = time.time()
        self._positionAtLastUpdate = time_us / 1000000

    def _getPosition(self):
        if self.status == 'playing':
            return self._positionAtLastUpdate + self._rate * (time.time() - self._timeAtLastUpdate)
        else:
            return self._positionAtLastUpdate

    def _statusReplace(self, match, metadata):
        tag = match.group('tag')
        format = match.group('format')
        formatlen = match.group('formatlen')
        text = match.group('text')
        tag_found = False
        reversed_tag = False

        if tag.startswith('-'):
            tag = tag[1:]
            reversed_tag = True

        if format is None:
            tag_is_format_match = re.match(FORMAT_TAG_REGEX, tag)
            if tag_is_format_match:
                format = tag_is_format_match.group('format')
                formatlen = tag_is_format_match.group('formatlen')
                tag_found = True
        if format is not None:
            text = text.format_map(CleanSafeDict(**metadata))
            if format == 'w':
                formatlen = int(formatlen)
                text = text[:formatlen]
            elif format == 't':
                formatlen = int(formatlen)
                if len(text) > formatlen:
                    text = text[:max(formatlen - len(TRUNCATE_STRING), 0)] + TRUNCATE_STRING
        if tag_found is False and tag in metadata and len(metadata[tag]):
            tag_found = True

        if reversed_tag:
            tag_found = not tag_found

        if tag_found:
            return text
        else:
            return ''

    def printStatus(self):
        if self.status in [ 'playing', 'paused' ]:
            metadata = { **self.metadata, 'icon': self.icon, 'icon-reversed': self.icon_reversed }
            if NEEDS_POSITION:
                metadata['position'] = time.strftime("%M:%S", time.gmtime(self._getPosition()))
            # replace metadata tags in text
            text = re.sub(FORMAT_REGEX, lambda match: self._statusReplace(match, metadata), FORMAT_STRING)
            # restore polybar tag formatting and replace any remaining metadata tags after that
            try:
                text = re.sub(r'􏿿p􏿿(.*?)􏿿p􏿿(.*?)􏿿p􏿿(.*?)􏿿p􏿿', r'%{\1}\2%{\3}', text.format_map(CleanSafeDict(**metadata)))
            except:
                print("Invalid format string")
            self._print(text)
        else:
            self._print(ICON_STOPPED)


def _dbusValueToPython(value):
    if isinstance(value, dbus.Dictionary):
        return {_dbusValueToPython(key): _dbusValueToPython(value) for key, value in value.items()}
    elif isinstance(value, dbus.Array):
        return [ _dbusValueToPython(item) for item in value ]
    elif isinstance(value, dbus.Boolean):
        return int(value) == 1
    elif (
        isinstance(value, dbus.Byte) or
        isinstance(value, dbus.Int16) or
        isinstance(value, dbus.UInt16) or
        isinstance(value, dbus.Int32) or
        isinstance(value, dbus.UInt32) or
        isinstance(value, dbus.Int64) or
        isinstance(value, dbus.UInt64)
    ):
        return int(value)
    elif isinstance(value, dbus.Double):
        return float(value)
    elif (
        isinstance(value, dbus.ObjectPath) or
        isinstance(value, dbus.Signature) or
        isinstance(value, dbus.String)
    ):
        return unquote(str(value))

def _getProperty(properties, property, default = None):
    value = default
    if not isinstance(property, dbus.String):
        property = dbus.String(property)
    if property in properties:
        value = properties[property]
        return _dbusValueToPython(value)
    else:
        return value

def _getDuration(t: int):
        seconds = t / 1000000
        return time.strftime("%M:%S", time.gmtime(seconds))

def _metadataGetFirstItem(_value):
    if type(_value) is list:
        # Returns the string representation of the first item on _value if it has at least one item.
        # Returns an empty string if _value is empty.
        return str(_value[0]) if len(_value) else ''
    else:
        # If _value isn't a list just return the string representation of _value.
        return str(_value)

class CleanSafeDict(dict):
    def __missing__(self, key):
        return '{{{}}}'.format(key)


"""
Seems to assure print() actually prints when no terminal is connected
"""

_last_status = ''
def _printFlush(status, **kwargs):
    global _last_status
    if status != _last_status:
        print(status, **kwargs)
        sys.stdout.flush()
        _last_status = status



parser = argparse.ArgumentParser()
parser.add_argument('command', help="send the given command to the active player",
                    choices=[ 'play', 'pause', 'play-pause', 'stop', 'previous', 'next', 'status', 'list', 'current', 'metadata', 'raise' ],
                    default=None,
                    nargs='?')
parser.add_argument('-b', '--blacklist', help="ignore a player by it's bus name. Can be given multiple times (e.g. -b vlc -b audacious)",
                    action='append',
                    metavar="BUS_NAME",
                    default=[])
parser.add_argument('-w', '--whitelist', help="permit a player by it's bus name like --blacklist. will block --blacklist if given",
                    action='append',
                    metavar="BUS_NAME",
                    default=[])
parser.add_argument('-f', '--format', default='{icon} {:artist:{artist} - :}{:title:{title}:}{:-title:{filename}:}')
parser.add_argument('--truncate-text', default='…')
parser.add_argument('--icon-playing', default='⏵')
parser.add_argument('--icon-paused', default='⏸')
parser.add_argument('--icon-stopped', default='⏹')
parser.add_argument('--icon-none', default='')
args = parser.parse_args()

FORMAT_STRING = re.sub(r'%\{(.*?)\}(.*?)%\{(.*?)\}', r'􏿿p􏿿\1􏿿p􏿿\2􏿿p􏿿\3􏿿p􏿿', args.format)
NEEDS_POSITION = "{position}" in FORMAT_STRING

TRUNCATE_STRING = args.truncate_text
ICON_PLAYING = args.icon_playing
ICON_PAUSED = args.icon_paused
ICON_STOPPED = args.icon_stopped
ICON_NONE = args.icon_none

block_mode = len(args.whitelist) == 0
filter_list = args.blacklist if block_mode else args.whitelist

if args.command is None:
    PlayerManager(filter_list = filter_list, block_mode = block_mode)
else:
    player_manager = PlayerManager(filter_list = filter_list, block_mode = block_mode, connect = False)
    current_player = player_manager.getCurrentPlayer()
    if args.command == 'play' and current_player:
        current_player.play()
    elif args.command == 'pause' and current_player:
        current_player.pause()
    elif args.command == 'play-pause' and current_player:
        current_player.playpause()
    elif args.command == 'stop' and current_player:
        current_player.stop()
    elif args.command == 'previous' and current_player:
        current_player.previous()
    elif args.command == 'next' and current_player:
        current_player.next()
    elif args.command == 'status' and current_player:
        current_player.printStatus()
    elif args.command == 'list':
        print("\n".join(sorted([
            "{} : {}".format(player.bus_name.split('.')[3], player.status)
            for player in player_manager.players.values() ])))
    elif args.command == 'current' and current_player:
        print("{} : {}".format(current_player.bus_name.split('.')[3], current_player.status))
    elif args.command == 'metadata' and current_player:
        print(_dbusValueToPython(current_player._metadata))
    elif args.command == 'raise' and current_player:
        current_player.raisePlayer()
