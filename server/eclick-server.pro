TEMPLATE = app

QT += qml quick widgets network websockets

unix: INCLUDEPATH += /usr/local/include/csound
win32: INCLUDEPATH += "$$(PROGRAMFILES)\\Csound6\\include\\csound"

SOURCES += main.cpp \
    wsserver.cpp \ 
    csengine.cpp \
    qosc/qoscclient.cpp \
    qosc/qoscserver.cpp \
    qosc/qosctypes.cpp

unix: SOURCES += jackreader.cpp

RESOURCES += qml.qrc \
    cs.qrc

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

unix: HEADERS +=  jackreader.h

win32: LIBS += -L "$$(PROGRAMFILES)\\Csound6\\bin"
unix|win32: LIBS += -lcsound64
unix: LIBS += -ljack

message("libraries: "$$LIBS)

