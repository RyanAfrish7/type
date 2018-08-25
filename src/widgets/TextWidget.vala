class TextWidget : Gtk.Box {
    Gtk.TextView text_view;
    Gtk.TextBuffer buffer;

    Gtk.TextTag tag_previous;
    Gtk.TextTag tag_current;
    Gtk.TextTag tag_next;
    Gtk.TextTag tag_error;

    string text = "";
    int position = 0;

    Array<int> error_char_indexes;

    public TextWidget () {
        text_view = new Gtk.TextView ();
        get_style_context ().add_class ("text-widget");
        
        buffer = text_view.get_buffer ();

        text_view.editable = false;
        text_view.cursor_visible = false;
        text_view.sensitive = false;
        text_view.wrap_mode = Gtk.WrapMode.WORD_CHAR;

        tag_previous = buffer.create_tag ("previous", "weight", Pango.Weight.NORMAL);
        tag_current = buffer.create_tag ("current", "foreground", "#abacae", "background", "#fafafa", "weight", Pango.Weight.NORMAL);
        tag_next = buffer.create_tag ("next", "foreground", "#abacae", "weight", Pango.Weight.NORMAL);
        tag_next = buffer.create_tag ("error", "foreground", "#a10705", "weight", Pango.Weight.NORMAL);

        text_view.halign = Gtk.Align.CENTER;
        text_view.hexpand = true;
        text_view.width_request = 720;

        add(text_view);
    }

    public void set_text (string text) {
        this.text = text;
        this.position = 0;

        error_char_indexes = new Array<int>();

        this.update ();
    }

    public void set_position (int position) {
        this.position = position;
        
        this.update ();
    }

    public void add_error_char (int position) {
        error_char_indexes.append_val (position);
    }

    private void update () {
        Gtk.TextIter start_iter;
        Gtk.TextIter iter;

        this.buffer.set_text (this.text);

        this.buffer.get_start_iter (out start_iter);
        this.buffer.get_iter_at_offset (out iter, position);

        this.buffer.apply_tag_by_name ("previous", start_iter, iter);

        start_iter.forward_chars(position);
        iter.forward_char();

        this.buffer.apply_tag_by_name ("current", start_iter, iter);

        start_iter.forward_char();
        iter.forward_to_end();

        this.buffer.apply_tag_by_name ("next", start_iter, iter);

        foreach (int i in error_char_indexes.data) {
            this.buffer.get_iter_at_offset (out start_iter, i);
            this.buffer.get_iter_at_offset (out iter, i + 1);

            this.buffer.apply_tag_by_name("error", start_iter, iter);
        }
    }
}
