#export VERSION=2.0.0-rc2 #- et väljund failis oleks versiooni number nimes

# export QML_SOURCES_PATHS=../../server


# NB! qt plugin must be dowloaded (to same directory as linuxdeploy): wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage

#vt näide lehelt: https://docs.appimage.org/packaging-guide/from-source/native-binaries.html#examples



linuxdeploy --appdir AppDir --executable=vclick-client --desktop-file=vclick-client.desktop  -i vclick-client.png  --plugin=qt  --output appimage
