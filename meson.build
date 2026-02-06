project('getxkblayout', 'cpp')

x11_dep = dependency('X11')
xkbfile_dep = dependency('xkbfile')

executable('getxkblayout', 'src/getxkblayout.cpp', 'src/XAdapter.cpp', dependencies: [x11_dep, xkbfile_dep], install: true)
