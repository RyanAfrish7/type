class MainWindow : Gtk.ApplicationWindow {
    HomeLayout home_layout;

    public MainWindow (Gtk.Application app) {
        Object (application: app);
    }

    construct {
        default_height = 640;
        default_width = 720;
        title = "Type";

        home_layout = new HomeLayout();
        add(home_layout);
    }
}
