TEMPLATE = app

QT += qml quick widgets websockets

SOURCES += main.cpp \
    oschandler.cpp \
	qosc/qoscclient.cpp \
	qosc/qoscserver.cpp \
	qosc/qosctypes.cpp

RESOURCES += qml.qrc \
    eclick-client.qrc

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
    android/gradlew.bat

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
linux:	QMAKE_POST_LINK += cp -rf $$PWD/sounds $$OUT_PWD/$$DESTDIR # to copy sounds to the destination dir
win32: QMAKE_POST_LINK += copy "$$shell_path($$PWD/sounds/*)" "$$shell_path($$OUT_PWD/release/sounds)"
# ei tööta veel... use $$shell_path() http://stackoverflow.com/questions/14938577/convert-unix-path-to-windows-in-qmake-script
macx {
    sounds.path = Contents/Resources
    sounds.files = sounds
    QMAKE_BUNDLE_DATA += sounds

    }
}

