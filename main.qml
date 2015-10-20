import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Qt.WebSockets 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    title: qsTr("WS-metronome")
    width: 480
    height: 640
    visible: true
    property real beatLength: 1

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Toggle test leds")
                onTriggered: testRow.visible = !testRow.visible // messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }



    WebSocket {
        id: socket
        url: serverAddress.text //"ws://192.168.1.220:6006/ws"
        onTextMessageReceived: {
            console.log("Received message: ",message);
            var messageParts = message.trim().split(" ") // format: csound: led %d  duration %f channels %d  OR csound: bar %d beat %d channels %d\
            if (messageParts[0]==="b") {
                barLabel.text = messageParts[1]
                beatLabel.text = messageParts[2]

            }
            if (messageParts[0]==="l") {
                var led = parseInt( messageParts[1] );
                beatLength = parseFloat(messageParts[2]); // TODO - enable different durations for different beats
                if (led===0) redAnimation.restart()

                if (led===1) greenAnimation.restart()
                if (led===2) blueAnimation.restart()

            }


        }
        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                             socket.active = false;
                             connectButton.enabled = true;
                             connectButton.text = qsTr("Connect")
                         } else if (socket.status == WebSocket.Open) {
                             console.log("Socket open")
                             connectButton.enabled = false;
                             connectButton.text = qsTr("Connected")
                             //socket.sendTextMessage("Hello World")
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                             socket.active = false;
                             connectButton.enabled = true;
                             connectButton.text = qsTr("Connect")
                             //messageBox.text += "\nSocket closed"
                         }
                        else if (socket.status == WebSocket.Connecting) {
                             connectButton.enabled = false;
                             connectButton.text = qsTr("Connecting")
                         }

        active: false
    }


    Component.onCompleted: {
        socket.active = true;
    }

    Rectangle {
        id: mainRect
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#a9a9a9"
            }

            GradientStop {
                position: 0.262
                color: "#000000"
            }
            GradientStop {
                position: 0.837
                color: "#000000"
            }
            GradientStop {
                position: 1
                color: "#a9a9a9"
            }
        }
        anchors.fill: parent



        Row {
            x:5; y:5
            id: serverRow
            spacing: 5

            Label {
                text: qsTr("Server: ")
            }

            TextField {
                id: serverAddress
                width: 200
                text: "ws://192.168.1.220:6006/ws"
            }

            Button {
                id: connectButton
                //checked:  //socket.active
               //võibolla varem oli pare, kui enabled - socket.active
                enabled: true //socket.active
                //checkable: true
                text: qsTr("Connect")
                onClicked: {
                    if (!socket.active) {
                        //socket.url = serverAddress.text
                        //console.log("Connecting to ",socket.url)
                        socket.active =  true; // miks error QNativeSocketEngine::write() was not called in QAbstractSocket::ConnectedState - vaja vajutada 2 korda
                    }
                }
            }


        }


        RowLayout {
            id: beatRow
            anchors.top:serverRow.bottom
            anchors.topMargin: 5
            spacing: 60
            anchors.horizontalCenter: parent.horizontalCenter
            height: mainRect.height * 0.25
//            anchors.bottom: ledRow.top
//            anchors.bottomMargin: 5


            Label {
                id: barLabel
                color: "ghostwhite" //"#d6d6d6"
                //x: 62
                //y: 43
                Layout.fillHeight:  true
                Layout.alignment: Qt.AlignCenter
                text: "0"
                font.bold: true
                style: Text.Normal
                font.pointSize: parent.height*0.75
            }



            Label {
                id: beatLabel
                property var colors: ["white","red","greenyellow", "lightgreen", "green", "darkgreen", "forestgreen", "forestgreen", "forestgreen", "forestgreen"  ]
                color: colors[parseInt(text)] // different color for every beat. text must contain the beatnumber
                Layout.fillHeight:  true
                Layout.alignment: Qt.AlignCenter
                text: "0"
                font.bold: true
                font.pointSize: parent.height*0.75
            }

        }



        //        NumberAnimation {
        //            id: anim1
        //            target: redLed
        //            property: "width"
        //            duration: 200
        //            from: 100
        //            to: 10
        //            easing.type: Easing.Linear
        //        }

        //NumberAnimation on width { from: mainRect.width * 0.25 ; to : mainRect.width *0.1; duration }

        ColorAnimation {target: redLed; properties: "color";  id: globColor; from: target.bright ;to: target.dark; duration:  beatLength *1000}
         NumberAnimation {target: redLed; easing.type: Easing.Linear; properties: "width"; id: globWidth;from: mainRect.width*0.28; to: mainRect.width*0.1; duration:beatLength *1000}

        Row{
            id: ledRow
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: beatRow.bottom
            anchors.topMargin: 10
            spacing: 10

            Item {
                id: led1
                width: mainRect.width *0.28
                height: width

                Rectangle {
                    id: redLed
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    width: mainRect.width *0.1
                    height: width
                    color: "#5c0303"
                    radius: width/2
                    border.width: 1
                    border.color: "#ffea44"
                    property color bright: "red"
                    property color dark: "#5c0303"
                    // TOO: beatLength here - local

                    ParallelAnimation {
                        id: redAnimation
                        ColorAnimation {target: redLed; properties: "color";  from: target.bright ;to: target.dark; duration:  beatLength *1000}
                        NumberAnimation {target: redLed;  properties: "width";from: mainRect.width*0.28; to: mainRect.width*0.1; duration:beatLength *1000}
                    }

                }


            }

            Item {
                id: led2
                width: mainRect.width *0.28
                height: width

                Rectangle {
                    id: greenLed
                    width: mainRect.width *0.1
                    anchors.centerIn: parent
                    height: width
                    radius: width/2
                    border.color: "#ffea44"
                    color: "#092d23"
                    property color bright: "green"
                    property color dark: "#092d23"

                    ParallelAnimation {
                        id: greenAnimation
                        ColorAnimation {target: greenLed; properties: "color";  from: target.bright ;to: target.dark; duration:  beatLength *1000}
                        NumberAnimation {target: greenLed;  properties: "width";from: mainRect.width*0.20; to: mainRect.width*0.1; duration:beatLength *1000}
                    }
                }
            }

            Item {
                id: led3
                width: mainRect.width *0.28
                height: width

                Rectangle {
                    id: blueLed
                    anchors.centerIn: parent
                    width: mainRect.width *0.1
                    height: width
                    radius: width/2
                    border.color: "#ffea44"
                    color: "#01192b"
                    property color bright: "lightblue"
                    property color dark: "#01192b"

                    ParallelAnimation {
                        id: blueAnimation
                        ColorAnimation {target: blueLed; properties: "color";  from: target.bright ;to: target.dark; duration:  beatLength *1000}
                        NumberAnimation {target: blueLed;  properties: "width";from: mainRect.width*0.20; to: mainRect.width*0.1; duration:beatLength *1000}
                    }
                }

            }
        }

        Row {
            id: testRow
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            spacing: 10

            Button {
                id: button1

                text: qsTr("LEd1")
                onClicked: { redAnimation.restart() }
            }

            Button {
                id: button2

                text: qsTr("Led2")
                onClicked:  greenAnimation.restart()
            }

            Button {
                id: button3

                text: qsTr("Led3")
                onClicked:  blueAnimation.restart()
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
