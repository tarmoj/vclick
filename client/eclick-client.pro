TEMPLATE = app

QT += qml quick widgets websockets multimedia

SOURCES += main.cpp \
    oschandler.cpp \
	qosc/qoscclient.cpp \
	qosc/qoscserver.cpp \
	qosc/qosctypes.cpp

RESOURCES += qml.qrc \
    eclick-client.qrc

macx: ICON = eclick-client.icns
win32: RC_FILE =  winicon.rc # for windows icon


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
	qosc/qosctypes.h

android {
	sounds.path = /assets
	sounds.files = sounds/*.wav
	INSTALLS += sounds
} else {
# linux:	QMAKE_POST_LINK += cp -rf $$PWD/sounds $$OUT_PWD/$$DESTDIR # to copy sounds to the destination dir
# win32: QMAKE_POST_LINK += copy "$$shell_path($$PWD/sounds/*)" "$$shell_path($$OUT_PWD/release/bin/sounds)"

# ei tööta veel... use $$shell_path() http://stackoverflow.com/questions/14938577/convert-unix-path-to-windows-in-qmake-script
macx {
    sounds.path = Contents/Resources
    sounds.files = sounds
    QMAKE_BUNDLE_DATA += sounds

    }
}

ios {
    QMAKE_INFO_PLIST = ios/Info.plist
    ios_icon.files = $$files($$PWD/ios/icons/*.png)
    QMAKE_BUNDLE_DATA += ios_icon
    sounds.files = sounds
    QMAKE_BUNDLE_DATA += sounds
    app_launch_images.files = $$PWD/ios/Launch.storyboard #$$files($$PWD/ios/launchimages/LaunchImage*.png) #$$PWD/ios/Launch.xib
    QMAKE_BUNDLE_DATA += app_launch_images

}

