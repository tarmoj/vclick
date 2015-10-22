TEMPLATE = app

QT += qml quick widgets network websockets

SOURCES += main.cpp \
    wsserver.cpp \
    jackreader.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    wsserver.h \
    jackreader.h

unix|win32: LIBS += -ljack -llo
