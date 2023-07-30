#export VERSION=2.0.0-rc2 #- et väljund failis oleks versiooni number nimes

# export QML_SOURCES_PATHS=../../server


# NB! qt plugin must be dowloaded (to same directory as linuxdeploy): wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage

#vt näide lehelt: https://docs.appimage.org/packaging-guide/from-source/native-binaries.html#examples

# qt-plugin page: https://github.com/linuxdeploy/linuxdeploy-plugin-qt

# copy desktop and vclick-cleint.png to bin dir 
# check .desktop for right paths

# for Qt6 set more parametes...

export QMAKE=/home/tarmo/src/Qt/6.5.1/gcc_64/bin/qmake
#$QML_MODULES_PATHS


export QML_SOURCES_PATHS=../../client

linuxdeploy --appdir AppDir --executable=vclick-client --desktop-file=vclick-client.desktop  -i vclick-client.png  

linuxdeploy-plugin-qt-x86_64.AppImage --appdir AppDir

# somehow --plugin qt does not work, it will not find right qt
linuxdeploy --appdir AppDir  --output appimage
