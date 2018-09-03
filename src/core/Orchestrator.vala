class Orchestrator {
    KeyboardLayout layout;
    KeyboardWidget keyboard_ui;
    TextWidget text_widget;

    Lesson active_lesson;

    int position;
    bool caps_lock = false;

    public Orchestrator (KeyboardLayout layout, KeyboardWidget keyboard_ui, TextWidget text_widget) {
        this.layout = layout;
        this.keyboard_ui = keyboard_ui;
        this.text_widget = text_widget;

        start_lesson (new Lesson ("Never look back, reminiscing on yesterday, smile for future, tomorrow's a new day "));
    }

    public void start_lesson (Lesson lesson) {
        this.text_widget.set_text (lesson.get_text ());
        this.position = 0;
        this.active_lesson = lesson;

        refresh ();
    }

    public void end_lesson () {
        this.active_lesson = null;
    }

    private void refresh () {
        unichar a = this.active_lesson.get_text ().get_char (this.position);

        KeyboardLayout.Key current_key = this.layout.get_key_from_symbol (a.to_string ());

        keyboard_ui.set_key_pressed (current_key.key == a.to_string () ? current_key.name : current_key.mod_name);
        keyboard_ui.set_shift_pressed ((caps_lock && a.isalpha ()) != (current_key.mod_key == a.to_string ()), "Shift_R");

        this.text_widget.set_position (this.position);
    }

    public bool on_key_press (Gdk.EventKey event) {
        string keyval_name = Gdk.keyval_name (event.keyval);

        if (keyval_name == "BackSpace" && this.position > 0) {
            this.position -= 1;
            this.text_widget.remove_error_char (this.position);
            this.refresh ();
        } else if (!layout.get_key_from_name (keyval_name).is_nongraphic && this.active_lesson.get_text ().length > this.position) {
            KeyboardLayout.Key key = this.layout.get_key_from_name (keyval_name);

            unichar current_char = key.name == keyval_name ? key.key.get_char (0) : key.mod_key.get_char (0);

            if (current_char != this.active_lesson.get_text ().get_char (this.position)) {
                this.text_widget.add_error_char (this.position);
            }

            this.position += 1;
            this.refresh ();
        }

        return true;
    }

    public bool on_key_release (Gdk.EventKey event) {
        string keyval_name = Gdk.keyval_name (event.keyval);

        if (keyval_name == "Shift_L" || keyval_name == "Shift_R") {
            keyboard_ui.set_shift_pressed (false, keyval_name);
        }

        return true;
    }
}
