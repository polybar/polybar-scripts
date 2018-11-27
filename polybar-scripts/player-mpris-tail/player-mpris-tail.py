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
    def __init__(self, blacklist = [], connect = True):
        self.blacklist = blacklist
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
    
    def onOwnerChangedName(self, bus_name, old_owner, new_owner):
        if self.busNameIsAPlayer(bus_name):
            if new_owner and not old_owner:
                self.addPlayer(bus_name, new_owner)
            elif old_owner and not new_owner:
                self.removePlayer(old_owner)
            else:
                self.changePlayerOwner(bus_name, old_owner, new_owner)

    def busNameIsAPlayer(self, bus_name):
        return bus_name.startswith('org.mpris.MediaPlayer2') and bus_name.split('.')[-1] not in self.blacklist

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
        self.players[owner].disconnect()
        del self.players[owner]
        if len(self.players) == 0:
            _printFlush(ICON_NONE)

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
            artist = _getProperty(self._metadata, 'xesam:artist', [''])
            if len(artist):
                self.metadata['artist'] = re.sub(SAFE_TAG_REGEX, """\1\1""", artist[0])
            else:
                self.metadata['artist'] = ''
            self.metadata['album']  = re.sub(SAFE_TAG_REGEX, """\1\1""", _getProperty(self._metadata, 'xesam:album', ''))
            self.metadata['title']  = re.sub(SAFE_TAG_REGEX, """\1\1""", _getProperty(self._metadata, 'xesam:title', ''))
            self.metadata['track']  = _getProperty(self._metadata, 'xesam:trackNumber', '')
            length = str(_getProperty(self._metadata, 'xesam:length', ''))
            if not len(length):
                length = str(_getProperty(self._metadata, 'mpris:length', ''))
            if len(length):
                self.metadata['length'] = int(length)
            else:
                self.metadata['length'] = 0
            self.metadata['genre']    = _getProperty(self._metadata, 'xesam:genre', '')
            self.metadata['disc']     = _getProperty(self._metadata, 'xesam:discNumber', '')
            self.metadata['date']     = re.sub(SAFE_TAG_REGEX, """\1\1""", _getProperty(self._metadata, 'xesam:contentCreated', ''))
            self.metadata['year']     = re.sub(SAFE_TAG_REGEX, """\1\1""", self.metadata['date'][0:4])
            self.metadata['url']      = _getProperty(self._metadata, 'xesam:url', '')
            self.metadata['filename'] = os.path.basename(self.metadata['url'])
            cover = _getProperty(self._metadata, 'xesam:artUrl', '')
            if not len(cover):
                cover = _getProperty(self._metadata, 'mpris:artUrl', '')
            if len(cover):
                self.metadata['cover'] = re.sub(SAFE_TAG_REGEX, """\1\1""", cover)
            else:
                self.metadata['cover'] = ''

            self.metadata['duration'] = _getDuration(self.metadata['length']) 
    
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
                self.updateIcon()
                updated = True
        
        if updated:
            self.printStatus()

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
parser.add_argument('-b', '--blacklist', help="ignore a player by it's bus name. Can be be given multiple times (e.g. -b vlc -b audacious)",
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
TRUNCATE_STRING = args.truncate_text
ICON_PLAYING = args.icon_playing
ICON_PAUSED = args.icon_paused
ICON_STOPPED = args.icon_stopped
ICON_NONE = args.icon_none

if args.command is None:
    PlayerManager(blacklist = args.blacklist)
else:
    player_manager = PlayerManager(blacklist = args.blacklist, connect = False)
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
            "{} : {}".format(player.bus_name.split('.')[-1], player.status)
            for player in player_manager.players.values() ])))
    elif args.command == 'current' and current_player:
        print("{} : {}".format(current_player.bus_name.split('.')[-1], current_player.status))
    elif args.command == 'metadata' and current_player:
        print(_dbusValueToPython(current_player._metadata))
    elif args.command == 'raise' and current_player:
        current_player.raisePlayer()
