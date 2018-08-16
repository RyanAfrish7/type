class MainWindow : Gtk.ApplicationWindow {
    HomeLayout home_layout;

    public MainWindow (Gtk.Application app) {
        Object (application: app);

        var css_provider = Gtk.CssProvider.get_default ();
        css_provider.load_from_file (File.new_for_path (Build.DATA_DIR + "/ui/custom.css"));

        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), css_provider, 600);
    }

    construct {
        default_height = 640;
        default_width = 720;
        title = "Type";

        home_layout = new HomeLayout ();
        add (home_layout);
    }
}
