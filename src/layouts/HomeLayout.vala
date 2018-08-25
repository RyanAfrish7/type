class HomeLayout : Gtk.Stack {
    Gtk.Box vertical_layout;
    KeyboardWidget keyboard_widget;
    TextWidget text_widget;

    construct {
        vertical_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 14);
        add (vertical_layout);

        text_widget = new TextWidget ();
        vertical_layout.add (text_widget);

        text_widget.set_text ("Life is not a problem to be solved, but a reality to be experienced.");
        text_widget.set_position (10);
        text_widget.margin = 16;

        keyboard_widget = new KeyboardWidget (Build.DATA_DIR + "/layouts/qwerty_us.json");
        vertical_layout.add (keyboard_widget);

        keyboard_widget.grab_focus ();
    }
}
