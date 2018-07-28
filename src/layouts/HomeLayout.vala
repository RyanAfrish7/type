class HomeLayout : Gtk.Stack {
    KeyboardWidget keyboard;

    construct {
        keyboard = new KeyboardWidget();
        add(keyboard);
    }
}
