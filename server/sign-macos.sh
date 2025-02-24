BUILD_DIR="../build-vclick-server-Qt_6_5_3_for_macOS-Release/bin"
APP="vclick-server.app"
DMG="vclick-server-3.1.1-MacOS.dmg"

#notarize:
xcrun notarytool submit --apple-id "trmjhnns@gmail.com" --password "bcuk-uufc-kxcc-wffw" --team-id "DRQ77GKK9V" --wait $BUILD_DIR/$DMG

# log:
xcrun notarytool log 2a65e696-aef7-4609-a958-941ae0b9914e  --apple-id "trmjhnns@gmail.com" --password "bcuk-uufc-kxcc-wffw" --team-id "DRQ77GKK9V"

#staple
xcrun stapler staple $BUILD_DIR/$DMG




