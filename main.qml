import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Qt.WebSockets 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    title: qsTr("eClick metronome")
    width: 480
    height: 640
    visible: true
    property real beatLength: 1
    property string instrument: "none" // TODO: set from menu for different channels

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem {
                text: qsTr("&Server adress")
                onTriggered: serverAddress.visible = true // messageDialog.show(qsTr("Open action triggered"));
            }
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

    Timer {
        id: clearNotification
        running: false
        repeat: false
        triggeredOnStart: false
        interval: 4000
        onTriggered: {
            notificationLabel.text = "";
            notificationRect.color = "transparent";
        }

    }

    function notification(message, duration) {
        console.log("notification in qml ", message, duration)
        notificationLabel.text = message;
        notificationRect.color = "darkblue";
        clearNotification.interval = duration*1000; // into milliseconds
        clearNotification.start();
      }



    WebSocket {
        id: socket
        url: "ws://192.168.1.199:6006/ws"

        onTextMessageReceived: {
            console.log("Received message: ",message);
            /* do not use websockets any more for main comminucation
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

            if (messageParts[0] == "n") {	// notification
                    messageParts.splice(0,1); // get rid of the "n" and join word intro string back again
                    var text = messageParts.join(" ");
                    notification(text);
                }

            if (messageParts[0] == "t") {	// tempo
                    tempoLabel.text = qsTr("Tempo: ") + messageParts[1];
                }

            */
        }
        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                             socket.active = false;
                             //connectButton.enabled = true;
                             //connectButton.text = qsTr("Connect...")
                         } else if (socket.status == WebSocket.Open) {
                             console.log("Socket open")
                             //connectButton.enabled = false;
                             serverAddress.visible = false;
                             //connectButton.text = qsTr("Connected")
                             socket.sendTextMessage("hello "+instrument) // send info about instrument and also IP to server instr may not include blanks!
                             socket.active = false; // and close socket
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                             socket.active = false;
                             //connectButton.enabled = true;
                             //connectButton.text = qsTr("Connect")
                         }
                        else if (socket.status == WebSocket.Connecting) {
                             //connectButton.enabled = false;
                             //connectButton.text = qsTr("Connecting")
                         }

        active: false
    }

    Connections {
        target: oscServer

        onNewBeatBar: {
            barLabel.text = bar;
            beatLabel.text = beat;
        }

        onNewTempo: tempoLabel.text = qsTr("Tempo: ")+tempo.toFixed(3);

        onNewLed: {
            beatLength = duration;
            if (led===0) redAnimation.restart()

            if (led===1) greenAnimation.restart()
            if (led===2) blueAnimation.restart()
        }

        onNewMessage: {notification(message, duration);}

    }


