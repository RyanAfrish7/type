class KeyWidget : Gtk.Box {
    KeyboardLayout.Key key;
    Gtk.Label label;

    public KeyWidget (KeyboardLayout.Key key) {
        this.key = key;

        set_size_request (key.width, key.height);

        label = new Gtk.Label (key.key);
        label.halign = Gtk.Align.CENTER;
        label.valign = Gtk.Align.CENTER;
        add (label);
    }
}