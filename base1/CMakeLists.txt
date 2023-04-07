cmake_minimum_required(VERSION 3.16)

project(base1 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

set(SOURCES main.cpp)
qt_add_resources(SOURCES resource.qrc)
qt_add_executable(videoPlayerQML ${SOURCES})

qt_add_qml_module(videoPlayerQML
    URI base1
    VERSION 1.0
    QML_FILES
        Main.qml
        FontText.qml
        Test.qml
)


set_target_properties(videoPlayerQML PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(videoPlayerQML
    PRIVATE Qt6::Quick
)

install(TARGETS videoPlayerQML
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})



