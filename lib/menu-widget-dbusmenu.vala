/*
 * vala-panel-appmenu
 * Copyright (C) 2015 Konstantin Pugin <ria.freelander@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
using Gtk;
using DBusMenu;

namespace Appmenu
{
    internal class MenuWidgetDbusmenu: MenuWidget
    {
        public string object_name {get; private set construct;}
        public ObjectPath object_path {get; private set construct;}
        private DBusMenu.GtkClient client;
        public MenuWidgetDbusmenu(uint window_id, string name, ObjectPath path, Bamf.Application? app)
        {
            this.window_id = window_id;
            this.object_name = name;
            this.object_path = path;
            if (app != null)
            {
                var appmenu = new BamfAppmenu(app);
                this.add(appmenu);
                appmenu.show();
                completed_menus |= MenuWidgetCompletionFlags.APPMENU;
            }
            if (DBusMenu.GtkClient.check(name,(string)path))
            { //Loads the menubar for all apps
                client = new DBusMenu.GtkClient(name,(string)path);
                var menubar = new Gtk.MenuBar();
								//MODS

								//END MODS
                client.attach_to_menu(menubar);
                this.add(menubar);
                menubar.show();
                completed_menus |= MenuWidgetCompletionFlags.MENUBAR;
            }
            this.show();
        }
				public override bool motion_notify_event(Gdk.EventMotion event){
					var window = new Window ();
			    window.title = "First GTK+ Program";
			    window.border_width = 10;
			    window.window_position = WindowPosition.CENTER;
			    window.set_default_size (350, 70);
			    window.destroy.connect (Gtk.main_quit);

			    var button = new Button.with_label ("Click me!");
			    button.clicked.connect (() => {
			        button.label = "Thank you";
			    });

			    window.add (button);
			    window.show_all ();
					return false;
				}
    }
}
