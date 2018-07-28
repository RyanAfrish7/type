class MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Gtk.Application app) {
        Object (application: app);
    }

    construct {
        default_height = 640;
        default_width = 720;
        title = "Type";

        var label = new Gtk.Label ("Practice Typing!");
        add(label);
    }
}