import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQml 2.0
import QtQuick.Dialogs


Window {        // main window of the application
    id: window
    visible: true
    width: 800
    height: 600
    title: "Video Player"

    // Two helper functions


    function showMessage(p1,p2) {
        messageDialog.title = p1;
        messageDialog.text = p2;
        messageDialog.visible = true;
    }


    function handleplayButtonClick() {  // this function handles the play and pause of the video
        if(playButton.text == 'Play') {
            if(!videoPlayer.source) {
                playButton.text = 'Pause'
                videoPlayer.play()
            }
            else{
                showMessage("Warning", "Please select a file first")
            }
        }
        else {
            playButton.text = 'Play'
            videoPlayer.pause()
        }
    }

    function formatTime(time) {  // this function formats the time in ms to display as mm:ss
        var minutes = Math.floor(time / 60000);
        var seconds = Math.trunc(time / 1000);
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
    }

    property double videoDuration: videoPlayer.duration
    property double sliderPosition: 0
    property double currentPosition: videoPlayer.position

    FileDialog {
        id: fileDialog
        title: "Open Video"
        currentFolder: Qt.resolvedUrl(".")
        nameFilters: [ "Video files (*.mp4)", "All files (*)" ]
        onAccepted: {
            var filePath = fileDialog.selectedFile
            if (filePath !== '') {
                videoPlayer.source = filePath
            }
        }
    }

    MessageDialog {
        id: messageDialog
        title: "Alert"
        onAccepted: visible = false
    }

    Rectangle {

        id: player
        visible: true
        width: 700
        height: 400
        anchors.centerIn: parent
        color: "black"

        Video {
            id: videoPlayer
            anchors.fill: parent
        }
    }


    Rectangle {
        id: slider
        width: (player.width - 60)
        height: 10
        anchors.top: player.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 22
        color: "gray"


        Rectangle {
            id: progress
            width: (sliderHandle.x + sliderHandle.width / 2)
            height: slider.height
            color: "red"
        }

        Rectangle {
            id: sliderHandle
            width: 20
            height: 20
            radius: 0.5 * sliderHandle.height
            color: "white"
            border.width: 1
            border.color: "black"
            anchors.verticalCenter: parent.verticalCenter
            x: (parent.width - width) * (sliderPosition / videoDuration)

            MouseArea {
                id: drag
                anchors.fill: parent
                drag.target: sliderHandle
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: 10
                onPositionChanged: {
                    sliderHandle.x = mouseX - sliderHandle.width / 2;
                    videoPlayer.position = sliderHandle.x / slider.width * videoPlayer.duration;
                }
            }

            Timer {
                interval: 50 // Update the text on the slider, the progress bar and the sliderhandle every 50 milliseconds
                running: true
                repeat: true
                onTriggered: {
                    currentPosition = videoPlayer.position
                    sliderHandle.x = (currentPosition/videoDuration) * slider.width
                    sliderText.text = formatTime(currentPosition)
                    progress.width = sliderHandle.x + sliderHandle.width / 2
                    if(currentPosition==videoDuration) {
                        playButton.text = 'Play'
                    }
                }
            }
        }

        Text {
            id: sliderText
            text: formatTime(sliderPosition)
            font.pixelSize: 12
            color: "black"
            anchors.bottom: parent.top
            anchors.bottomMargin: 4
            anchors.horizontalCenter: sliderHandle.horizontalCenter
            visible: true
        }
    }


    Rectangle {
        width: playButton.width + fileButton.width +5
        height: playButton.width

        anchors.top: slider.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10

        Rectangle {

            id: playButton

            property string text: 'Play'

            width: 50;
            height: 30

            border.color: text? 'black': 'transparent'
            border.width: 0.05 * playButton.height

            radius: 0.2 * playButton.height
            opacity: enabled  &&  !mouseArea.pressed? 1: 0.5
            anchors.left: fileButton.right
            anchors.leftMargin: 5

            Text {
                text: playButton.text
                font.pixelSize: 0.5 * playButton.height
                anchors.centerIn: parent
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: handleplayButtonClick();
            }

        }


        Rectangle {

            id: fileButton

            property string text: 'Add File'

            // private
            width: 65;  height: 30
            border.color: text? 'black': 'transparent'
            border.width: 0.05 * fileButton.height
            radius: 0.2 * fileButton.height
            opacity: enabled  &&  !mouseArea.pressed? 1: 0.5

            Text {
                text: fileButton.text
                font.pixelSize: 0.5 * fileButton.height
                anchors.centerIn: parent
            }

            MouseArea {
                id: fileButtonMouseArea
                anchors.fill: parent
                onClicked: fileDialog.open()
            }
        }
    }
}
