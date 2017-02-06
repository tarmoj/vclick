TEMPLATE = app
#TARGET += "eClickServer"

QT += qml quick widgets network websockets
QT += multimedia #for testing

linux: INCLUDEPATH += /usr/local/include/csound
win32: INCLUDEPATH += "C:/Program Files/Csound6_x64/include/csound"#"$$(PROGRAMFILES)/Csound6/include/csound"
mac: INCLUDEPATH += /Library/Frameworks/CsoundLib64.framework/Headers

mac: ICON = eclick-server.icns
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

linux: SOURCES += jackreader.cpp

RESOURCES += qml.qrc \
    cs.qrc \
    eclick-server.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    wsserver.h \
    csengine.h \
    qosc/qoscclient.h \
    qosc/qoscserver.h \
    qosc/qosctypes.h

linux: HEADERS +=  jackreader.h

win32: LIBS += -L "$$PWD/winlibs" #"C:/Program Files/Csound6_x64/bin" put linsndfile-1.dll and csound64.dll here
linux|win32: LIBS += -lcsound64
linux: LIBS += -ljack

mac: {
LIBS += -F/Library/Frameworks/ -framework CsoundLib64
INCLUDEPATH += /Library/Frameworks/CsoundLib64.framework/Versions/6.0/Headers
# NB! copy libs from CsoundLib64.framework/libs to eclick-server bundle ? perhaps in release bundle step?
}

message("libraries: "$$LIBS "Headers: " $$INCLUDEPATH)

DISTFILES += \
    winicon.rc

#win32: QMAKE_POST_LINK += copy "$$shell_path($$PWD/eclick-server.bat)" "$$shell_path($$OUT_PWD/$$DESTDIR/)" # a workaround script for win8 and possibly other versions

