class KeyWidget : Gtk.Box {
    KeyboardLayout.Key key;
    Gtk.Label label;

    public KeyWidget (KeyboardLayout.Key key, int key_height) {
        this.key = key;

        var style_context = get_style_context();
        style_context.add_class("key");

        if(key.is_nongraphic) {
            style_context.add_class("nongraphic");
        }

        set_size_request (key.width, key_height);

        label = new Gtk.Label (key.key);
        label.halign = Gtk.Align.CENTER;
        label.valign = Gtk.Align.CENTER;
        label.set_hexpand(true);
        
        add (label);
    }
}