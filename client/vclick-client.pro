TEMPLATE = app

QT += qml quick widgets websockets multimedia
android: QT += androidextras

# uncomment for build without OSC support (QML only)
# for webassembly compile with command (in terminal):
# /home/tarmo/src/Qt/5.15.2/wasm_32/bin/qmake && make -j8

CONFIG += use_osc

SOURCES += main.cpp

use_osc: {

SOURCES +=     oschandler.cpp \
        qosc/qoscclient.cpp \
        qosc/qoscserver.cpp \
        qosc/qosctypes.cpp \

DEFINES += USE_OSC

}


RESOURCES += qml.qrc \
    vclick-client.qrc

macx: ICON = vclick-client.icns
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
include(deployment.pri)

DISTFILES += \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/AndroidManifest.xml \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    winicon.rc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DESTDIR=bin #Target file directory
OBJECTS_DIR=generated_files #Intermediate object files directory
MOC_DIR=generated_files #Intermediate moc files directory

HEADERS += \
	  oschandler.h \
	qosc/qoscclient.h \
	qosc/qoscserver.h \
	qosc/qosctypes.h \


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
