class HomeLayout : Gtk.Stack {
    Gtk.Box vertical_layout;
    KeyboardWidget keyboard_widget;
    TextWidget text_widget;
    Orchestrator keyboard_event_mapper;

    construct {
        vertical_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 14);
        add (vertical_layout);

        text_widget = new TextWidget ();
        vertical_layout.add (text_widget);

        text_widget.set_text ("");
        text_widget.set_position (10);
        text_widget.margin = 16;

        keyboard_widget = new KeyboardWidget (Build.DATA_DIR + "/layouts/qwerty_us.json");
        vertical_layout.add (keyboard_widget);

        keyboard_event_mapper = new Orchestrator (keyboard_widget.get_keyboard_layout(), keyboard_widget, text_widget);
        
        this.set_can_focus (true);
        this.add_events (Gdk.EventMask.KEY_PRESS_MASK);
        this.add_events (Gdk.EventMask.KEY_RELEASE_MASK);

        this.key_press_event.connect (keyboard_event_mapper.on_key_press);
        this.key_release_event.connect (keyboard_event_mapper.on_key_release);

        this.grab_focus ();
    }
}
