public class TypeApplication : Gtk.Application {
    MainWindow main_window;

    public TypeApplication() {
        Object(
            application_id: Build.PROJECT_NAME,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        if (main_window == null) {
            main_window = new MainWindow(this);

            add_window(main_window);
            main_window.show_all();
        } else {
            main_window.present();
        }
    }

    public static int main (string[] args) {
        var app = new TypeApplication ();
        return app.run (args);
    }
}