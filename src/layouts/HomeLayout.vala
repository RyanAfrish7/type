class HomeLayout : Gtk.Stack {
    KeyboardWidget keyboard;

    construct {
        keyboard = new KeyboardWidget(Build.DATA_DIR + "/layouts/qwerty_us.json");
        add(keyboard);
    }
}
