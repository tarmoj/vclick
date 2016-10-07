import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 740
    height: 740
    title: qsTr("eClick server")
    property string version: "0.2.0-beta"

    menuBar: MenuBar {
        Menu {
            title: qsTr("&Menu")
            MenuItem {
                text: qsTr("&Settings")
                enabled: false
                //onTriggered: // messageDialog.show(qsTr("Open action triggered"));
            }
            MenuItem {
                text: qsTr("&About")
                onTriggered: messageDialog.show(qsTr("<b>eClick server "+ version + "</b><br>http://tarmoj.github.io/eclick<br><br>(c) Tarmo Johannes 2016<br><br>Built using Qt SDK and Csound audio engine."));
            }
            MenuItem {
                text: qsTr("E&xit")
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
        property alias readFromJack: jackCheckBox.checked
        property alias lastScorePath: fileDialog.folder
        property alias csoundOptions: csoundOptions.text
        property alias sfdir: sfdirField.text
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

        onUpdateOscAddresses: oscAddresses.text = adresses;

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
        folder: sfdirField.text
        selectFolder: true

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
                color: "#b3f50a";
            }

            GradientStop {
                position: 1.00;
                color: "#ffffff";
            }
        }
        anchors.fill: parent

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
                text: qsTr("Send ws")
                checked: false
                onCheckedChanged: wsServer.setSendWs(checked);
            }

            CheckBox {
                id: oscCheckBox
                text: qsTr("Send osc")
                checked: true
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
                visible: true ; //TODO: make invisible or depending on options
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
                    text: qsTr("&Update")
                    onClicked: wsServer.setOscAddresses(oscAddresses.text);
                }

                Button {
                    id: addLocalhostButton
                    text: qsTr("+ this computer")
                    tooltip: qsTr("To send messages to client in the same computer")
                    onClicked: {
                        if (oscAddresses.text.indexOf("127.0.0.1")<0 ) {
                            oscAddresses.text += ",localhost ";
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
                    text: qsTr("&Load")
                    onClicked: fileDialog.visible=true
                }

                Button {
                    id: testScoreButton
                    text: qsTr("&Test")
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
                    width: label2.width*1.25 // most likely enough to hold 999999
                    maximumValue: 1000000 // to enable very large complex bar numbers like 10101
                    minimumValue: 1
//                    onEditingFinished: cs.start(scoField.text, startBarSpinBox.value )
                }

                Button {
                    id: startButton
                    text: qsTr("Star&t")
                    onClicked: cs.start(scoField.text, startBarSpinBox.value)
                }

                Button {
                    id: stopButton
                    text: qsTr("&Stop")
                    onClicked: cs.stop()
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
