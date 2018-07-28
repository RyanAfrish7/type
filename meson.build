project(
    'com.github.ryanafrish7.type', 
    'vala', 'c',
    version: '0.0.0'
)

dependencies = [
    dependency ('gee-0.8'),
    dependency ('gio-2.0'),
    dependency ('glib-2.0'),
    dependency ('gtk+-3.0'),
    dependency ('json-glib-1.0')
]

conf_data = configuration_data()
conf_data.set('PROJECT_NAME', meson.project_name())
conf_data.set('DATA_DIR', join_paths(get_option('prefix'), get_option('datadir'), meson.project_name()))

subdir('data')
subdir('src')
