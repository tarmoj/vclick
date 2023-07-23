TEMPLATE = app


VERSION = 2.1.2
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

ANDROID_VERSION_NAME = $$VERSION
ANDROID_VERSION_CODE = 19 # build number
#ANDROID_APP_NAME = "vClick Client"


QT += qml quick widgets websockets multimedia
android: QT += core-private quickcontrols2

# comment out for build without OSC support (QML only)
# for webassembly compile with command (in terminal):
# /home/tarmo/src/Qt/5.15.2/wasm_32/bin/qmake && make -j8

#CONFIG += use_osc

SOURCES += main.cpp

use_osc: {

SOURCES +=     oschandler.cpp \
        qosc/qoscclient.cpp \
        qosc/qoscserver.cpp \
        qosc/qosctypes.cpp \

HEADERS += \
          oschandler.h \
        qosc/qoscclient.h \
        qosc/qoscserver.h \
        qosc/qosctypes.h \

DEFINES += USE_OSC

}


RESOURCES += qml.qrc \
    vclick-client.qrc

macx: ICON = vclick-client.icns
win32: RC_FILE =  winicon.rc # for windows icon
un
ios {
CONFIG -= bitcode
HEADERS += ios-screen.h
OBJECTIVE_SOURCES += \
    ios-screen.mm
LIBS += -framework UIKit # maybe not necessary, maybe done automatically by Qt...

}

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

DISTFILES += \
    android/AndroidManifest.xml \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/build.gradle \
    android/gradle.properties \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew \
    android/gradlew.bat \
    android/gradlew.bat \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-hdpi/logo.png \
    android/res/drawable-hdpi/logo_land.png \
    android/res/drawable-hdpi/logo_port.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-ldpi/logo.png \
    android/res/drawable-ldpi/logo_port.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-mdpi/logo.png \
    android/res/drawable-mdpi/logo_land.png \
    android/res/drawable-mdpi/logo_port.png \
    android/res/drawable-xhdpi/icon.png \
    android/res/drawable-xhdpi/logo.png \
    android/res/drawable-xhdpi/logo_land.png \
    android/res/drawable-xhdpi/logo_port.png \
    android/res/drawable-xxhdpi/icon.png \
    android/res/drawable-xxhdpi/logo.png \
    android/res/drawable-xxhdpi/logo_land.png \
    android/res/drawable-xxhdpi/logo_port.png \
    android/res/drawable-xxxhdpi/icon.png \
    android/res/drawable-xxxhdpi/logo.png \
    android/res/drawable-xxxhdpi/logo_land.png \
    android/res/drawable-xxxhdpi/logo_port.png \
    android/res/drawable/splashscreen.xml \
    android/res/drawable/splashscreen_land.xml \
    android/res/drawable/splashscreen_port.xml \
    android/res/values-land/splashscreentheme.xml \
    android/res/values-port/splashscreentheme.xml \
    android/res/values/libs.xml \
    android/res/values/libs.xml \
    android/res/values/splashscreentheme.xml \
    winicon.rc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DESTDIR=bin #Target file directory
#OBJECTS_DIR=generated_files #Intermediate object files directory
#MOC_DIR=generated_files #Intermediate moc files directory # needed to comment it out for android multi-abi build


ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    ios_icon.files = $$files($$PWD/ios/icons/AppIcon.appiconset/*.png)
    ios_icon.files += $$files($$PWD/ios/icons/Itunes*.png)
    QMAKE_BUNDLE_DATA += ios_icon
    app_launch_images.files = $$PWD/ios/Launch.storyboard #$$files($$PWD/ios/launchimages/LaunchImage*.png) #$$PWD/ios/Launch.xib
    QMAKE_BUNDLE_DATA += app_launch_images

}

macx {
    installer.path = $$PWD
    installer.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD -verbose=0  -codesign=\"Mac Developer: Tarmo Johannes (ND7C9HZ522)\" -dmg # deployment
    INSTALLS += installer

}

win32 {
    first.path = $$PWD
    first.commands = $$[QT_INSTALL_PREFIX]/bin/windeployqt  -qmldir=$$PWD  $$OUT_PWD/$$DESTDIR/$${TARGET}.exe # first deployment
    INSTALLS += first
}
