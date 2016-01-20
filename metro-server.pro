TEMPLATE = app

QT += qml quick widgets network websockets

INCLUDEPATH += /usr/local/include/csound

SOURCES += main.cpp \
    wsserver.cpp \
    jackreader.cpp \
    csoundhandler.cpp \
    csengine.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    wsserver.h \
    jackreader.h \
    csoundhandler.h \
    csengine.h

unix|win32: LIBS += -ljack -llo -lcsound64
