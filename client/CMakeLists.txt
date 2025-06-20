cmake_minimum_required(VERSION 3.16)
project(vclick-client VERSION 3.1.3 LANGUAGES C CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Multimedia Qml Quick WebSockets Widgets)
find_package(Qt${QT_VERSION_MAJOR} OPTIONAL_COMPONENTS QuickControls2)

qt_standard_project_setup()


SET(use_osc TRUE)


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
    SOURCES serverdiscovery.h serverdiscovery.cpp
)

target_compile_definitions(vclick-client PRIVATE
    APP_VERSION="${PROJECT_VERSION}"
)

message("APP VERSION: ${PROJECT_VERSION}")

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

# very good platform for android testing (different models and OSs virtually: https://appetize.io/
if(ANDROID)
    target_link_libraries(vclick-client PRIVATE
        Qt::CorePrivate
        Qt::QuickControls2
    )

    set_property(TARGET vclick-client APPEND PROPERTY
        QT_ANDROID_PACKAGE_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/android
    )

# TRY something like  - does not seem to work
#set_property(TARGET vclick-client APPEND PROPERTY QT_ANDROID_BUILD_ALL_ABIS true) # does not seem to affect
#set_property(TARGET vclick-client APPEND PROPERTY QT_ANDROID_VERSION_NAME ${APP_VERSION})
#set_property(TARGET vclick-client APPEND PROPERTY QT_ANDROID_VERSION_CODE 22)

set_target_properties(vclick-client PROPERTIES
            QT_ANDROID_VERSION_CODE 26
            QT_ANDROID_BUILD_ALL_ABIS true
            QT_ANDROID_VERSION_NAME ${PROJECT_VERSION}
        )

endif()


#message("TEST MESSAGE message ${use_osc} ${QT_ANDROID_VERSION_CODE}")

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


install(TARGETS vclick-client
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
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

