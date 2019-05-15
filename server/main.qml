import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2 //1.2
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2
import Qt.labs.settings 1.0
//import Qt.labs.platform 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 740
    height: 820
    title: qsTr("vClick server")
    property string version: "2.0.0-beta1"
    property string startCommand: "" // system command run on start for example send OSC message to Reaper
    property string stopCommand: "" // set in config file, so far no dialog for that...



    header: Row {
        Button {text:"Menu"; onClicked: mainMenu.open()}
        Menu {
            //minimumWidth: 350
            width: 350
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
                    value: 57878
                }
                Button { text: qsTr("Set"); onClicked: wsServer.setOscPort(oscPortSpinbox.value) }
                Button { text: qsTr("Reset"); onClicked: oscPortSpinbox.value = 57878 }
            }

            MenuItem {
                id: wsMenu
                checkable: true
                text: qsTr("Enable Websocket signals")
                onCheckedChanged: wsCheckBox.visible = checked //wsCheckBox.enabled = checked
            }

            MenuItem {
                id: oscMenu
                checkable: true
                text: qsTr("Enable server's OSC")
                onCheckedChanged: oscCheckBox.visible = checked
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
        property alias soundFile: soundFile.text
        property alias soundFileFolder: soundFileDialog.folder
        property alias countDownActive: countdown.checked
        property alias scoreFiles: scoreFilesModel.scoreFiles
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
            startButton.clicked()
        }

        onStop: cs.stop()

        onNewScoreIndex: scoreFilesList.setIndex(index)

        onNewStartBar: startBarSpinBox.value = startBar

    }

    function getBasename(url) {
        var basename = url.toString()
        basename = basename.slice(0, basename.lastIndexOf("/")+1)
        return basename
    }

    // necessary for android
    FilePicker {
        id: filePicker
        visible: false //showFileDialog
        anchors.fill: parent
        anchors.margins: 10
        lastFolder: fileDialog.folder
        //color: "green"
        z: 10

        onFileSelected: {
            scoField.text = fileURL
            fileDialog.folder = getBasename(fileURL)
            visible = false
        }
        onHidePressed: visible = false
    }


    FileDialog {
        id: fileDialog
        title: qsTr("Please choose score for metronome")
        nameFilters: [ "Csound score files (*.sco)", "All files (*)" ]
        folder: shortcuts.documents //"file://"
        onAccepted: {
            scoField.text = fileUrl
            folder = getBasename(fileUrl)
        }
        onRejected: {
            visible = false;
        }
    }

    // TODO: FilePicker for next ones.. Rewrite with condition.. to OS

    FileDialog {
        id: sfdirDialog
        title: qsTr("Please choose folder of playbacks soundfiles")

        folder: shortcuts.documents //sfdirField.text
        selectFolder: true

        onAccepted: {
            console.log("You chose: " + folder)
            sfdirField.text = folder
        }
        onRejected: {
            console.log("Canceled")
            visible = false;
        }
    }

    FileDialog {
        id: soundFileDialog
        title: qsTr("Please choose sound file")
        nameFilters: [ "Audio files (*.wav *.aif *.aiff *.mp3 *.ogg *.flac)", "All files (*)" ]
        folder: shortcuts.documents //"file://"
        onAccepted: {
            soundFile.text = fileUrl.toString().replace("file://", "")
            folder = getBasename(fileUrl)
        }
        onRejected: {
            visible = false;
        }
    }

    // List view to arrange several files

    ListModel {
        id: scoreFilesModel
        property string scoreFiles: ""

        ListElement {
            url: ":/csound/test.sco"
        }

       onDataChanged: {
           var helper = "";
           for (var i=0; i< count; i++) {
//               var element =  JSON.stringify(scoreFilesModel.get(i))
//               console.log(element)
               if (i>0) helper += ";"
               helper += scoreFilesModel.get(i).url;
           }
           scoreFiles = helper
           console.log(scoreFiles)
       }

        Component.onCompleted: {
            if (scoreFiles) {
                console.log(scoreFiles)
                scoreFilesModel.clear()
                var helperList = scoreFiles.split(";")
                for (var i = 0; i < helperList.length; i++) {
                    console.log("Parsed element: ", helperList[i])
                    scoreFilesModel.append({"url":helperList[i]})
                }
            }
        }
    }

    Rectangle {
        id: fileListRect

        height: parent.height *0.9
        width: parent.width * 0.8
        anchors.centerIn: parent
        color: "#ee827d7d"
        radius: Math.min(10, height*0.1)
        z: 3
        visible: false
        ListView {
            id: scoreFilesList

            function setIndex(index) {

                if (index>=0 && index < scoreFilesModel.count) {
                    scoreFilesList.currentIndex = index;
                    scoField.text = scoreFilesModel.get(index).url
                } else {
                    console.log("Listmodel index out of range")
                }
            }

            anchors.fill: parent
            anchors.margins: 10
            clip: true
            model: scoreFilesModel

            header: Row {
                //width: fileListRect.width
                anchors.margins: 10

                RoundButton {
                    text: "+"
                    onClicked: {
                        scoreFilesModel.append({"url":":/csound/test.sco"});
                    }
                }

                RoundButton {
                    text: "\u2a2f" // Unicode Character for cross
                    onClicked: fileListRect.visible = false
                }

            }

            delegate: Component {
                RowLayout {
                    spacing: 10
                    width: parent.width
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    TextField {
                        id: urlField
                        text: url
                        Layout.fillWidth: true
                        background: Rectangle { color: scoreFilesList.currentIndex == index ? "#F0A0A0A0" : "transparent" }

                    }
                    RoundButton {
                        text: qsTr("\u2713") // select
                        onClicked: {
                            url = urlField.text
                            scoreFilesList.setIndex(index)
                        }

                    }
                    RoundButton {
                        text: qsTr("\u21ba") // load
                        onClicked: {
                            fileListDialog.open()
                        }
                        FileDialog {
                            id: fileListDialog
                            title: qsTr("Please choose score for metronome")
                            nameFilters: [ "Csound score files (*.sco)", "All files (*)" ]
                            folder: "file://home/tarmo/tarmo/csound/metronome/scores"  // TODO: lastFolder
                            onAccepted: {
                                urlField.text = fileUrl
                                folder = getBasename(fileUrl)
                                // TODO: set also in fileModel
                                url = fileUrl.toString()
                                console.log("index: ", index, "url", url)
                                // temporary:
                                //fileDialog.folder = folder
                            }
                            onRejected: {
                                visible = false;
                            }
                        }
                    }

                    RoundButton {
                        text: qsTr("\u2a2f") // remove
                        onClicked: scoreFilesModel.remove(index)
                    }
                }
            }

            onCurrentIndexChanged: console.log("List index: ", currentIndex)
        }
    }



    Flickable {
        id: flickable1
        contentWidth: 740
        contentHeight: 820 // how to set it properly?
        anchors.fill: parent
        anchors.margins: 6
        clip: true

        Item {
            id: mainRect

            anchors.fill: parent

            //Shortcuts
            focus: true
            Keys.onPressed:  { // hack for playing tanja1.sco on F1 and tanja2.sco on F2 -  TODO: implement dialog window for multiple score files + shortcuts

                //console.log(event.key)

                if (event.key === Qt.Key_F1 || ((event.key === Qt.Key_1) && ( event.modifiers & Qt.ControlModifier) ) ) {
                    scoreFilesList.setIndex(0)

                }
                if (event.key === Qt.Key_F2) {
                    scoreFilesList.setIndex(1)
                }

                if (event.key === Qt.Key_F3) {
                    scoreFilesList.setIndex(3)
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
                    visible: true //wsCheckBox.checked
                    text: qsTr("WS clients: ")
                }

                //            Label {
                //                id: oscCountLabel
                //                text: qsTr("OSC targets: ")
                //            }

                CheckBox {
                    id: wsCheckBox
                    //enabled: false
                    visible: false
                    text: qsTr("Send WS signals")
                    checked: false
                    onCheckedChanged: wsServer.setSendWs(checked);
                }

                CheckBox {
                    id: oscCheckBox
                    //enabled: false
                    visible: false
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
                    id: soundFilesFolderRow
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



                RowLayout {
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
                        Layout.preferredWidth: 400
                        Layout.fillWidth: true
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

                    Button {
                        text: qsTr("Clear")
                        onClicked: {
                            oscAddresses.text = "";
                            wsServer.setOscAddresses("")
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
                        text: qsTr("Select")
                        onClicked: fileListRect.visible = true
                    }

                    Button {
                        visible: false
                        id: loadButton
                        text: qsTr("Load")
                        onClicked: {
                            if (Qt.platform.os==="android" ) {
                                filePicker.visible = true
                            } else {
                                fileDialog.visible=true
                            }
                        }
                    }

                    Button {
                        visible: false
                        id: testScoreButton
                        text: qsTr("Test-score")
                        onClicked: scoField.text=":/csound/test.sco"
                    }

                    RoundButton { text: "1"; onClicked: scoreFilesList.setIndex(0) }
                    RoundButton { text: "2"; onClicked: scoreFilesList.setIndex(1) }
                    RoundButton { text: "3"; onClicked: scoreFilesList.setIndex(2) }
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
                        width: 150
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

                RowLayout {
                    id: timeRow // if to just show time  like 0:0. 0:1 etc
                    spacing: 5


                    Label { text: qsTr("Count time from:") }


                    Frame {

                        RowLayout {
                            spacing: 2


                            Tumbler {
                                id: minutesTumbler
                                model: 60
                                visibleItemCount: 3
                                Layout.preferredHeight: 50

                            }

                            Label {text:":"}

                            Tumbler {
                                id: secondsTumbler
                                model: 60
                                visibleItemCount: 3
                                Layout.preferredHeight: 50
                            }
                        }

                    }

                    CheckBox {
                        id: countdown
                        checked: true
                        text: qsTr("Countdown")
                    }

                    Button {
                        id: startTimeButton
                        text: qsTr("Start")
                        onClicked: {
                            // TODO: check if rtaudio=null in settings, print warning!
                            console.log(minutesTumbler.currentIndex, ":", secondsTumbler.currentIndex )
                            cs.startTime(minutesTumbler.currentIndex*60+secondsTumbler.currentIndex, countdown.checked, playSoundfile.checked ?  soundFile.text : "" )
                            // TODO: set volume OR: use one Start button for score/time
                        }

                    }

                    Button {
                        id: resetTimeButton
                        text: qsTr("Reset")
                        onClicked: {
                            minutesTumbler.currentIndex = 0
                            secondsTumbler.currentIndex = 0
                        }
                    }

                }

                RowLayout {
                    id: soundFileRow
                    spacing: 5

                    CheckBox {id:playSoundfile; text:qsTr("Play soundfile")}

                    TextField  {
                        id: soundFile;
                        enabled: playSoundfile.checked
                    }

                    Button {
                        text: qsTr("Load")
                        onClicked: soundFileDialog.visible = true
                        enabled: playSoundfile.checked
                    }

                    Button {
                        text: qsTr("Clear")
                        onClicked: soundFile.text = ""
                        enabled: playSoundfile.checked
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

                ScrollView {
                    id: view
                    //anchors.fill: parent
                    height: (mainColumn.y+mainColumn.height)-y
                    //anchors.bottom: parent.bottom
                    //anchors.bottomMargin: 6
                    width: parent.width
                    clip: true


                    TextArea {
                        id: messageArea
                        visible: true
                        readOnly: true
                        font.pointSize: 8
                        font.family: "Courier"
                        anchors.fill:  parent
                        //height: (mainColumn.y+mainColumn.height)-y
                        //width: parent.width
                        text:"Csound messages"
                    }
                }

            }
        }
    }
}
