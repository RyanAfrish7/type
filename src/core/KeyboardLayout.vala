class KeyboardLayout {
    public class Key {
        public string key;
        public string name;

        public int row;
        public int width;

        public bool is_nongraphic;

        public Key.from_json_node (Json.Node root) {
            Json.Object obj = root.get_object ();

            name = obj.get_string_member ("name");
            key = obj.get_string_member ("key");
            row = (int) obj.get_int_member ("row");
            width = (int) obj.get_int_member ("width");

            if(obj.has_member("is_nongraphic")) {
                is_nongraphic = obj.get_boolean_member ("is_nongraphic");
            }
        }
    }

    public string name;
    public int margin;
    public int key_height;
    public Array<Key> keys = new Array<Key>();

    public KeyboardLayout.from_json_node (Json.Node root) {
        unowned Json.Object obj = root.get_object ();

        this.name = obj.get_string_member ("name");
        this.margin = (int) obj.get_int_member ("margin");
        this.key_height = (int) obj.get_int_member ("key_height");

        unowned Json.Array keys = obj.get_array_member ("keys");

        foreach (unowned Json.Node item in keys.get_elements ()) {
            this.keys.append_val (new Key.from_json_node (item));
        }
    }

    public KeyboardLayout.from_json_string (string json) {
        var parser = new Json.Parser ();

        parser.load_from_data (json);
        this.from_json_node (parser.get_root ());
    }

    public KeyboardLayout.from_json_file (File file) {
        var json = new StringBuilder ();
        var dis = new DataInputStream (file.read ());

        string line;
        while ((line = dis.read_line_utf8 ()) != null) {
            json.append (line);
            json.append_c ('\n');
        }

        this.from_json_string (json.str);
    }
}
