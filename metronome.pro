TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    oschandler.cpp \
    src/qoscclient.cpp \
    src/qoscserver.cpp \
    src/qosctypes.cpp

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
    src/qoscclient.h \
    src/qoscserver.h \
    src/qosctypes.h
