BUILD_DIR="../build-vclick-server-Qt_6_5_3_for_macOS-Release/bin"
APP="vclick-server.app"

find $BUILD_DIR/$APP/Contents/Frameworks/CsoundLib64.framework/libs -name "*.dylib" -exec codesign --force --timestamp  --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" {} \;

find $BUILD_DIR/$APP/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/Resources/Opcodes64 -name "*.dylib" -exec codesign --force --timestamp  --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" {} \;

codesign --options=runtime --timestamp  --force --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" $BUILD_DIR/$APP/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/CsoundLib64

codesign --options=runtime --timestamp  --force --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" $BUILD_DIR/$APP

#check:
codesign -vvv --deep --strict $BUILD_DIR/$APP

# ha - unsealed contents present in the root directory of an embedded framework In subcomponent: vclick-server.app/Contents/Frameworks/CsoundLib64.framework -- problem with libs there.


