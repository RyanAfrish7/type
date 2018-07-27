public class TypeApplication : Gtk.Application {
    public TypeApplication() {
        Object(
            application_id: "com.github.ryanafrish7.type",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 640;
        main_window.default_width = 720;
        main_window.title = "Type";
        
        var label = new Gtk.Label ("Practice typing");
        main_window.add (label);

        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new TypeApplication ();
        return app.run (args);
    }
}