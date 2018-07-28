class KeyboardWidget : Gtk.Fixed {
    KeyboardLayout layout;
    Gee.Map<string, KeyWidget> key_widgets = new Gee.HashMap<string, KeyWidget>();

    public KeyboardWidget (string layout_file) {
        layout = new KeyboardLayout.from_json_file (File.new_for_path (layout_file));

        foreach (KeyboardLayout.Key key in layout.keys.data) {
            var key_widget = new KeyWidget (key);
            put (key_widget, key.left, key.top);

            key_widgets.set(key.key, key_widget);
        }
    }

    construct {
        var label = new Gtk.Label ("Practice Typing!");
        add (label);
    }
}
