import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCore
import Qt.labs.platform 1.1 as Platform

ApplicationWindow {
    id: window
    visible: true
    width: 760
    height: 820
    title: qsTr("vClick Server")
    property string version:  Qt.application.version
    property string startCommand: "" // system command run on start for example send OSC message to Reaper
    property string stopCommand: "" // set in config file, so far no dialog for that...


    header: Row {
        x: 5

        Button { text: qsTr("Menu"); onClicked: mainMenu.open()}

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
                onTriggered: messageDialog.show(qsTr("<b>vClick server "+ version + "</b><br>http://tarmoj.github.io/vclick<br><br>(c) Tarmo Johannes 2016-2023<br><br>Built using Qt SDK and Csound audio engine."));
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
        property alias lastScorePath: scoreFilesList.lastFolder
        property alias csoundOptions: csoundOptions.text
        property alias sfdir: sfdirField.text
        property alias volume: volumeSlider.value
        property alias startCommand: window.startCommand
        property alias stopCommand: window.stopCommand
        property alias oscPort: oscPortSpinbox.value // don't need save the setting in wsServer any more now
        property alias soundFile: soundFile.text
        property alias playSoundFile: playSoundfile.checked
        property alias soundFileFolder: soundFileDialog.folder
        property alias countDownActive: countdown.checked
        property alias scoreFiles: scoreFilesModel.scoreFiles
        property alias lastScoreIndex: scoreFilesList.currentIndex
        property alias useTime: useTime.checked
    }

    Component.onCompleted: {
        wsServer.setOscPort(oscPortSpinbox.value)
    }

    Connections {
        target: wsServer
        function onNewConnection() {
            //console.log(connectionsCount)
            clientsLabel.text = qsTr("Clients: ") + connectionsCount;
        }
        function onNewBeatBar(bar, beat) {
            barLabel.text = bar;
            beatLabel.text = beat;
        }

        function onNewTempo(tempo) {tempoLabel.text = tempo; }

        function onUpdateOscAddresses(adresses) {
            oscAddresses.text = adresses;
            cs.setOscAddresses(oscAddresses.text);
        }

        function onCsoundMessage(message) {
            messageModel.append({"line":message})
            messageView.positionViewAtEnd()
        }

        function onStart() {
            startButton.clicked()
        }

        function onStop() { cs.stop() }

        function onNewScoreIndex(index)  { scoreFilesList.setIndex(index) }

        function onNewStartBar(startBar) { startBarSpinBox.value = startBar }

        function onNewUseScore(score) { if (score) useScore.checked = true; else useTime.checked = true; }

        function onNewStartTime(startSecond)  {
            var minute = Math.floor(startSecond/60)
            var seconds = startSecond%60;
            startTimeField.minutes = minute;
            startTimeField.seconds = seconds;
            startTimeField.text = minute + ":" + seconds;
        }

        function onNewCountdown(checke) { countdown.checked = checked }

        function onNewUseSoundFile(checked) { playSoundfile.checked = checked }

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
            scoField.text = file
            fileDialog.folder = getBasename(file)
            visible = false
        }
        onHidePressed: visible = false
    }


    Platform.FileDialog {
        id: fileDialog
        title: qsTr("Please choose score for metronome")
        nameFilters: [ "Csound score files (*.sco)", "All files (*)" ]
        folder: Platform.StandardPaths.writableLocation(Platform.StandardPaths.DocumentsLocation)
        onAccepted: {
            scoField.text = file
            folder = getBasename(file)
        }
        onRejected: {
            visible = false;
        }
    }

    // TODO: FilePicker for next ones.. Rewrite with condition.. to OS

    Platform.FolderDialog {
        id: sfdirDialog
        title: qsTr("Please choose folder of playbacks soundfiles")

        folder: Platform.StandardPaths.writableLocation(Platform.StandardPaths.DocumentsLocation)
        //selectFolder: true

        onAccepted: {
            console.log("You chose: " + folder)
            sfdirField.text = folder
        }
        onRejected: {
            console.log("Canceled")
            visible = false;
        }
    }

    Platform.FileDialog {
        id: soundFileDialog
        title: qsTr("Please choose sound file")
        nameFilters: [ "Audio files (*.wav *.aif *.aiff *.mp3 *.ogg *.flac)", "All files (*)" ]
        folder: Platform.StandardPaths.writableLocation(Platform.StandardPaths.DocumentsLocation)
        onAccepted: {
            var urlString = file.toString()
            urlString = Qt.platform.os === "windows" ? urlString.replace("file:///", "") : urlString.replace("file://", "")
            soundFile.text =  urlString
            folder = getBasename(file)
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
                if (i>0) helper += ";"
                helper += scoreFilesModel.get(i).url;
            }
            scoreFiles = helper
        }

        Component.onCompleted: {
            if (scoreFiles) {
                console.log(scoreFiles)
                scoreFilesModel.clear()
                var helperList = scoreFiles.split(";")
                for (var i = 0; i < helperList.length; i++) {
                    scoreFilesModel.append({"url":helperList[i]})
                }
            }

            editOscButton.clicked() // this creates OSC clients in wsServer properly (quick fix, better look at the code in wsServer)
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
            property string lastFolder: ""
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

            header: Item {
                width: fileListRect.width -  2* anchors.margins
                height: addButton.height * 1.1
                anchors.margins: 10

                RoundButton {
                    id: addButton
                    anchors.left: parent.left
                    text: "+"
                    onClicked: {
                        scoreFilesModel.append({"url":":/csound/test.sco"});
                    }
                }

                RoundButton {
                    anchors.right: parent.right
                    text: "\u2a2f" // Unicode Character for cross
                    onClicked: fileListRect.visible = false
                }

            }

            delegate: Component {
                RowLayout {
                    spacing: 10
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10

                    TextField {
                        id: urlField
                        text: url
                        Layout.fillWidth: true
                        Layout.preferredWidth: scoreFilesList.width * 0.6
                        background: Rectangle { color: scoreFilesList.currentIndex === index ? "#F0A0A0A0" : "transparent" }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: scoreFilesList.setIndex(index)
                        }

                    }
                    RoundButton {
                        text: qsTr("\u2713") // select
                        onClicked: {
                            url = urlField.text
                            scoreFilesList.setIndex(index)
                        }

                    }
                    RoundButton {
                        //text: qsTr("\u21ba") // load
                        icon.source: "qrc:///folder.png"
                        onClicked: {
                            fileListDialog.open()
                        }

                    }

                    RoundButton {
                        text: qsTr("\u2a2f") // remove
                        onClicked: scoreFilesModel.remove(index)


                        Platform.FileDialog { // FileDialog here causes binding loop warning. Ingore it.
                            id: fileListDialog
                            title: qsTr("Please choose score for metronome")
                            nameFilters: [ "Csound score files (*.sco)", "All files (*)" ]
                            folder: scoreFilesList.lastFolder  //"file://home/tarmo/tarmo/csound/metronome/scores"  // TODO: lastFolder
                            onAccepted: {
                                urlField.text = file
                                scoreFilesList.lastFolder = getBasename(file)
                                url = file.toString()
                                console.log("index: ", index, "url", url)
                            }
                            onRejected: {
                                visible = false;
                            }
                        }

                    }

                    Item {Layout.fillWidth: true} // does not seem to do the job...



                }
            }

            //onCurrentIndexChanged: console.log("List index: ", currentIndex)
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
                        text: "Sound"
                        onClicked: csoundOptions.text = "-odac -d"
                    }

                    Button {
                        text: "No sound"
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

                // -----------------------------------------------------------------------

                Item {width: 10; height: 15} // just some extra space

                // CONTROLS -  START /STOP, SCORE/TIME -----------------------------------

                RowLayout {
                    Label {text: qsTr("Use: ")}
                    RadioButton {
                        id: useScore
                        text: qsTr("Score")
                        checked: true
                    }
                    RadioButton {
                        id: useTime
                        text: qsTr("Time")
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
                            if (useScore.checked) {
                                cs.setOscAddresses(oscAddresses.text);
                                cs.start(scoField.text, startBarSpinBox.value)
                                messageModel.clear()
                            }
                            if (useTime.checked) {
                                if (playSoundfile.checked && csoundOptions.text.indexOf("null")>=0) {
                                    console.log("Seems that Csound is set to no audio output. Use -odac (or similar) as Csound option")
                                    //TODO: Options
                                }

                                // TODO: check if rtaudio=null in settings, print warning!
                                startTimeField.convertToTime(); // text to minutes/seconds
                                cs.startTime(startTimeField.minutes*60+startTimeField.seconds, countdown.checked, playSoundfile.checked ?  soundFile.text : "" )
                            }

                            // set volume somewhat later when Csound will be loaded
                            if (volumeLabel.visible ) {
                                setVolumeTimer.start()
                            }

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
                    id: fileRow
                    width: parent.width
                    //height: 30
                    spacing: 3
                    visible: scoreControls.visible


                    Label {
                        id: fileLabel
                        text: qsTr("Score: ")
                    }



                    TextField {
                        id: scoField
                        width: 200
                        placeholderText: qsTr("Score file")
                        text: ":/csound/test.sco";

                    }

                    Button {
                        text: qsTr("List")
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
                    RoundButton { text: "4"; onClicked: scoreFilesList.setIndex(3) }

                }


                RowLayout {
                    id: scoreControls
                    visible: useScore.checked

                    Label {
                        id: label2
                        text: qsTr("Start from bar:")
                    }

                    SpinBox {
                        id: startBarSpinBox
                        editable: true
                        width: 150
                        to: 1000000 // to enable very large complex bar numbers like 10101
                        from: 1
                    }

                    Button {
                        text: qsTr("Reset")
                        onClicked: startBarSpinBox.value = 1
                    }
                }

                RowLayout {
                    id: timeRow // if to just show time  like 0:0. 0:1 etc
                    spacing: 5
                    visible: useTime.checked


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
                        font.pointSize: 20
                        text: "00:00"
                        //validator: RegExpValidator { regExp: /^([0-1\s]?[0-9\s]|2[0-3\s]):([0-5\s][0-9\s])$ / } // seems that it is not need if inputMask is there
                        onAccepted: {convertToTime()  }
                    }

                    CheckBox {
                        id: countdown
                        checked: true
                        text: qsTr("Countdown")
                    }


                    Button {
                        id: resetTimeButton
                        text: qsTr("Reset")
                        onClicked: {
                            startTimeField.text = "00:00"
                            startTimeField.convertToTime(); // for any case, also done in startButton.onClicked()
                        }
                    }

                }


                RowLayout {
                    id: soundFileRow // this belongs to showTime group actually, but easier to hold as sibling, then it is placed nicely to column
                    spacing: 5
                    visible: timeRow.visible

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

                // -----------------------------------------------------------------------

                Item {width: 10; height: 20} // just some extra space

                // SHOW BEAT, BAR, TEMPO

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


                ListView {
                    visible: true
                    id: messageView
                    height: (mainColumn.y+mainColumn.height)-y
                    //anchors.bottom: parent.bottom
                    //anchors.bottomMargin: 6
                    width: parent.width
                    clip: true

                    model: ListModel {
                        id: messageModel
                        ListElement { line: "Csound console" }
                    }

                    delegate: Label {
                        font.pointSize: 8
                        font.family: "Courier"
                        text: line
                    }

                    ScrollBar.vertical: ScrollBar {
                        active: true
                    }

                }
            }
        }
    }
}
