# convert to cmake with: qmake2cmake vclick-client.pro --min-qt-version 6.3

TEMPLATE = app

lessThan(QT_MAJOR_VERSION,6): error("Qt6 is required for this build.")

VERSION = 3.1.3
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

DEFINES += QOSC_STATIC # to use qosc as just source files


#!NB use cmake to build for android qt Qt6! (supports multi-abi)
ANDROID_VERSION_NAME = $$VERSION
ANDROID_VERSION_CODE = 25 # build number
#ANDROID_APP_NAME = "vClick Client"


QT += qml quick widgets websockets multimedia
android: QT += core-private quickcontrols2

# comment out for build without OSC support (QML only, server discovery does not work)
# make sure to use correct emsdk version related to the Qt version https://doc.qt.io/qt-6/wasm.html

CONFIG += use_osc

SOURCES += main.cpp \
    serverdiscovery.cpp \

HEADERS +=  serverdiscovery.h \


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

# for mac universal build & Cmake see https://doc.qt.io/qt-6/macos.html#architectures
macx {
    ICON = vclick-client.icns
	QMAKE_APPLE_DEVICE_ARCHS = x86_64 arm64
}
win32: RC_FILE =  winicon.rc # for windows icon

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

    QMAKE_ASSET_CATALOGS += ios/Assets.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = AppIcon

    QMAKE_IOS_LAUNCH_SCREEN = ios/Launch.storyboard

}

macx {
    installer.path = $$PWD
    installer.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD -verbose=2   -sign-for-notarization=\"Developer ID Application: Tarmo Johannes (DRQ77GKK9V)\" -dmg # deployment
    #installer.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD -verbose=0 -dmg # deployment
    INSTALLS += installer

}

#MAC notarize:
# App  Specific password for vClickClient rwjw-dnen-sklo-zrtu
# xcrun notarytool submit --apple-id <id-email> --password <password> --team-id "DRQ77GKK9V" --wait
#staple: xcrun stapler staple vclick-client.dmg

win32 {
    first.path = $$PWD
    first.commands = $$[QT_INSTALL_PREFIX]/bin/windeployqt  -qmldir=$$PWD  $$OUT_PWD/$$DESTDIR/$${TARGET}.exe # first deployment
    INSTALLS += first
}
