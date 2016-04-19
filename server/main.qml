import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Metronome server")

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
//            MenuItem {
//                text: qsTr("&Open")
//                onTriggered: console.log("Open action triggered");
//            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: Qt.quit();
            }
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


    }

    FileDialog {
        id: fileDialog
        title: "Please choose score for metronome"
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
            anchors.bottomMargin: 5
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

            CheckBox {
                id: jackCheckBox
                visible: (Qt.platform.os === "unix" || Qt.platform.os === "linux")
                text: "Read from Jack"
                checked: false
                onCheckedChanged: {
                    if (checked) jackReader.start()
                    // else jackReader.stop()  // NOT good - cannot start again
                }
            }


            Row {
                id: oscRow
                width: parent.width
                //height: 30
                spacing: 5

                Label {
                    //id: oscLabel
                    text: qsTr("Registered clients: ")
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
                    maximumValue: 1000
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


        }

        TextArea {
            id: textArea1
            y: 275
            visible: false
            frameVisible: true
            readOnly: true
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
        }

        Label {
            id: label6
            x: 10
            y: 285
            text: qsTr("Messages:")
            visible: false
        }



    }
}
