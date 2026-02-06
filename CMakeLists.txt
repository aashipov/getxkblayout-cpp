cmake_minimum_required(VERSION 3.15)
project(getxkblayout)

set(CMAKE_CPP_STANDARD 17)
set(CMAKE_CPP_FLAGS_RELEASE "-O3")
find_package(X11 REQUIRED)

add_executable(${PROJECT_NAME} src/${PROJECT_NAME}.cpp src/XAdapter.cpp)

if(NOT X11_FOUND)
    MESSAGE(FATAL_ERROR "No X11 development files not found")
elseif(NOT X11_Xkbfile_FOUND)
    MESSAGE(FATAL_ERROR "xkbfile development files not found")
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE X11 X11::xkbfile)

install(TARGETS ${PROJECT_NAME} DESTINATION bin)

add_custom_target(uninstall
    COMMAND ${CMAKE_COMMAND} -E rm -rf ${CMAKE_INSTALL_PREFIX}/bin/${PROJECT_NAME}
)
