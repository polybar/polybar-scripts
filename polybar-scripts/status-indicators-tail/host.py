import os
import sys

import gi

gi.require_version('Gtk', '3.0')

from gi.repository import Gio  # noqa
from gi.repository import GLib  # noqa

MENU_PATH = os.path.join(os.path.dirname(__file__), 'menu.py')

NODE_INFO = Gio.DBusNodeInfo.new_for_xml("""
<?xml version="1.0" encoding="UTF-8"?>
<node>
    <interface name="org.kde.StatusNotifierWatcher">
        <method name="RegisterStatusNotifierItem">
            <arg type="s" direction="in"/>
        </method>
        <property name="RegisteredStatusNotifierItems" type="as" access="read">
        </property>
        <property name="IsStatusNotifierHostRegistered" type="b" access="read">
        </property>
    </interface>
</node>""")

items = {}


def render():
    # customize this function to your needs
    # see https://www.freedesktop.org/wiki/Specifications/StatusNotifierItem/StatusNotifierItem/
    # for available fields
    labels = []
    for key, item in reversed(items.items()):
        name, path = key.split('/', 1)

        if item['Status'] == 'Passive':
            continue

        label = f'[{item["IconName"]}]'

        cmd = (
            f'busctl --user call \\{name} /{path} '
            'org.kde.StatusNotifierItem Activate ii 0 0'
        )
        menu_cmd = f'python3 {MENU_PATH} \\{name} {item["Menu"]}'

        label = f'%{{A1:{cmd}:}}{label}%{{A}}'
        label = f'%{{A3:{menu_cmd}:}}{label}%{{A}}'

        labels.append(label)

    print(' '.join(labels))


def get_item_data(conn, sender, path):
    def callback(conn, red, user_data=None):
        args = conn.call_finish(red)
        items[sender + path] = args[0]
        render()

    conn.call(
        sender,
        path,
        'org.freedesktop.DBus.Properties',
        'GetAll',
        GLib.Variant('(s)', ['org.kde.StatusNotifierItem']),
        GLib.VariantType('(a{sv})'),
        Gio.DBusCallFlags.NONE,
        -1,
        None,
        callback,
        None,
    )


def on_call(
    conn, sender, path, interface, method, params, invocation, user_data=None
):
    props = {
        'RegisteredStatusNotifierItems': GLib.Variant('as', items.keys()),
        'IsStatusNotifierHostRegistered': GLib.Variant('b', True),
    }

    if method == 'Get' and params[1] in props:
        invocation.return_value(GLib.Variant('(v)', [props[params[1]]]))
        conn.flush()
    if method == 'GetAll':
        invocation.return_value(GLib.Variant('(a{sv})', [props]))
        conn.flush()
    elif method == 'RegisterStatusNotifierItem':
        if params[0].startswith('/'):
            path = params[0]
        else:
            path = '/StatusNotifierItem'
        get_item_data(conn, sender, path)
        invocation.return_value(None)
        conn.flush()


def on_signal(
    conn, sender, path, interface, signal, params, invocation, user_data=None
):
    if signal == 'NameOwnerChanged':
        if params[2] != '':
            return
        keys = [key for key in items if key.startswith(params[0] + '/')]
        if not keys:
            return
        for key in keys:
            del items[key]
        render()
    elif sender + path in items:
        get_item_data(conn, sender, path)


def on_bus_acquired(conn, name, user_data=None):
    for interface in NODE_INFO.interfaces:
        if interface.name == name:
            conn.register_object('/StatusNotifierWatcher', interface, on_call)

    def signal_subscribe(interface, signal):
        conn.signal_subscribe(
            None,  # sender
            interface,
            signal,
            None,  # path
            None,
            Gio.DBusSignalFlags.NONE,
            on_signal,
            None,  # user_data
        )

    signal_subscribe('org.freedesktop.DBus', 'NameOwnerChanged')
    for signal in [
        'NewAttentionIcon',
        'NewIcon',
        'NewIconThemePath',
        'NewStatus',
        'NewTitle',
    ]:
        signal_subscribe('org.kde.StatusNotifierItem', signal)


def on_name_lost(conn, name, user_data=None):
    sys.exit(
        f'Could not aquire name {name}. '
        f'Is some other service blocking it?'
    )


if __name__ == '__main__':
    owner_id = Gio.bus_own_name(
        Gio.BusType.SESSION,
        NODE_INFO.interfaces[0].name,
        Gio.BusNameOwnerFlags.NONE,
        on_bus_acquired,
        None,
        on_name_lost,
    )

    try:
        loop = GLib.MainLoop()
        loop.run()
    finally:
        Gio.bus_unown_name(owner_id)
