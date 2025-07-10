#export VERSION=2.0.0-rc2 #- et väljund failis oleks versiooni number nimes



# NB! qt plugin must be dowloaded (to same directory as linuxdeploy): wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage

#vt näide lehelt: https://docs.appimage.org/packaging-guide/from-source/native-binaries.html#examples

# qt-plugin page: https://github.com/linuxdeploy/linuxdeploy-plugin-qt
#$QML_MODULES_PATHS

# copy desktop and vclick-cleint.png to bin dir 
# check .desktop for right paths

BINARY="vclick-client"
BUILD_DIR="./build/Desktop_Qt_6_5_2_GCC_64bit-Release/bin/"
EXECUTABLE="$BUILD_DIR/$BINARY"
SRC_DIR="./"

# for Qt6 set more parametes...

export LINUXDEPLOY_OUTPUT_VERSION="3.1.3"
export QMAKE=/home/tarmo/src/Qt/6.5.2/gcc_64/bin/qmake


export QML_SOURCES_PATHS=$SRC_DIR  #"../../client" # as seeing from  BUILD_DIR

#TODO:
# cp $SRC_DIR/vclick-client.desktop $BUILD_DIR
# cp $SRC_DIR/vclick-client.png $BUILD_DIR

#cd $BUILD_DIR

export LD_LIBRARY_PATH=/home/tarmo/src/Qt/6.5.2/gcc_64/lib:$LD_LIBRARY_PATH
export APPIMAGELAUNCHER_DISABLE=1
 

linuxdeploy --appdir AppDir --executable=$EXECUTABLE -d vclick-client.desktop  -i vclick-client.png  

$HOME/bin/linuxdeploy-plugin-qt-x86_64.AppImage --appdir AppDir

# somehow --plugin qt does not work, it will not find right qt
linuxdeploy --appdir AppDir  --output appimage
