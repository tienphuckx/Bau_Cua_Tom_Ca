cmake_minimum_required(VERSION 3.16)

project(Sep_18_Lottery_Game VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appSep_18_Lottery_Game
    main.cpp
)

qt_add_qml_module(appSep_18_Lottery_Game
    URI Sep_18_Lottery_Game
    VERSION 1.0
    QML_FILES
        Main.qml
        RESOURCES resource.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSep_18_Lottery_Game PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSep_18_Lottery_Game
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSep_18_Lottery_Game
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appSep_18_Lottery_Game
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
