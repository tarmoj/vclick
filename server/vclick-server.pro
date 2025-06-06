lessThan(QT_MAJOR_VERSION,6): error("Qt6 is required for this build.")

TEMPLATE = app

VERSION = 3.1.1 # v3.1.0  - inroduce sending OSC to  DAW like reaper
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

CONFIG += c++17

#uncomment or add to qmake parameters to build console version of the server
#CONFIG += no-gui

no-gui {
    QT += core network websockets
    CONFIG += c++11 console
    CONFIG -= app_bundle
    QT -= gui
    DEFINES += CONSOLE_APP
    TARGET=$$TARGET-nogui
} else {
    QT += qml quick widgets network websockets
    #QT += multimedia #for testing
}



linux|android: INCLUDEPATH += /usr/local/include/csound
win32: INCLUDEPATH += "C:/Program Files/Csound6_x64/include/csound"#"$$(PROGRAMFILES)/Csound6/include/csound"
mac: INCLUDEPATH += /Library/Frameworks/CsoundLib64.framework/Headers

mac: {
    ICON = vclick-server.icns
	QMAKE_APPLE_DEVICE_ARCHS = x86_64 arm64
}

win32: RC_FILE =  winicon.rc # for windows icon

DESTDIR=bin #Target file directory
OBJECTS_DIR=generated_files #Intermediate object files directory
MOC_DIR=generated_files #Intermediate moc files directory

SOURCES += main.cpp \
    wsserver.cpp \ 
    csengine.cpp \
    qosc/qoscclient.cpp \
    qosc/qoscserver.cpp \
    qosc/qosctypes.cpp

RESOURCES += qml.qrc \
    cs.qrc \
    vclick-server.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
#include(deployment.pri)

HEADERS += \
    wsserver.h \
    csengine.h \
    qosc/qoscclient.h \
    qosc/qoscserver.h \
    qosc/qosctypes.h


win32: LIBS += -L"$$PWD/winlibs" #"C:/Program Files/Csound6_x64/bin" put csound64.lib there
linux:!android: LIBS += -lcsound64
win32-msvc: LIBS += csound64.lib

linux:!android:exists(/usr/lib64/libjack.so) {
    DEFINES += USE_JACK
    SOURCES += jackreader.cpp
    HEADERS += jackreader.h
    LIBS += -ljack
}

mac: {
LIBS += -F/Library/Frameworks/ -framework CsoundLib64
INCLUDEPATH += /Library/Frameworks/CsoundLib64.framework/Versions/6.0/Headers
# NB! copy libs from CsoundLib64.framework/libs to vclick-server bundle ? perhaps in release bundle step?
}


# android build not fixed to Qt6 yet. Plan to Drop it.
android {
  QT += androidextras
  INCLUDEPATH += /home/tarmo/src/csound6-git/Android/CsoundAndroid/jni/	 #TODO: should have an extra varaible, not hardcoded personal library
  HEADERS += AndroidCsound.hpp
  LIBS +=  -L/home/tarmo/src/csound-android-6.12.0/CsoundForAndroid/CsoundAndroid/src/main/jniLibs/armeabi-v7a/ -lcsoundandroid -lsndfile -lc++_shared -loboe
}

contains(ANDROID_TARGET_ARCH,armeabi-v7a) {
	ANDROID_EXTRA_LIBS = /home/tarmo/tarmo/programm/qt-projects/vClick/server/../../../../../src/csound-android-6.12.0/CsoundForAndroid/CsoundAndroid/src/main/jniLibs/armeabi-v7a/libc++_shared.so /home/tarmo/tarmo/programm/qt-projects/vClick/server/../../../../../src/csound-android-6.12.0/CsoundForAndroid/CsoundAndroid/src/main/jniLibs/armeabi-v7a/libcsoundandroid.so /home/tarmo/tarmo/programm/qt-projects/vClick/server/../../../../../src/csound-android-6.12.0/CsoundForAndroid/CsoundAndroid/src/main/jniLibs/armeabi-v7a/liboboe.so /home/tarmo/tarmo/programm/qt-projects/vClick/server/../../../../../src/csound-android-6.12.0/CsoundForAndroid/CsoundAndroid/src/main/jniLibs/armeabi-v7a/libsndfile.so
}

message("libraries: "$$LIBS "Headers: " $$INCLUDEPATH "Defines: " $$DEFINES "Target:" $$TARGET)

DISTFILES += \
    folder.png \
    winicon.rc \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat


macx {
    first.path = $$PWD
    first.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD # deployment

    second.path = $$OUT_PWD/$$DESTDIR/$${TARGET}.app/Contents/Frameworks
    second.files = /Library/Frameworks/CsoundLib64.framework
    #second.commands = rm -rf $$OUT_PWD/$$DESTDIR/$${TARGET}.app/Contents/Frameworks/CsoundLib64.framework/
    #TODO: remove Resources Java, Luajit, Manual, Opcodes64 enamus...  PD, Python, samples
    # remove lbCsoundAc, võibolla libcsnd6

    third.path = $$PWD
    third.commands = install_name_tool -change /Library/Frameworks/CsoundLib64.framework/CsoundLib64 @rpath/CsoundLib64.framework/Versions/6.0/CsoundLib64 $$OUT_PWD/$$DESTDIR/$${TARGET}.app/Contents/MacOS/vclick-server ;
    third.commands += install_name_tool -change /Library/Frameworks/CsoundLib64.framework/libs/libsndfile.1.dylib @rpath/CsoundLib64.framework/libs/libsndfile.1.dylib $$OUT_PWD/$$DESTDIR/$${TARGET}.app/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64

    final.path = $$PWD
    final.commands = $$[QT_INSTALL_PREFIX]/bin/macdeployqt $$OUT_PWD/$$DESTDIR/$${TARGET}.app -qmldir=$$PWD  -sign-for-notarization=\"Developer ID Application: Tarmo Johannes (DRQ77GKK9V)\" -dmg# deployment BETTER: use hdi-util
    #final.commands = hdiutil create -fs HFS+ -srcfolder $$OUT_PWD/$$DESTDIR/$${TARGET}.app -volname \"vClick Server\" $$OUT_PWD/$$DESTDIR/$${TARGET}.dmg

    INSTALLS += first second third  final #final don't forget second on first compile!!! (later makes sense to remove extra folders from Csound.Frameworks)

}

win32 {
    first.path = $$PWD
    first.commands = $$[QT_INSTALL_PREFIX]/bin/windeployqt  -qmldir=$$PWD  $$OUT_PWD/$$DESTDIR/$${TARGET}.exe # first deployment
    # second: copy dll-s from winlib and Csound bin
    # make dir plugins64 in output bin directory and copy rtpa.dll and osc.dll there
#missing libs after windeployqt: csound64.dll portaduio_x64.dll (to bin)
    # enne installeri tegemist kopeeri klientist kõik deployga sinna saanud failid serveri bin-i
	INSTALLS += first
}

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
