import QtQuick
import QtQuick.Window
import QtMultimedia

Window {        // main window of the application
    id: window
    visible: true
    width: 800
    height: 600
    title: "Video Player"

    // Two helper functions
    function handleButtonClick() {  // this function handles the play and pause of the video
        if(button.text == 'Play') {
            button.text = 'Pause'
            videoPlayer.play()
        }
        else {
            button.text = 'Play'
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
            source: "qrc:/resources/assets/sample.mp4"
        }
    }


    Rectangle {
        id: slider
        width: (player.width - 60)
        height: 10
        anchors.top: player.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 20
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
                }
            }
        }

        Text {
            id: sliderText
            text: formatTime(sliderPosition)
            font.pixelSize: 12
            color: "black"
            anchors.bottom: parent.top
            anchors.bottomMargin: 2
            anchors.horizontalCenter: sliderHandle.horizontalCenter
            visible: true
        }
    }


    Rectangle {

        id: button

        property string text: 'Play'

        // private
        width: 50;  height: 30
        border.color: text? 'black': 'transparent'
        border.width: 0.05 * button.height
        radius: 0.2 * button.height
        opacity: enabled  &&  !mouseArea.pressed? 1: 0.5
        anchors.top: slider.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5


        Text {
            text: button.text
            font.pixelSize: 0.5 * button.height
            anchors.centerIn: parent
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: handleButtonClick();
        }
    }
}
