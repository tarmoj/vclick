TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    oschandler.cpp \
	qosc/qoscclient.cpp \
	qosc/qoscserver.cpp \
	qosc/qosctypes.cpp \
    settingshandler.cpp

RESOURCES += qml.qrc

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

HEADERS += \
	  oschandler.h \
	qosc/qoscclient.h \
	qosc/qoscserver.h \
	qosc/qosctypes.h \
    settingshandler.h

android {
	sounds.path = /assets
	sounds.files = sounds/*.wav
	INSTALLS += sounds
} else {
	QMAKE_POST_LINK += cp -rf $$PWD/sounds $$OUT_PWD # to copy sounds to the destination dir
}

