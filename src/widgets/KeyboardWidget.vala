class KeyboardWidget : Gtk.Fixed {
    KeyboardLayout layout;
    Gee.Map<int, int> lefts = new Gee.HashMap<int, int>();
    Gee.Map<string, KeyWidget> key_widgets = new Gee.HashMap<string, KeyWidget>();
    KeyWidget last_pressed;

    bool caps_lock = false;

    public KeyboardWidget (string layout_file) {
        layout = new KeyboardLayout.from_json_file (File.new_for_path (layout_file));
        get_style_context ().add_class ("keyboard");

        margin = 10;

        height_request = 300;

        foreach (KeyboardLayout.Key key in layout.keys.data) {
            var key_widget = new KeyWidget (key, layout.key_height);

            if (!lefts.has_key (key.row)) {
                lefts.set (key.row, 0);
            }

            put (key_widget, lefts.get (key.row), key.row * (layout.key_height + layout.margin));

            key_widgets.set (key.name, key_widget);

            if (key.mod_name != null) {
                key_widgets.set (key.mod_name, key_widget);
            }

            lefts.set (key.row, lefts.get (key.row) + key.width + layout.margin);
        }
    }

    public KeyboardLayout get_keyboard_layout () {
        return layout;
    }
    
    public void set_shift_pressed (bool pressed, string keyval_name) {
        if (pressed) {
            foreach (var entry in key_widgets.entries) {
                if (entry.key.get (0).isalpha ()) {
                    entry.value.show_variant (!caps_lock);
                } else {
                    entry.value.show_variant (true);
                }
            }


            key_widgets.get (keyval_name).set_dark_mode (true);
        } else {
            foreach (var entry in key_widgets.entries) {
                var key = entry.value.get_key (false);

                if (key.len () == 1 && key.get (0).isalpha ()) {
                    entry.value.show_variant (caps_lock);
                } else {
                    entry.value.show_variant (false);
                }
            }

            key_widgets.get (keyval_name).set_dark_mode (false);
        }
    }

    public void set_caps_lock_state (bool state) {
        foreach (var entry in key_widgets.entries) {
            var key = entry.value.get_key (false);
         
            if (key.len () == 1 && key.get (0).isalpha ()) {
                entry.value.show_variant (caps_lock);
            }
        }

        key_widgets.get ("Caps_Lock").set_dark_mode (state);
    }

    public bool set_key_pressed (string keyval_name) {
        if (last_pressed != null) {
            last_pressed.set_dark_mode (false);
        }

        last_pressed = key_widgets.get (keyval_name);

        if (last_pressed != null) {
            last_pressed.set_dark_mode (true);
            return true;
        }

        return false;
    }
}
