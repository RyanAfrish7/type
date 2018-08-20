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

        this.set_can_focus (true);
        this.add_events (Gdk.EventMask.KEY_PRESS_MASK);
        this.add_events (Gdk.EventMask.KEY_RELEASE_MASK);

        this.key_press_event.connect (on_key_press);
        this.key_release_event.connect (on_key_release);
    }

    private bool on_key_press (Gdk.EventKey event) {
        string keyval_name = Gdk.keyval_name (event.keyval);

        if (keyval_name == "Shift_L" || keyval_name == "Shift_R") {
            foreach (var entry in key_widgets.entries) {
                if (entry.key.get (0).isalpha ()) {
                    entry.value.show_variant (!caps_lock);
                } else {
                    entry.value.show_variant (true);
                }
            }
            key_widgets.get (keyval_name).set_dark_mode (true);

            return true;
        } else if (keyval_name == "Caps_Lock") {
            caps_lock = !caps_lock;

            foreach (var entry in key_widgets.entries) {
                var key = entry.value.get_key (false);
                if (key.len () == 1 && key.get (0).isalpha ()) {
                    entry.value.show_variant (caps_lock);
                }
            }
        }

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

    private bool on_key_release (Gdk.EventKey event) {
        string keyval_name = Gdk.keyval_name (event.keyval);

        if (keyval_name == "Shift_L" || keyval_name == "Shift_R") {
            foreach (var entry in key_widgets.entries) {
                var key = entry.value.get_key (false);

                if (key.len () == 1 && key.get (0).isalpha ()) {
                    entry.value.show_variant (caps_lock);
                } else {
                    entry.value.show_variant (false);
                }
            }
            key_widgets.get (keyval_name).set_dark_mode (false);
            return true;
        }

        return false;
    }
}
