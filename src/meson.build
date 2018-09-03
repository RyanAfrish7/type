type_files = files(
    'Application.vala',
    'MainWindow.vala',
    'core/KeyboardLayout.vala',
    'core/Lesson.vala',
    'core/Orchestrator.vala',
    'layouts/HomeLayout.vala',
    'widgets/KeyboardWidget.vala',
    'widgets/KeyWidget.vala',
    'widgets/TextWidget.vala'
)

config_file = configure_file(
    input: 'config.vala.in',
    output: 'config.vala',
    configuration: conf_data
)

executable(
    meson.project_name(),
    type_files,
    config_file,
    dependencies: dependencies,
    install: true
)
