BUILD_DIR="../build-vclick-server-Qt_6_5_3_for_macOS-Release/bin"
APP="vclick-server.app"
DMG="vclick-server-MacOS.dmg"

#sign
codesign --options=runtime --timestamp  --force --deep --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" $BUILD_DIR/$APP

#OR maybe:
#codesign --options=runtime --timestamp  --force --deep --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" $BUILD_DIR/$APP/Contents/Frameworks/CsoundLib64.framework/CsoundLib64

#find $BUILD_DIR/$APP/Contents/Frameworks/CsoundLib64.framework/Versions/6.0/Resources/libs -name "*.dylib" -exec codesign --force  --sign "Developer ID Application: Tarmo Johannes (DRQ77GKK9V)" {} \;

hdiutil create -fs HFS+ -srcfolder $BUILD_DIR/$APP -volname "vClick Server" $BUILD_DIR/$DMG

#notarize:
xcrun notarytool submit --apple-id "trmjhnns@gmail.com" --password "bcuk-uufc-kxcc-wffw" --team-id "DRQ77GKK9V" --wait $BUILD_DIR/$DMG

# log:
xcrun notarytool log 2a65e696-aef7-4609-a958-941ae0b9914e  --apple-id "trmjhnns@gmail.com" --password "bcuk-uufc-kxcc-wffw" --team-id "DRQ77GKK9V"

#staple
xcrun stapler staple $BUILD_DIR/$DMG




