class KeyboardWidget : Gtk.Fixed {
    KeyboardLayout layout;
    Gee.Map<int, int> lefts = new Gee.HashMap<int, int>();
    Gee.Map<string, KeyWidget> key_widgets = new Gee.HashMap<string, KeyWidget>();

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
            
            key_widgets.set (key.key, key_widget);
            lefts.set (key.row, lefts.get (key.row) + key.width + layout.margin);
        }
    }
}
