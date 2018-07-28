install_data(
    meson.project_name() + '.desktop',
    install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
    meson.project_name() + '.appdata.xml',
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

install_subdir(
    'layouts',
    install_dir: join_paths(get_option('datadir'), meson.project_name())
)

install_subdir(
    'ui',
    install_dir: join_paths(get_option('datadir'), meson.project_name())
)

