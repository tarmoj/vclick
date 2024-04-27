#!/bin/bash

# Script to make AppImage (all-included binary) for 64 bit linux
# ecperimental
# option to include Also Csound and Csound manual


# change according to your own sysem
# constants


BINARY="vclick-server"
BUILD_DIR="../build-vclick-server-Desktop_Qt_6_5_1_GCC_64bit-Release/bin/"
# EXECUTABLE="$BUILD_DIR/bin/$BINARY"
EXECUTABLE="$BUILD_DIR/$BINARY"
VERSION="3.1.0"
CSOUND_PREFIX="/usr/local"
CSOUND_PLUGINS_DIR="$CSOUND_PREFIX/lib/csound/plugins64-6.0" 
BUNDLE_CSOUND=true # for now: always bundle Csound
SRC_DIR=".." 
LIB_DIR="/usr/lib"
APP_DIR="AppDir" # "$BUILD_DIR/AppDir"


# download linuxdeploy and its Qt plugin
#in my case they are installed in path already
#wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
#wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage


LINUXDEPLOY="$HOME/bin/linuxdeploy-x86_64.AppImage"
#LINUXDEPLOY=$(which linuxdeploy-x86_64.AppImage)

#1 export necessary environment variables
export VERSION=$VERSION 
export QML_SOURCES_PATHS="$SRC_DIR"; 
export QMAKE=/home/tarmo/src/Qt/6.5.1/gcc_64/bin/qmake # for Qt6

# correct desktop file -  instead of csoundqt as command use the actual binary name
#TODO: desktop file path should be changed somehow! Not sure if it matters however...
#sed "s/Exec=csoundqt/Exec=$BINARY/g" $SRC_DIR/csoundqt.desktop > csoundqt.desktop

# 2 create initial AppDir with linuxdeploy
# TODO: cannot blacklist csound libs.blacklist nor -blacklist flag work...
#LIBPORTMIDI=$(locate --limit 1 libportmidi.so)


$LINUXDEPLOY --appdir $APP_DIR --executable=$EXECUTABLE --desktop-file=vclick-server.desktop  --icon-file=vclick-server.png 

linuxdeploy-plugin-qt-x86_64.AppImage --appdir AppDir # QT business. Forr Qt6 does not work as --plugin=qt


# copy Csound binary, plugins and and Csound Manual - probably copied by default
mkdir -p  $APP_DIR/usr/lib/csound
cp -r $CSOUND_PLUGINS_DIR $APP_DIR/usr/lib/csound

#create hook to set Csound Plugins Dir environment

mkdir -p $APP_DIR/apprun-hooks
echo 'export OPCODE6DIR64="${APPDIR}/usr/lib/csound/plugins64-6.0/"' >  $APP_DIR/apprun-hooks/csound-plugins-hook.sh

# and create final AppImage
$LINUXDEPLOY --appdir $APP_DIR --executable=$EXECUTABLE  --icon-file=vclick-server.png  --desktop-file=vclick-server.desktop --output appimage # --desktop-file=vclick-server.desktop


