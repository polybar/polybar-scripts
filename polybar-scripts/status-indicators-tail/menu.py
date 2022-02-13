import subprocess
import sys
import time

import gi

gi.require_version('Gtk', '3.0')

from gi.repository import Gio  # noqa
from gi.repository import GLib  # noqa

DMENU_CMD = ['rofi', '-dmenu', '-i', '-no-sort']


class Bus:
    def __init__(self, conn, name, path):
        self.conn = conn
        self.name = name
        self.path = path

    def call_sync(self, interface, method, params, params_type, return_type):
        return self.conn.call_sync(
            self.name,
            self.path,
            interface,
            method,
            GLib.Variant(params_type, params),
            GLib.VariantType(return_type),
            Gio.DBusCallFlags.NONE,
            -1,
            None,
        )

    def get_menu_layout(self, *args):
        return self.call_sync(
            'com.canonical.dbusmenu',
            'GetLayout',
            args,
            '(iias)',
            '(u(ia{sv}av))',
        )

    def menu_event(self, *args):
        self.call_sync('com.canonical.dbusmenu', 'Event', args, '(isvu)', '()')


def dmenu(_input):
    p = subprocess.Popen(
        DMENU_CMD,
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        encoding='utf-8',
    )
    out, _ = p.communicate(_input)
    return out


def format_toggle_value(props):
    toggle_type = props.get('toggle-type', '')
    toggle_value = props.get('toggle-state', -1)

    if toggle_value == 0:
        s = ' '
    elif toggle_value == 1:
        s = 'X'
    else:
        s = '~'

    if toggle_type == 'checkmark':
        return f'[{s}] '
    elif toggle_type == 'radio':
        return f'({s}) '
    else:
        return ''


def format_menu_item(item, level=1):
    id, props, children = item

    if not props.get('visible', True):
        return ''
    if props.get('type', 'standard') == 'separator':
        label = '---'
    else:
        label = format_toggle_value(props) + props.get('label', '')
        if not props.get('enabled', True):
            label = f'({label})'

    indentation = '  ' * level
    ret = f'{id}{indentation}{label}\n'
    for child in children:
        ret += format_menu_item(child, level + 1)
    return ret


def show_menu(conn, name, path):
    bus = Bus(conn, name, path)
    item = bus.get_menu_layout(0, -1, [])[1]

    menu = format_menu_item(item)
    selected = dmenu(menu)

    if selected:
        id = int(selected.split()[0])
        bus.menu_event(id, 'clicked', GLib.Variant('s', ''), time.time())


if __name__ == '__main__':
    conn = Gio.bus_get_sync(Gio.BusType.SESSION)
    show_menu(conn, sys.argv[1], sys.argv[2])
