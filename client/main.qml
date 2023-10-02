/*
    Copyright (C) 2016-2023 Tarmo Johannes
    trmjhnns@gmail.com

    This file is part of vClick.

    vClick is free software; you can redistribute it and/or modify it under
    the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
    Free Software Foundation, Inc. <http://fsf.org/>

    vClick is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with vClick; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
    02111-1307 USA
*/


// Qt6 required

import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Dialogs
import QtQuick.Layouts
import QtCore
import QtMultimedia
import QtWebSockets

//import QtQuick.Controls.Material 2.12


ApplicationWindow {
    title: qsTr("vClick Client")
    id: app
    width: 480
    height: 640
    visible: true
    property real beatLength: 1
    property int instrument: 0
    property string version: Qt.application.version

        Menu {
            id: mainMenu
            title: qsTr("Menu")
            width: (Qt.platform.os==="android" || Qt.platform.os==="ios") ?  Math.min(Screen.width, Screen.height)*0.85 :400


            Column {
                x: 5
                width: parent.width-10
                spacing: 2

                MenuItem {
                    text: qsTr("Getting started")
                    onTriggered: Qt.openUrlExternally("https://tarmoj.github.io/vclick/pages/getting-started.html#getting-started")
                }




                Label { text: qsTr("OSC port:"); }
                Row { // Not shown with Qt.labs.platform...
                    spacing: 4
                    SpinBox {
                        id: oscPortSpinbox;
                        editable: true
                        to: 100000 // to enable very large complex bar numbers like 10101
                        from: 1025
                        value: 57878
                    }
                    Button { text: qsTr("Set"); onClicked: oscServer.setPort(oscPortSpinbox.value)}
                    Button { text: qsTr("Reset"); onClicked: oscPortSpinbox.value = 57878 }
                }

                Label { text: qsTr("Server port:") }
                Row { // Not shown with Qt.labs.platform...
                    spacing: 4
                    SpinBox {
                        id: serverPortSpinbox;
                        editable: true
                        to: 100000 // to enable very large complex bar numbers like 10101
                        from: 1025
                        value: 6006
                    }
                    Button { text: qsTr("Set");
                        onClicked: {
                            if (serverPortSpinbox.value===socket.serverPort) {
                                socket.active = true
                            } else {
                                socket.active = false;
                                socket.serverPort = serverPortSpinbox.value // this activates the socket as well, since server.url is bound to serverIP
                                socket.active = true;
                            }
                        }

                    }
                    Button { text: qsTr("Reset"); onClicked: serverPortSpinbox.value = 6006 }
                }

                CheckBox {
                    id: animationCheckBox
                    checked: true
                    text: qsTr("Animation")
                }

                CheckBox {
                    id: soundCheckBox
                    checked: false
                    text: qsTr("Sound")
                }

                MenuItem {
                    text: qsTr("Set instrument number")
                    onTriggered: {
                        instrumentRect.visible = !instrumentRect.visible;
                        mainMenu.close()
                    }
                }

                MenuItem {
                    text: qsTr("Update IP address")
                    onTriggered:  myIp.text = qsTr("My IP: ")+ oscServer.getLocalAddress();
                }
//                MenuItem {
//                    text: qsTr("Show/Hide test leds")
//                    onTriggered:  {
//                        testRow.visible = !testRow.visible;
//                        mainMenu.close()
//                    }
//                }
                MenuItem {
                    text: qsTr("Show delay row")
                    onTriggered: {
                        delayRect.visible = !delayRect.visible;
                        mainMenu.close()
                    }
                }
                MenuItem {
                    text: qsTr("Show remote control")
                    onTriggered:  {
                        remoteControlRect.visible = !remoteControlRect.visible
                        mainMenu.close()
                    }
                }

                MenuItem {
                    text: qsTr("About")
                    onTriggered: {
                        messageDialog.text = qsTr("<b>vClick client "+ version + "</b><br>http://tarmoj.github.io/vclick<br><br>(c) Tarmo Johannes 2016-2023<br><br>Built using Qt SDK" );
                        messageDialog.open()
                        mainMenu.close()
                    }
                }

                MenuItem {
                 text: qsTr("Buy me a coffee")
                 onTriggered: Qt.openUrlExternally("https://ko-fi.com/tarmojohannes")
                }

                MenuItem {
                    text: qsTr("Exit")
                    onTriggered: Qt.quit();
                }
            }



        }



    Component.onCompleted: {
        if (delaySpinBox.value>0) {
            if (Qt.platform.os === "ios") {
                notification(qsTr("Delay is not 0!"),3)
            } else {
                messageDialog.text = qsTr("Delay is greater than 0! Check delay row from menu!")
                messageDialog.open();
            }
        }
        if (oscServer) {
            oscServer.setPort(oscPortSpinbox.value)
        }

    }

    // In version 3 (Qt 6.5) sounds don't work well on Linux -  not played or repeated or similar
    SoundEffect {
        id: sound1
        volume: 0.6
        source: "qrc:///sounds/sound1.wav"
    }

    SoundEffect {
        id: sound2
        volume: 0.6
        source: "qrc:///sounds/sound2.wav"
    }
    SoundEffect {
        id: sound3
        volume: 0.6
        source: "qrc:///sounds/sound3.wav"
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

    function connectSocket() {
        if (!socket.active) {
            if (serverAddress.text===socket.serverIP && serverPortSpinbox.value===socket.serverPort ) {
                socket.active = true
            } else {
                socket.serverIP = serverAddress.text // this should activate the socket as well, since server.url is bound to serverIP
                socket.serverPort = serverPortSpinbox.value;
                socket.active = true; // do we need this?
            }
        } else {
            console.log("Socket already active?")
        }
    }


    WebSocket {
        id: socket
        property string serverIP: "192.168.1.199"
        property int serverPort: 6006
        url: "ws://"+serverIP+":" + serverPort +  "/ws"  //"ws://192.168.1.199:6006/ws"


        onTextMessageReceived: function (message) {
            // console.log("Received message: ",message);
            var messageParts = message.trim().split(" ") // format: csound: led %d  duration %f channels %d  OR csound: bar %d beat %d channels %d\
            if (messageParts[0]==="b") {
                barLabel.text = messageParts[1]
                beatLabel.text = messageParts[2]
            }
            // this doubles in great part code in oscServer connections. Would make sense to rewrite new functions that are called from both
            if (messageParts[0]==="l") {
                var led = parseInt( messageParts[1] );
                beatLength = parseFloat(messageParts[2]); // TODO - enable different durations for different beats
                if (led===0)  {
                    redAnimation.restart();
                    if (soundCheckBox.checked) {
                        sound1.play();
                    }
                }
                if (led===1)  {
                        greenAnimation.restart();
                        if (soundCheckBox.checked) {
                            sound2.play();
                        }
                    }

                if (led===2) {

                    blueAnimation.restart()
                    if (soundCheckBox.checked) {
                        sound2.play();
                    }
                }
            }
            if (messageParts[0] === "n") {	// notification
                messageParts.splice(0,1); // get rid of the "n" and join word intro string back again
                var text = messageParts.join(" ");
                notification(text, 2); // How to give the duration from message maybe like n2.3<space><message>
                // duration hardcoded to 2 for now
            }
            if (messageParts[0] === "t") {	// tempo
                tempoLabel.text = qsTr("Tempo: ") + messageParts[1];
            }
        }
        onStatusChanged: if (socket.status == WebSocket.Error) { // TODO: still needs clicking twice on "Hello" button sometimes...
                             console.log("Error: ", socket.errorString, url )
                             socket.active = false;
                             notification("Failed!", 1.0);
                         } else if (socket.status == WebSocket.Open) {
                             console.log("Socket open", url)
                             settings.serverIP= socket.serverIP
                             settings.serverPort=socket.serverPort
                             socket.sendTextMessage("hello "+instrument) // send info about instrument and also IP to server instr may not include blanks!
                             // socket.active = false; // do not for remote control
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                             socket.active = false;                             
                         }
                         else if (socket.status == WebSocket.Connecting) {
                             console.log("Socket connecting", url)
                         }
        active: false
    }

    Connections { // To see, if OSC server can be restarted on reopen
        target: Qt.application
        function onStateChanged(state) {

            //console.log("State: ", state);

            if(Qt.application.state === Qt.ApplicationActive) {
                //console.log("Active")
                if (Qt.platform.os === "ios") {
                        oscServer.restart() ;// to make sure it is running
                }
            }

            if ( (Qt.platform.os === "ios" || Qt.platform.os === "android") &&
                    ( Qt.application.state === Qt.ApplicationSuspended  )  &&
                    socket.status === WebSocket.Open )  {
                console.log("Application suspended. Closing websocket.")
                socket.active = false;
            }
        }
    }

    Connections {
        target: oscServer

        function onNewBeatBar(bar, beat) {
            barLabel.text = bar;
            beatLabel.text = beat;
        }

        function onNewTempo(tempo) { tempoLabel.text = qsTr("Tempo: ")+tempo.toFixed(2); }

        function onNewLed(led, duration) {
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
                    ledOffTimer.start()
                }
            }
            }

            function onNewMessage(message, duration) {notification(message, duration);}

        }

    Settings {
        id: settings
        property alias serverIP:  serverAddress.text
        property alias serverPort: serverPortSpinbox.value
        property alias sound: soundCheckBox.checked
        property alias animation: animationCheckBox.checked
        property alias serverRowVisible: serverRow.visible
        property alias delay: delaySpinBox.value
        property alias instrument: app.instrument
        property alias oscPort: oscPortSpinbox.value
    }


    Rectangle {
        id: mainRect
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#a5c9db";
            }
            GradientStop {
                position: 0.26;
                color: "#000000";
            }
            GradientStop {
                position: 0.84;
                color: "#000000";
            }
            GradientStop {
                position: 1.00;
                color: "#a5c9db";
            }
        }
        anchors.fill: parent
        property string semitransparent: "#0FF5F5F5"


        Image {

            id: menuButton
            y:5
            x:5
            source: "qrc:///menu.png"
            width: height
            height: Qt.platform.os === "ios"  || Qt.platform.os === "osx" ?    tempoLabel.height*1.5 : tempoLabel.height*1.1 // maybe fixes the size on iphone?
            MouseArea {width: parent.width*1.5; height: parent.height*2; onClicked: mainMenu.open() }
        }

        Image {
            id: remoteButton
            anchors.top: menuButton.top
            anchors.left: menuButton.right
            anchors.leftMargin: 20
            source: "qrc:///radio.png"
            width: height
            height: menuButton.height
            MouseArea {
                width:  parent.width * 1.8
                height:  parent.height * 2
                onClicked: remoteControlRect.visible = true;
            }
        }

        Rectangle {
            id: instrumentLabelRect
            border.color: "darkgrey"
            visible: (instrument>0)
            radius: 8
            width: height
            height: menuButton.height
            color: "transparent"
            anchors.top: mainRect.top
            anchors.topMargin: 5
            anchors.right: mainRect.right
            anchors.rightMargin: 5
            MouseArea {
                width:parent.width*2; height: parent.height *2
                anchors.right: parent.right
                onClicked: instrumentRect.visible = true;
            }

            Label {
                anchors.centerIn: parent
                text: instrument.toString()
                font.pixelSize: instrumentLabelRect.height*0.8
            }

        }


        // TODO: one rect, different Rowlayouts rect.visible = comp1.visble || comp2.visible || comp3.visible
        Rectangle {
            id: delayRect
            width: parent.width
            height: delaySpinBox.height * 1.5
            color: mainRect.semitransparent // "#0FF5F5F5" //"#F0d4e1e3"
            visible: false
            z:2
            RowLayout {
                x:5
                id: delayRow
                y:5
                width: parent.width //(mainRect.width>mainRect.height) ? parent.width/2 : parent.width-5
                visible: true
                spacing: 3
                Label {text: qsTr("Delay (ms): ") }
                SpinBox {
                    id: delaySpinBox
                    editable: true
                    value: 0
                    from: 0
                    to: 1001
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth *1.5
                    Layout.preferredWidth: implicitWidth
                    Layout.minimumWidth: 60
                    stepSize: 1
                    onValueChanged: oscServer.setDelay(value)
                }
                Button {
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth * 1.5
                    Layout.minimumWidth: 50
                    Layout.preferredWidth: implicitWidth

                    text: qsTr("Reset");
                    onClicked: delaySpinBox.value = 0;
                }
                Button {
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth * 1.5
                    Layout.minimumWidth: 50
                    Layout.preferredWidth: implicitWidth
                    text: qsTr("Hide");
                    onClicked: delayRect.visible = false;
                }

                Item { Layout.fillWidth: true}
            }
        }

        Rectangle { // this is same as delayrect - how to copy less code?
            id: instrumentRect
            width: parent.width
            height: instrumentRow.height*1.5 //instrumentSpinBox.height * 1.5
            color:   mainRect.semitransparent
            visible: false
            z:2
            Flow {
                id: instrumentRow
                x:5; y:5
                width: parent.width
                spacing: 3

                Label {
                    text: qsTr("Instrument no: ");
                    height: instrumentSpinBox.height
                    verticalAlignment: Text.AlignVCenter
                }
                SpinBox {
                    id: instrumentSpinBox
                    editable: true
                    value: instrument
                    from: 0
                    to: 32
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth*1.5
                    Layout.preferredWidth: implicitWidth
                    Layout.minimumWidth: 120
                    stepSize: 1
                    onValueChanged:  {
                        console.log("New instrument value: ", value)
                        instrument = value
                    }
                }

                Button {
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth*1.5
                    Layout.minimumWidth: 70
                    Layout.preferredWidth: implicitWidth

                    text: qsTr("Update");
                    onClicked: { console.log("should send Hello instrument nr here");
                        connectSocket();
                    }
                }
                Button {
                    Layout.fillWidth: true
                    Layout.maximumWidth: implicitWidth * 1.5
                    Layout.minimumWidth: 50
                    Layout.preferredWidth: 60//implicitWidth
                    //icon.source: "qrc:///xmark-solid.png"
                    text: qsTr("Hide");
                    onClicked: instrumentRect.visible = false;
                }

                Item { Layout.fillWidth: true}
            }


        }

        Rectangle { // this is same as delayrect - how to copy less code?
            id: remoteControlRect
            width: parent.width
            height: controlConnectedButton.height*2.5
            color:  mainRect.semitransparent
            visible: false
            z:2
            Column {
                anchors.fill: parent
                spacing:10
                RowLayout {

                    id: controlRow

                    width: parent.width
                    visible: true
                    spacing: 8

                    Button {
                        id: controlConnectedButton
                        visible: !(socket.status === WebSocket.Open)
                        Layout.fillWidth: true
                        Layout.maximumWidth: implicitWidth*1.5
                        Layout.minimumWidth: 70
                        Layout.preferredWidth: implicitWidth
                        enabled: !socket.active
                        text:  qsTr("Connect");
                        onClicked: {
                            connectSocket()
                        }
                    }



                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: implicitWidth * 1.5
                        Layout.minimumWidth: 50
                        Layout.preferredWidth: 60//implicitWidth
                        text: qsTr("Start");
                        enabled: socket.status === WebSocket.Open
                        onClicked: {
                            socket.sendTextMessage("start");
                            remoteOptionsRect.visible = false;
                        }
                    }

                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: implicitWidth * 1.5
                        Layout.minimumWidth: 50
                        Layout.preferredWidth: 60//implicitWidth
                        text: qsTr("Stop");
                        enabled: socket.status === WebSocket.Open
                        onClicked: socket.sendTextMessage("stop");
                    }



                    Button {
                        Layout.fillWidth: true
                        Layout.maximumWidth: implicitWidth * 1.5
                        Layout.minimumWidth: 50
                        Layout.preferredWidth: 60//implicitWidth
                        //Layout.alignment: Layout.Right
                        text: qsTr("Hide");
                        onClicked: {
                            remoteControlRect.visible = false;
                            remoteOptionsRect.visible = false;
                        }

                    }

                    Item { Layout.fillWidth: true}
                }

                RowLayout {
                    spacing: 8
                    enabled:  socket.status === WebSocket.Open

                    Label {text: qsTr("Options")}

                    Button {
                        text: qsTr("Score")
                        onClicked: {
                            remoteOptionsRect.isScore = true
                            remoteOptionsRect.visible = true
                            socket.sendTextMessage("useScore")
                        }
                    }

                    Button {
                        text: qsTr("Time")
                        onClicked: {
                            remoteOptionsRect.isScore = false
                            remoteOptionsRect.visible = true
                            if (socket.status === WebSocket.Open ) {
                                socket.sendTextMessage("useTime")
                            }
                        }
                    }

                }
            }
        }

        Rectangle {
            id: remoteOptionsRect
            anchors.horizontalCenter:  parent.horizontalCenter
            anchors.top: remoteControlRect.bottom
            anchors.topMargin: 20
            width: parent.width * 0.8
            height: startBarSpinBox.height * 5
            color: Material.background
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#cfffffff";
                }
                GradientStop {
                    position: 0.32;
                    color: Material.background
                }
                GradientStop {
                    position: 0.64;
                    color: Material.background
                }
                GradientStop {
                    position: 1.00;
                    color: "#cfffffff";
                }
            }
            radius: 10
            property bool isScore: true
            visible: false
            z: 5



            ColumnLayout {
                id: scoreOptions
                anchors.fill: parent
                anchors.margins:  5
                visible: parent.isScore && !timeOptions.visible

                ToolButton {
                    Layout.alignment: Qt.AlignRight
                    icon.source: "qrc:///xmark-solid.png"
                    onClicked: remoteOptionsRect.visible = false
                }


                RowLayout {
                    width: parent.width
                    spacing: 5
                    enabled: socket.status === WebSocket.Open

                    Label { text: qsTr("Starting bar: ") }

                    SpinBox {
                        id: startBarSpinBox
                        editable: true
                        from: 1
                        to: 1000000 // to enable very large complex bar numbers like 10101

                    }

                    Item {Layout.fillWidth: true}
                }

                RowLayout {
                    width: parent.width
                    spacing: 5
                    enabled: socket.status === WebSocket.Open

                    Button {
                        text: qsTr("Set");
                        onClicked: socket.sendTextMessage("startBar " + startBarSpinBox.value)
                    }
                    Button {
                        text: qsTr("Reset");
                        onClicked: {
                            startBarSpinBox.value = 1
                            socket.sendTextMessage("startBar " + startBarSpinBox.value)
                        }
                    }

                    Item {Layout.fillWidth: true}


                }

                RowLayout {
                    width: parent.width
                    spacing: 5
                    enabled: socket.status === WebSocket.Open

                    Label { text: qsTr("Active:")}

                    // for setting active index
                    RoundButton {
                        text: "1";
                        onClicked: socket.sendTextMessage("scoreIndex 0")
                    }
                    RoundButton {
                        text: "2";
                        onClicked: socket.sendTextMessage("scoreIndex 1")
                    }
                    RoundButton {
                        text: "3";
                        onClicked: socket.sendTextMessage("scoreIndex 2")
                    }

                    RoundButton {
                        text: "4";
                        onClicked: socket.sendTextMessage("scoreIndex 3")
                    }

                    Item { Layout.fillWidth: true}
                }

                Item {Layout.fillHeight:  true}
            }

            ColumnLayout {
                id: timeOptions
                anchors.fill: parent
                anchors.margins:  5               
                visible: !parent.isScore && !scoreOptions.visible


                ToolButton {
                    Layout.preferredHeight: resetTimeButton.height * 0.8
                    Layout.preferredWidth: Layout.preferredHeight
                    Layout.alignment: Qt.AlignRight
                    icon.source: "qrc:///xmark-solid.png"
                    onClicked: remoteOptionsRect.visible = false
                }

                RowLayout {
                    id: timeRow
                    spacing: 5
                    width: parent.width
                    enabled: socket.status === WebSocket.Open

                    Label { text: qsTr("Count time from:") }

                    TextField {

                        function convertToTime() {
                            var stringParts = text.split(":")
                            minutes = stringParts[0]
                            seconds = stringParts[1]
                            console.log(minutes, seconds)
                        }

                        id: startTimeField
                        property int minutes: 0
                        property int seconds: 0
                        inputMask: "09:99"
                        cursorVisible: true
                        inputMethodHints: Qt.ImhTime
                        font.pointSize: 16
                        text: "00:00"
                        //validator: RegExpValidator { regExp: /^([0-1\s]?[0-9\s]|2[0-3\s]):([0-5\s][0-9\s])$ / } // seems that it is not need if inputMask is there
                        onAccepted: { setTimeButton.clicked() }
                    }
                }
                RowLayout {
                    enabled: socket.status === WebSocket.Open
                    spacing: 5

                    Button  {
                        id: setTimeButton
                        text: qsTr("Set")
                        onClicked: {
                            startTimeField.convertToTime()
                            socket.sendTextMessage("startTime " + (startTimeField.minutes*60 + startTimeField.seconds).toString() )
                        }

                    }


                    Button {
                        id: resetTimeButton
                        text: qsTr("Reset")
                        onClicked: {
                            startTimeField.minutes = 0
                            startTimeField.seconds = 0
                            startTimeField.text = "00:00"
                            socket.sendTextMessage("startTime 0")
                        }
                    }
                }

                RowLayout {
                    enabled: socket.status === WebSocket.Open
                    spacing: 5

                    CheckBox {
                        id: countdown
                        checked: true
                        text: qsTr("Countdown")
                        onCheckedChanged: socket.sendTextMessage("countdown " + ((checked) ? "1" : "0") )
                    }

                }

                RowLayout {
                    id: soundFileRow // this belongs to showTime group actually, but easier to hold as sibling, then it is placed nicely to column
                    spacing: 5
                    width: parent.width
                    enabled: socket.status === WebSocket.Open

                    CheckBox {
                        id:playSoundfile;
                        text:qsTr("Play selected soundfile")
                        onCheckedChanged:
                            socket.sendTextMessage("useSoundFile " + ((checked) ? "1" : "0") )

                    }

                }

                Item {Layout.fillHeight:  true}
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
                text: "192.168.1.199"

                onTextChanged: text = text.trim() // exclude erratic whitespaces


            }

            Button {
                id: connectButton
                text: socket.status === WebSocket.Open ?  qsTr("Connected")  :  ( socket.status === WebSocket.Connecting ? qsTr("Connecting...") :  qsTr("Hello, Server") )
                onClicked: {
                    //console.log("Socket state, errorString: ", socket.status, socket.errorString, socket.active)
                    if (!socket.active) {
                         connectSocket();
                    } else {
                        console.log("Already active")
                        socket.sendTextMessage("hello "+instrument)
                    }
                }
            }


        }

        Label {
            id: myIp
            anchors.bottom: serverRow.top
            anchors.bottomMargin: 2
            anchors.left: serverRow.left
            color:  "#BDBDBD"
            text: (oscServer===null) ? "" :  qsTr("My IP: ") +  oscServer.getLocalAddress();


        }



        Label {
            id: tempoLabel
            anchors.top:parent.top
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            color: "darkblue"
            text: qsTr("Tempo: 0")

        }


        RowLayout {
            id: beatRow
            z:3
            spacing: 20
            anchors.top: tempoLabel.bottom
            anchors.topMargin: tempoLabel.height
            anchors.bottom: ledRow.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width*0.98

            Item  {
                id:leftRectangle
                //color: "lightpink"
                width: mainRect.width*0.4
                Layout.fillHeight: true
                Layout.fillWidth: true

                Label {
                    id: barLabel
                    color: "ghostwhite"
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
                // color: "pink"
                Layout.fillHeight: true
                Layout.fillWidth: true


                Label {
                    id: beatLabel
                    property var colors: ["white","red","greenyellow", "lightgreen", "green", "darkgreen", "forestgreen"]
                    color: colors[Math.min(Math.abs(parseInt(text)),6)] // different color for every beat. text must contain the beatnumber
                    text: "0"
                    font.bold: true
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    minimumPointSize: 10
                    font.pointSize: 200
                    fontSizeMode: Text.Fit
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

            // in future, when breaking into separate components, have a Led component
            Item {
                id: led1
                width: parent.width/3
                height: parent.height

                Rectangle {
                    id: redLed
                    anchors.centerIn: parent
                    width: ledRow.ledOnWidth/4
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
                width: parent.width/3
                height: parent.height

                Rectangle {
                    id: greenLed
                    width: ledRow.ledOnWidth/4
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
                width: parent.width/3
                height: parent.height

                Rectangle {
                    id: blueLed
                    anchors.centerIn: parent
                    width: ledRow.ledOnWidth/4
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
            color: "transparent"
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
            }
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
                        ledOffTimer.start()
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
                        ledOffTimer.start()
                    }
                    if (soundCheckBox.checked) {
                        sound2.play();
                        sound1.play();
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
                        ledOffTimer.start()
                    }
                }
            }
        }
    }


    MessageDialog {
        id: messageDialog
        buttons: MessageDialog.Ok
        text: "Message"
        onButtonClicked: function (button, role) { // does not close on Android otherwise
            switch (button) {
                case MessageDialog.Ok:
                    messageDialog.close()
                }
            }
    }
}

