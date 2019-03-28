import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.2 //1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 740
    height: 740
    title: qsTr("vClick server")
    property string version: "2.0.0-alpha2"
    property string startCommand: "" // system command run on start for example send OSC message to Reaper
    property string stopCommand: "" // set in config file, so far no dialog for that...



    header: ToolBar {
        Button {text:"Menu"; onClicked: mainMenu.open()}
        Menu {
            //minimumWidth: 350
            //width: 350
            id: mainMenu
            title: qsTr("Menu")

            Label { text: qsTr("Clients' OSC port:") }
            Row { // Not shown with Qt.labs.platform...
                spacing: 4
                SpinBox {
                    id: oscPortSpinbox;
                    editable: true
                    to: 100000 // to enable very large complex bar numbers like 10101
                    from: 1025
                    value: 58787
                }
                Button { text: qsTr("Set"); onClicked: wsServer.setOscPort(oscPortSpinbox.value) }
                Button { text: qsTr("Reset"); onClicked: oscPortSpinbox.value = 57878 }
            }

            MenuItem {
                id: wsMenu
                checkable: true
                text: qsTr("Enable Websocket signals")
                onCheckedChanged: wsCheckBox.enabled = checked
            }

            MenuItem {
                id: oscMenu
                checkable: true
                text: qsTr("Enable server's OSC")
                onCheckedChanged: oscCheckBox.enabled = checked
            }

            MenuItem {
                text: qsTr("Update IP address")
                onTriggered:  ipLabel.text = qsTr("My IP: ")+ wsServer.getLocalAddress()
            }
            MenuItem {
                text: qsTr("About")
                onTriggered: messageDialog.show(qsTr("<b>vClick server "+ version + "</b><br>http://tarmoj.github.io/vclick<br><br>(c) Tarmo Johannes 2016-2019<br><br>Built using Qt SDK and Csound audio engine."));
            }

            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }

        }
    }

    MessageDialog {
        id: messageDialog
        //title: qsTr("Message")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    signal play()

    Settings {
        id: settings
        property alias scoreFile:  scoField.text
        property alias sendWs: wsCheckBox.checked
        property alias sendOsc: oscCheckBox.checked
        property alias wsMenu: wsMenu.checked
        property alias oscMenu: oscMenu.checked
        property alias readFromJack: jackCheckBox.checked
        property alias timeCodeHack: timeCodeCheckBox.checked
        property alias lastScorePath: fileDialog.folder
        property alias csoundOptions: csoundOptions.text
        property alias sfdir: sfdirField.text
        property alias volume: volumeSlider.value
        property alias startCommand: window.startCommand
        property alias stopCommand: window.stopCommand
        property alias oscPort: oscPortSpinbox.value // don't need save the setting in wsServer any more now
    }

    Component.onCompleted: {
        wsServer.setOscPort(oscPortSpinbox.value)
    }

    Connections {
        target: wsServer
        onNewConnection: {
            //console.log(connectionsCount)
            clientsLabel.text = qsTr("Clients: ") + connectionsCount;
        }
        onNewBeatBar: {
            barLabel.text = bar;
            beatLabel.text = beat;
        }

        onNewTempo: tempoLabel.text = tempo;

        onUpdateOscAddresses: {
            oscAddresses.text = adresses;
            cs.setOscAddresses(oscAddresses.text);
        }

        onCsoundMessage: messageArea.append(message)

        onStart: {
            if (scoreFile!="")  { // better check!
                scoField.text = scoreFile;
                startBarSpinBox.value = 1 // TODO: from parameter
                cs.start(scoField.text, startBarSpinBox.value)
            }
        }

        onStop: cs.stop()

    }


    FileDialog {
        id: fileDialog
        title: qsTr("Please choose score for metronome")
        nameFilters: [ "Csound score files (*.sco)", "All files (*)" ]
        //folder: "file://"
        onAccepted: {
            scoField.text = fileUrl
            var basename = fileUrl.toString()
            basename = basename.slice(0, basename.lastIndexOf("/")+1)
            folder = basename
            console.log("You chose: " + fileUrl + " in folder: " + basename)
        }
        onRejected: {
            console.log("Canceled")
            visible = false;
        }        
    }

    FileDialog {
        id: sfdirDialog
        title: qsTr("Please choose folder of playbacks soundfiles")

        folder: shortcuts.documents //sfdirField.text
        //selectFolder: true

        onAccepted: {
            console.log("You chose: " + folder)
            sfdirField.text = folder
            //cs.setSFDIR(folder);
        }
        onRejected: {
            console.log("Canceled")
            visible = false;
        }

    }



    Rectangle {
        id: mainRect
        color: "#3e5501"
        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#56bb32";
            }
            GradientStop {
                position: 1.00;
                color: "#e6f992";
            }
        }
        anchors.fill: parent

        //Shortcuts
        focus: true
        Keys.onPressed:  { // hack for playing tanja1.sco on F1 and tanja2.sco on F2 -  TODO: implement dialog window for multiple score files + shortcuts

            console.log(event.key)
            var name;
            if (event.key === Qt.Key_F1 || ((event.key == Qt.Key_1) && ( event.modifiers & Qt.ControlModifier) ) ) {
                name = scoField.text // one of the tanja?.sco files must be loaded
                scoField.text=name.replace("tanja2.sco", "tanja1.sco")
                cs.start(scoField.text, startBarSpinBox.value)
                console.log("Starting: ", name)

            }
            if (event.key === Qt.Key_F2) {
                name = scoField.text // one of the tanja?.sco files must be loaded
                scoField.text=name.replace("tanja1.sco", "tanja2.sco")
                cs.start(scoField.text, startBarSpinBox.value)
                console.log("Starting: ", name)
            }
             if (event.key === Qt.Key_F10)
                 cs.stop()

             if (event.key === Qt.Key_Backspace   || event.key === Qt.Key_Escape ) {
                 stopButton.clicked()
             }
        }

        Keys.onEnterPressed: startButton.clicked()

        Keys.onBacktabPressed: consol.log("Backspace")

        Column {
            id: mainColumn
            spacing: 10
            anchors.rightMargin: 5
            anchors.leftMargin: 5
            anchors.bottomMargin: 10
            anchors.topMargin: 5
            anchors.fill: parent

            Label {
                id: ipLabel
                text: qsTr("My ip: ")+ wsServer.getLocalAddress();
            }

            Label {
                id: clientsLabel
                text: qsTr("WS clients: ")
            }

//            Label {
//                id: oscCountLabel
//                text: qsTr("OSC targets: ")
//            }

            CheckBox {
                id: wsCheckBox
                enabled: false
                text: qsTr("Send WS signals")
                checked: false
                onCheckedChanged: wsServer.setSendWs(checked);
            }

            CheckBox {
                id: oscCheckBox
                enabled: false
                text: qsTr("Send server's OSC signals")
                checked: false
                onCheckedChanged: wsServer.setSendOsc(checked);

            }

            Row {
                spacing:5
                id: jackRow

                CheckBox {
                    id: jackCheckBox
                    visible: (Qt.platform.os === "linux")
                    text: "Read from Jack"
                    checked: false
                    onCheckedChanged: {
                        if (checked) jackReader.start()
                        // else jackReader.stop()  // NOT good - cannot start again
                    }
                }

                CheckBox {
                    id: timeCodeCheckBox
                    visible: (Qt.platform.os === "linux")
                    text: "BBT to timecode hack"
                    checked: false
                    onCheckedChanged: jackReader.setZeroHack(checked)
                }

            }

            CheckBox {
                id: testCheckbox
                visible: false ; //TODO: make invisible or depending on options
                text: qsTr("Test regularity")
                checked: false
                onCheckedChanged: wsServer.setTesting(checked);
            }

            Row {
                id: csOptionsRow
                spacing: 5

                Label {
                    //id: oscLabel
                    text: qsTr("Csound Options: ")
                }

                TextField {
                    id: csoundOptions
                    width: 400
                    placeholderText: qsTr("Csound options")
                    text: "-odac -+rtaudio=null -d"
                }

                Button {
                    text: "Reset"
                    onClicked: csoundOptions.text = "-odac -+rtaudio=null -d"
                }


            }

            Row {
                id: soundFilesRow
                spacing: 5
                visible: volumeLabel.visible // don't show if there is no audio output. volumeLabel checks that

                Label {
                    text: qsTr("Direcotry of soundfiles (SFDIR): ")
                }

                TextField {
                    id: sfdirField
                    width: 300
                    placeholderText: qsTr("SFDIR for Csound")
                    text: "./";

                }

                Button {
                    text: qsTr("Select")
                    onClicked: { sfdirDialog.visible=true }
                }

            }



            Row {
                id: oscRow
                width: parent.width
                //height: 30
                spacing: 5

                Label {
                    //id: oscLabel
                    text: qsTr("Clients: ")
                }

                TextField {
                    id: oscAddresses
                    width: 400
                    placeholderText: qsTr("OSC addresses")
                    text: wsServer.getOscAddresses();


                }

                Button {
                    id: editOscButton
                    text: qsTr("Update")
                    onClicked: wsServer.setOscAddresses(oscAddresses.text);
                }

                Button {
                    id: addLocalhostButton
                    text: qsTr("+ this computer")
                    //tooltip: qsTr("To send messages to client in the same computer")
                    onClicked: {
                        if (oscAddresses.text.indexOf("127.0.0.1")<0 ) {
                            oscAddresses.text += ",127.0.0.1 ";
                            wsServer.setOscAddresses(oscAddresses.text)
                        }

                    }
                }
            }

            Row {
                id: fileRow
                width: parent.width
                height: 30
                spacing: 5

                Label {
                    id: fileLabel
                    text: qsTr("Score file: ")
                }

                TextField {
                    id: scoField
                    width: 200
                    placeholderText: qsTr("score file")
                    text: ":/csound/test.sco";

                }

                Button {
                    id: loadButton
                    text: qsTr("Load")
                    onClicked: fileDialog.visible=true
                }

                Button {
                    id: testScoreButton
                    text: qsTr("Test-score")
                    onClicked: scoField.text=":/csound/test.sco"
                }
            }

            Row {
                id: startRow
                x: 0
                width: parent.width
                height: 42
                spacing: 5

                Label {
                    id: label2
                    text: qsTr("Start from:")
                }

                SpinBox {
                    id: startBarSpinBox
                    editable: true
                    width: label2.width*1.25 // most likely enough to hold 999999
                    to: 1000000 // to enable very large complex bar numbers like 10101
                    from: 1
//                    onEditingFinished: cs.start(scoField.text, startBarSpinBox.value )
                }

                Button {
                    id: startButton
                    text: qsTr("Start")

                    Timer {
                        id: setVolumeTimer
                        repeat: false
                        interval: 500
                        onTriggered: cs.setChannel("volume", volumeSlider.value)
                    }

                    onClicked: {
                        cs.setOscAddresses(oscAddresses.text);
                        cs.start(scoField.text, startBarSpinBox.value)
                        messageArea.text = ""
                        // set volume somewhat later when Csound will be loaded
                        setVolumeTimer.start()
                        if (startCommand.length > 0) {
                            console.log("executing command: ", startCommand)
                            wsServer.runSystemCommand(startCommand)
                        }
                    }
                }

                Button {
                    id: stopButton
                    text: qsTr("Stop")
                    onClicked: {
                        cs.stop()
                        if (stopCommand.length > 0) {
                            console.log("executing command: ", stopCommand)
                            wsServer.runSystemCommand(stopCommand)
                        }
                    }
                }

                Label {
                    id: volumeLabel
                    text: qsTr("Volume:")
                    visible: (csoundOptions.text.indexOf("-+rtaudio=null")<0 && csoundOptions.text.indexOf("-n ")<0) // if not containg null or -n then probably sending audio
                }

                Slider {
                    width: 100
                    id: volumeSlider
                    visible: volumeLabel.visible
                    value: 1
                    from: 0
                    to:  1.5
                    onValueChanged: cs.setChannel("volume", value)
                }
            }

            Row {
                id: beatRow
                width: parent.width
                height: 60
                spacing: 20

                Label {
                    id: label1
                    text: qsTr("Bar: ")
                }

                Label {
                    id: barLabel
                    text: qsTr("0")
                    font.pointSize: 32
                }

                Label {
                    id: label3
                    text: qsTr("Beat: ")
                }

                Label {
                    id: beatLabel
                    text: qsTr("0")
                    font.pointSize: 32
                }

                Label {
                    id: label4
                    text: qsTr("Tempo: ")
                }

                Label {
                    id: tempoLabel
                    text: qsTr("0")
                    //font.pointSize: 16
                }
            }
            Label {
                id: label6
                text: qsTr("Csound messages:")
                visible: true
            }

            TextArea {
                id: messageArea
                visible: true
                readOnly: true
                font.pointSize: 8
                font.family: "Courier"
                height: (mainColumn.y+mainColumn.height)-y
                width: parent.width
                text:"Csound messages"
            }

        }






    }
}
