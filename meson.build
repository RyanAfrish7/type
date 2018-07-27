project(
    'com.github.ryanafrish7.type', 
    'vala', 'c',
    version: '0.0.0'
)

dependencies = [
    dependency ('gtk+-3.0')
]

conf_data = configuration_data()
conf_data.set('PROJECT_NAME', meson.project_name())

subdir('data')
subdir('src')
