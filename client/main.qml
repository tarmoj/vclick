/*
    Copyright (C) 2016 Tarmo Johannes
    trmjhnns@gmail.com

    This file is part of eClick.

    eClick is free software; you can redistribute it and/or modify it under
    the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
    Free Software Foundation, Inc. <http://fsf.org/>

    eClick is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with eClick; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/
import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0
import QtMultimedia 5.5
import QtWebSockets 1.0

ApplicationWindow {
    title: qsTr("eClick client")
    width: 480
    height: 640
    visible: true
    property real beatLength: 1
    property string instrument: "none" // TODO: set from menu for different channels
    property string version: "0.2.0"


    menuBar: MenuBar {
        Menu {
            title: qsTr("&Menu")
            MenuItem {
                text: qsTr("Show/Hide &server address")
                onTriggered: serverRow.visible = !serverRow.visible
            }
            MenuItem {
                text: qsTr("&Restart OSC listener")
                onTriggered: oscServer.restart()
            }
            MenuItem {
                text: qsTr("&Update IP address")
                onTriggered:  myIp.text = qsTr("My IP: ")+ oscServer.getLocalAddress();
            }
            MenuItem {
                text: qsTr("&Toggle test leds")
                onTriggered: testRow.visible = !testRow.visible
            }
            MenuItem {
                text: qsTr("Toggle &delay row")
                onTriggered: delayRect.visible = !delayRect.visible
            }
            MenuItem {
                text: qsTr("&About")
                onTriggered: messageDialog.show(qsTr("<b>eClick client "+ version + "</b><br>http://tarmoj.github.io/eclick<br><br>(c) Tarmo Johannes 2016,2017<br><br>Built using Qt SDK"));
            }
            MenuItem {
                text: qsTr("E&xit")
                onTriggered: Qt.quit();
            }
        }
    }

    Component.onCompleted: {
        if (delaySpinBox.value>0) {
            messageDialog.show(qsTr("Delay is greater than 0! Check delay row from menu!"))
        }
    }


    SoundEffect {
        id: sound1
        source: "qrc:///sounds/sound1.wav"
    }

    SoundEffect {
        id: sound2
        source: "qrc:///sounds/sound2.wav"//installPath + "sound2.wav"
    }
    SoundEffect {
        id: sound3
        source: "qrc:///sounds/sound3.wav" //installPath + "sound3.wav"
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

    Timer {
        id: ledOffTimer
        running: false
        repeat: false
        interval: 80
        property var object: redLed ;

        onTriggered: {object.width = ledRow.ledOffWidth; object.color = object.dark ;}

    }

    function notification(message, duration) {
        //console.log("notification in qml ", message, duration)
        notificationLabel.text = message;
        notificationRect.color = "darkblue";
        clearNotification.interval = duration*1000; // into milliseconds
        clearNotification.start();
    }


    WebSocket {
        id: socket
        url: "ws://"+serverAddress.text+":6006/ws"//"ws://192.168.1.199:6006/ws"

        onTextMessageReceived: {
            //console.log("Received message: ",message);
        }
        onStatusChanged: if (socket.status == WebSocket.Error) { // TODO: still needs clicking twice on "Hello" button sometimes...
                             console.log("Error: " + socket.errorString)
                             socket.active = false;
                             //                             connectButton.enabled = true;
                             //                             connectButton.text = qsTr("Hello, Server")
                             //                             notification("Failed!", 1.0);
                         } else if (socket.status == WebSocket.Open) {
                             console.log("Socket open")
                             //serverAddress.visible = false;
                             //                             connectButton.text = qsTr("Connected")
                             //                             connectButton.enabled = false;
                             settings.serverIP= serverAddress.text//socket.url
                             socket.sendTextMessage("hello "+instrument) // send info about instrument and also IP to server instr may not include blanks!
                             socket.active = false; // and close socket
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                             socket.active = false;
                             //                             serverAddress.visible = true;
                             //                             connectButton.enabled = true;
                             //                             connectButton.text = qsTr("Say Hello")
                         }
                         else if (socket.status == WebSocket.Connecting) {
                             console.log("Socket connecting")
                             //                             connectButton.enabled = false;
                             //                             connectButton.text = qsTr("Connecting")
                         }

        //onActiveChanged: console.log("Socket active: ", active)
        active: false
    }


    Connections {
        target: oscServer

        onNewBeatBar: {
            barLabel.text = bar;
            beatLabel.text = beat;
        }

        onNewTempo: tempoLabel.text = qsTr("Tempo: ")+tempo.toFixed(2);

        onNewLed: {
            beatLength = duration;
            if (led===0) {
                if (soundCheckBox.checked) {
                    sound1.play();
                }
                if (animationCheckBox.checked) {
                    redAnimation.restart();
                } else {
                    redLed.color = redLed.bright
                    redLed.width = ledRow.ledOnWidth;
                    ledOffTimer.object = redLed
                    ledOffTimer.start()
                }
            }

            if (led===1) {
                if (soundCheckBox.checked) {
                    sound2.play();
                }
                if (animationCheckBox.checked) {
                    greenAnimation.restart();
                } else {
                    greenLed.color = greenLed.bright
                    greenLed.width = ledRow.ledOnWidth;
                    ledOffTimer.object = greenLed
                    ledOffTimer.start()
                }
            }
            if (led===2) {
                if (soundCheckBox.checked) {
                    sound3.play();
                }
                if (animationCheckBox.checked) {
                    blueAnimation.restart();
                } else {
                    blueLed.color = blueLed.bright
                    blueLed.width = ledRow.ledOnWidth;
                    ledOffTimer.object = blueLed
                    ledOffTimer.start() // mis juhtub, kui kaks korraga vaja maha võtta? Kummalgi vist oma taimerit vaja...
                }
            }
            }

            onNewMessage: {notification(message, duration);}

        }

    Settings {
        id: settings
        property alias serverIP: serverAddress.text
        property alias sound: soundCheckBox.checked
        property alias animation: animationCheckBox.checked
        property alias serverRowVisible: serverRow.visible
        property alias delay: delaySpinBox.value
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

        CheckBox {
            x:5; y: 5
            id: animationCheckBox
            checked: true
            text: qsTr("Animation")
        }

        CheckBox {
            x:5;
            anchors.top: animationCheckBox.bottom
            id: soundCheckBox
            checked: false
            text: qsTr("Sound")
        }



        Rectangle {
            id: delayRect
            width: parent.width
            height: soundCheckBox.y+soundCheckBox.height
            color: "lightgrey"
            visible: false
            z:2
            RowLayout {
                x:5
                id: delayRow
                y:5
                width: (mainRect.width>mainRect.height) ? parent.width/2 : parent.width-5
                visible: true
                spacing: 3
                Label {text: qsTr("Delay (ms): ") }
                SpinBox {
                    id: delaySpinBox
                    minimumValue: 0
                    maximumValue: 1000
                    Layout.fillWidth: true
                    Layout.maximumWidth: 200
                    Layout.preferredWidth: 90
                    Layout.minimumWidth: 10
                    stepSize: 1
                    onValueChanged: oscServer.setDelay(value)
                }
                Button {
                    //                Layout.fillWidth: true
                    //                Layout.maximumWidth: 300
                    //                Layout.minimumWidth: 10
                    //                Layout.preferredWidth: 100
                    text: qsTr("Reset");
                    onClicked: delaySpinBox.value = 0;
                }
                Button {text: qsTr("Hide"); onClicked: delayRect.visible = false;  }
            }
        }



        RowLayout {
            x:5;
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            id: serverRow
            width: parent.width - x*2
            spacing: 5

            Label {
                id: serverLabel
                visible: true
                text: qsTr("Server IP: ")
            }

            TextField {
                id: serverAddress
                visible: true
                Layout.fillWidth: true
                Layout.preferredWidth: 250
                Layout.minimumWidth: 80


                text: "10.42.0.1"
            }

            Button {
                id: connectButton
                text: qsTr("Hello, Server")
                onClicked: {
                    console.log("Socket state, errorString: ", socket.status, socket.errorString)
                    if (!socket.active) {
                        //socket.url = serverAddress.text
                        socket.active = true
                        console.log("Connecting to ",socket.url, socket.status)
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
            z:3
            anchors.top: (mainRect.width>mainRect.height) ? tempoLabel.bottom : soundCheckBox.bottom // not to squeeze too much on horizontal layouts
            //anchors.topMargin: 5
            anchors.bottom: ledRow.top
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.98

            Item {
                id:leftRectangle
                //color: "lightpink"
                height: parent.height
                width: parent.width*0.47
                anchors.left: parent.left

                Label {
                    id: barLabel
                    color: "ghostwhite" //"#d6d6d6"
                    text: "0"
                    font.bold: true
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    minimumPointSize: 10
                    font.pointSize: 200
                    fontSizeMode: Text.Fit
                }
            }

            Item {
                id:rightRectangle
                //color: "pink"
                height:parent.height
                width: parent.width*0.47
                anchors.right: parent.right

                Label {
                    id: beatLabel
                    property var colors: ["white","red","greenyellow", "lightgreen", "green", "darkgreen", "forestgreen"]
                    color: colors[Math.abs(Math.min(parseInt(text)),6)] // different color for every beat. text must contain the beatnumber
                    text: "0"
                    font.bold: true
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    //font.pixelSize: barLabel.paintedHeight * 0.75 // quite good approximization TEST on mobile devices! -  THIS IS NOT ADEQUATE, can give different results...
                    minimumPointSize: 10
                    font.pointSize: 200
                    fontSizeMode: Text.Fit // on some screens this makes beatnumber bigger, since bar may have easily 3 digits, but that is OK
                }
            }

        }




        Row{
            id: ledRow
            width: parent.width *0.8
            height: Math.min(mainRect.width,mainRect.height) / 3 // one third of the smaller side, whether portrait or landscape
             anchors.centerIn: parent
            property real ledOnWidth: Math.min(mainRect.width,mainRect.height) * 0.4
            property real ledOffWidth: ledRow.ledOnWidth/4
            z:3 // to raise above notificationRect

            spacing: 10

            Item {
                id: led1
                width: parent.width/3//mainRect.width *0.28
                height: parent.height//width

                Rectangle {
                    id: redLed
                    anchors.centerIn: parent
                    width: ledRow.ledOnWidth/4 // parent.width/4 //mainRect.width *0.1
                    height: width
                    color: "#5c0303"
                    radius: width/2
                    border.width: 1
                    border.color: "#ffea44"
                    property color bright: "red"
                    property color dark: "#5c0303"

                    ParallelAnimation {
                        id: redAnimation
                        ColorAnimation {target: redLed; properties: "color";  from: target.bright ;to: target.dark; duration:  beatLength *1000}
                        NumberAnimation {target: redLed;  properties: "width";from: ledRow.ledOnWidth; to: ledRow.ledOffWidth; duration:beatLength *1000}
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
                font.pixelSize: Math.max(20, Math.min(mainRect.width/10, parent.height ) )
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

                text: qsTr("Led1")
                onClicked: {
                    if (animationCheckBox.checked) {
                        redAnimation.restart();
                    } else {
                        redLed.color = redLed.bright
                        redLed.width = ledRow.ledOnWidth;
                        ledOffTimer.object = redLed
                        ledOffTimer.start() // mis juhtub, kui kaks korraga vaja maha võtta? Kummalgi vist oma taimerit vaja...
                    }

                    if (soundCheckBox.checked) {
                        sound1.play();
                    }
                }
            }

            Button {
                id: button2

                text: qsTr("Led2")
                onClicked:  {
                    if (animationCheckBox.checked) {
                        greenAnimation.restart();
                    } else {
                        greenLed.color = greenLed.bright
                        greenLed.width = ledRow.ledOnWidth;
                        ledOffTimer.object = greenLed
                        ledOffTimer.start() // mis juhtub, kui kaks korraga vaja maha võtta? Kummalgi vist oma taimerit vaja...
                    }
                    if (soundCheckBox.checked) {
                        sound2.play();
                    }
                }
            }

            Button {
                id: button3

                text: qsTr("Led3")
                onClicked:  {
                    if (soundCheckBox.checked) {
                        sound3.play();
                    }
                    if (animationCheckBox.checked) {
                        blueAnimation.restart();
                    } else {
                        blueLed.color = blueLed.bright
                        blueLed.width = ledRow.ledOnWidth;
                        ledOffTimer.object = blueLed
                        ledOffTimer.start() // mis juhtub, kui kaks korraga vaja maha võtta? Kummalgi vist oma taimerit vaja...
                    }
                }
            }
        }
    }



    MessageDialog {
        id: messageDialog

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
}