//    Component.onCompleted: {
//        socket.active = true;
//    }

    Rectangle {
        id: mainRect
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
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



        RowLayout {
            x:5;
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            id: serverRow
            width: parent.width - x*2
            spacing: 5

            Label {
                id: serverLabel
                visible: false
                text: qsTr("Server: ")
            }

            TextField {
                id: serverAddress
                visible: true
                Layout.fillWidth: true
                Layout.preferredWidth: 250
                Layout.minimumWidth: 80
                Layout.maximumWidth:  400
                //width: 200

                text: "ws://192.168.1.199:6006/ws"
            }

            Button {
                id: connectButton
                //checked:  //socket.active
               //võibolla varem oli pare, kui enabled - socket.active
                //enabled: true //socket.active
                //checkable: true
                text: qsTr("Say Hello")
                onClicked: {
                    if (!socket.active) {
                        socket.url = serverAddress.text
                        console.log("Connecting to ",socket.url)
                        socket.active =  true; // miks error QNativeSocketEngine::write() was not called in QAbstractSocket::ConnectedState - vaja vajutada 2 korda
                    }
                }
            }


        }

        Label {
            id: myIp
            anchors.bottom: serverRow.top
            anchors.bottomMargin: 2
            anchors.left: serverRow.left
            color: "darkblue"
            text: qsTr("My IP: ")+ oscServer.getLocalAddress();

        }



        Label {
            id: tempoLabel
            anchors.top:parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            color: "darkblue"
            //font.pointSize: 20
            text: qsTr("Tempo: 0")

        }

        RowLayout {
            id: beatRow
            anchors.top:tempoLabel.bottom
            anchors.topMargin: 5
            spacing: mainRect.width/8
            anchors.horizontalCenter: parent.horizontalCenter
            //y:mainRect.height * 0.125
            //height: mainRect.height * 0.25
            anchors.bottom: ledRow.top
            anchors.bottomMargin: 5


            Label {
                id: barLabel
                color: "ghostwhite" //"#d6d6d6"
                //x: 62
                //y: 43
                Layout.fillHeight:  true
                Layout.alignment: Qt.AlignCenter
                //TODO: center in row
                Layout.minimumHeight: 5
                text: "0"
                font.bold: true
                font.pointSize: Math.max(10, Math.min(mainRect.width/6,parent.height*0.5 ) )// how to fit into width?
            }



            Label {
                id: beatLabel
                property var colors: ["white","red","greenyellow", "lightgreen", "green", "darkgreen", "forestgreen"]
                color: colors[Math.min(parseInt(text),6)] // different color for every beat. text must contain the beatnumber
                Layout.fillHeight:  true
                Layout.alignment: Qt.AlignCenter
                //Layout.maximumHeight: mainRect.height*0.25
                Layout.minimumHeight: 5
                text: "0"
                font.bold: true
                font.pointSize: barLabel.font.pointSize //Math.min(mainRect.width/6, Math.max(10, parent.height*0.5) )
            }

        }



        Row{
            id: ledRow
            width: parent.width *0.8
            height: Math.min(mainRect.width,mainRect.height) / 3 // one third of the smaller side, whether portrait or landscape
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: beatRow.bottom
//            anchors.topMargin: 10
            anchors.centerIn: parent
            property real ledOnWidth: Math.min(mainRect.width,mainRect.height) * 0.4
            z:3 // to raise above notificationRect
            spacing: 10

            Item {
                id: led1
                width: parent.width/3//mainRect.width *0.28
                height: parent.height//width

                Rectangle {
                    id: redLed
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.centerIn: parent
                    width: ledRow.ledOnWidth/4 // parent.width/4 //mainRect.width *0.1
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
                        NumberAnimation {target: redLed;  properties: "width";from: ledRow.ledOnWidth; to: ledRow.ledOnWidth/4; duration:beatLength *1000}
                    }

                }


            }

            Item {
                id: led2
                width: parent.width/3//mainRect.width *0.28
                height: parent.height//width

                Rectangle {
                    id: greenLed
                    width: ledRow.ledOnWidth/4 //mainRect.width *0.1
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
                        NumberAnimation {target: greenLed;  properties: "width";from: ledRow.ledOnWidth*0.8; to: ledRow.ledOnWidth/4 ; duration:beatLength *1000}
                    }
                }
            }

            Item {
                id: led3
                width: parent.width/3//mainRect.width *0.28
                height: parent.height//width

                Rectangle {
                    id: blueLed
                    anchors.centerIn: parent
                    width: ledRow.ledOnWidth/4 //mainRect.width *0.1
                    height: width
                    radius: width/2
                    border.color: "#ffea44"
                    color: "#01192b"
                    property color bright: "lightblue"
                    property color dark: "#01192b"

                    ParallelAnimation {
                        id: blueAnimation
                        ColorAnimation {target: blueLed; properties: "color";  from: target.bright ;to: target.dark; duration:  beatLength *1000}
                        NumberAnimation {target: blueLed;  properties: "width";from: ledRow.ledOnWidth*0.8; to: ledRow.ledOnWidth/4; duration:beatLength *1000}
                    }
                }

            }
        }

        Rectangle {
            id: notificationRect
            color: "transparent"//"#3c3c62"
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "black";
                }
                GradientStop {
                    position: 0.26;
                    color: "darkblue";
                }
                GradientStop {
                    position: 0.87;
                    color: "darkblue";
                }
                GradientStop {
                    position: 1.00;
                    color: "black";
                }
            } //"transparent"
            anchors.top: ledRow.bottom
            anchors.bottom: mainRect.bottom
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width

            Label {
                anchors.centerIn: parent
                id: notificationLabel
                color: "yellow"
                text: ""
                font.bold: true
                font.pointSize: Math.min(Math.max(10,parent.height/2),60) // not too small, not too big

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
