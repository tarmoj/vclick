cmake_minimum_required(VERSION 3.16)
project(vclick-client VERSION 3.0.0 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Multimedia Qml Quick WebSockets Widgets)
find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS QuickControls2)

qt_standard_project_setup()

qt_add_executable(vclick-client WIN32 MACOSX_BUNDLE
    main.cpp
)
qt_add_qml_module(vclick-client
    URI vclick_client
    VERSION ${PROJECT_VERSION}
    QML_FILES
        main.qml
    RESOURCES
        qtquickcontrols2.conf
    NO_RESOURCE_TARGET_PATH
    OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/bin
)

target_compile_definitions(vclick-client PRIVATE
    APP_VERSION="3.0.0"
)

target_link_libraries(vclick-client PRIVATE
    Qt::Core
    Qt::Gui
    Qt::Multimedia
    Qt::Qml
    Qt::Quick
    Qt::WebSockets
    Qt::Widgets
)


# Resources:
set(vclick-client_resource_files
    "menu.png"
    "radio.png"
    "sounds/sound1.wav"
    "sounds/sound2.wav"
    "sounds/sound3.wav"
    "vclick-client.png"
    "xmark-solid.png"
)

qt_add_resources(vclick-client "vclick-client"
    PREFIX
        "/"
    FILES
        ${vclick-client_resource_files}
)

if(ANDROID)
    target_link_libraries(vclick-client PRIVATE
        Qt::CorePrivate
        Qt::QuickControls2
    )
    set(QT_ANDROID_BUILD_ALL_ABIS true)
endif()

if(use_osc)
    target_sources(vclick-client PUBLIC
        oschandler.cpp oschandler.h
        qosc/qoscclient.cpp qosc/qoscclient.h
        qosc/qoscserver.cpp qosc/qoscserver.h
        qosc/qosctypes.cpp qosc/qosctypes.h
    )

    target_compile_definitions(vclick-client PRIVATE
        USE_OSC
    )
endif()

if(IOS)
    target_sources(vclick-client PUBLIC
        ios-screen.h ios-screen.mm
    )

    target_link_libraries(vclick-client PRIVATE
        "-framework UIKit"
    )
endif()

#----

#target_link_libraries(appdeleteme-cmake
#    PRIVATE Qt6::Quick)

#install(TARGETS appdeleteme-cmake
#    BUNDLE DESTINATION .
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

# ----

install(TARGETS vclick-client
    BUNDLE DESTINATION .
    #RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}

)

qt_generate_deploy_qml_app_script(
    TARGET vclick-client
    FILENAME_VARIABLE deploy_script
    NO_UNSUPPORTED_PLATFORM_ERROR
    DEPLOY_USER_QML_MODULES_ON_UNSUPPORTED_PLATFORM
    MACOS_BUNDLE_POST_BUILD
)
install(SCRIPT ${deploy_script})
