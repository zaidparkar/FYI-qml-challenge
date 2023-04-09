import QtQuick
import QtQuick.Window
import QtMultimedia

Window {
    id: window
    visible: true
    width: 800
    height: 600
    title: "Video Player"

    function handleButtonClick() {
        if(button.text == 'Play') {
            button.text = 'Pause'
            videoPlayer.play()
        }
        else {
            button.text = 'Play'
            videoPlayer.pause()
        }
    }

    function formatTime(time) {
        var minutes = Math.floor(time / 60);
        var seconds = time % 60;
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
//            onPositionChanged: {
//                if (sliderHandle.drag && !sliderHandle.drag.active) {
//                    sliderPosition = videoPlayer.position;
//                    sliderHandle.x = (slider.width - sliderHandle.width) * (sliderPosition / videoDuration);
//                    console.log(sliderHandle.x + "\n" + sliderPosition)
//                }
//            }
        }
    }

//    Rectangle {
//        id: slider
//        width: (player.width - 60)
//        height: 10
//        anchors.top: player.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.topMargin: 20
//        color: "gray"

//        Rectangle {
//            id: sliderHandle
//            width: 20
//            height: 20
//            color: "white"
//            border.width: 1
//            border.color: "black"
//            anchors.verticalCenter: parent.verticalCenter
//            x: (parent.width - width) * (sliderPosition / videoDuration)

//            MouseArea {
//                id: drag
//                anchors.fill: parent
//                drag.target: sliderHandle
//                drag.axis: Drag.XAxis
//                drag.minimumX: 0
//                drag.maximumX: slider.width - sliderHandle.width
//                onPositionChanged: {
//                    sliderPosition = Math.round(sliderHandle.x / (parent.width - sliderHandle.width) * videoDuration)
//                    videoPlayer.seek(sliderPosition)
//                }
//            }
//        }

//        Text {
//            text: formatTime(sliderPosition)
//            font.pixelSize: 12
//            color: "black"
//            anchors.bottom: parent.top
//            anchors.horizontalCenter: sliderHandle.horizontalCenter
//            visible: true
//        }

//    }

    Rectangle { // background
        id: progressBar

        // public
        property double maximum: 10
        property double value:   currentPosition
        property double minimum: 0

        // private
        width: 600;  height: 15 // default size

        anchors.top: player.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 5
        border.width: 0.05 * progressBar.height
        radius: 0.3 * height

        Rectangle { // foreground
            id: foreground
            visible: progressBar.value > progressBar.minimum
            x: 0.1 * progressBar.height
            y: 0.1 * progressBar.height
            width: 0
            height: 0.8 * progressBar.height
            color: 'black'
            radius: parent.radius


        }

        Timer {
            interval: 50 // Update the progress bar every 100 milliseconds
            running: true
            repeat: true
            onTriggered: {
                currentPosition = videoPlayer.position
                foreground.width = (currentPosition/videoDuration) * parent.width
            }
        }
    }


    Rectangle {

        id: button

        // public
        property string text: 'Play'

        // private
        width: 50;  height: 30 // default size
        border.color: text? 'black': 'transparent' // Keyboard
        border.width: 0.05 * button.height
        radius:       0.2  * button.height
        opacity:      enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state
        anchors.top: progressBar.bottom
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


//    Rectangle {
//        id: controls
//        width: parent.width
//        height: 50
//        color: "#333333"
//        anchors.bottom: parent.bottom

//        Row {
//            spacing: 10

//            Rectangle {
//                id: playButton
//                width: 30
//                height: 30
//                color: "#555555"
//                border.color: "#aaaaaa"
//                border.width: 1
//                radius: 5
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        mediaPlayer.playbackState == MediaPlayer.PlayingState ? mediaPlayer.pause() : mediaPlayer.play()
//                    }
//                    onEntered: {
//                        cursorShape = Qt.PointingHandCursor
//                    }
//                    onExited: {
//                        cursorShape = Qt.ArrowCursor
//                    }
//                }
//                Image {
//                    source: mediaPlayer.playbackState == MediaPlayer.PlayingState ? "qrc:/pause.png" : "qrc:/play.png"
//                    anchors.centerIn: parent
//                }
//            }

//            Rectangle {
//                width: parent.width - playButton.width - pauseButton.width - 50
//                height: 20
//                color: "#666666"
//                MouseArea {
//                    anchors.fill: parent
//                    property real sliderWidth: 20
//                    property real sliderHalfWidth: sliderWidth / 2
//                    onPositionChanged: {
//                        var xPos = Math.min(Math.max(mouseX - sliderHalfWidth, 0), parent.width - sliderWidth);
//                        mediaPlayer.position = (xPos / (parent.width - sliderWidth)) * mediaPlayer.duration;
//                    }
//                    onReleased: {
//                        mediaPlayer.play()
//                    }
//                    onEntered: {
//                        cursorShape = Qt.PointingHandCursor
//                    }
//                    onExited: {
//                        cursorShape = Qt.ArrowCursor
//                    }

//                    Rectangle {
//                        id: progressSlider
//                        height: parent.height
//                        color: "white"
//                        width: Math.min(mediaPlayer.position / mediaPlayer.duration * parent.width, parent.width)
//                        MouseArea {
//                            anchors.fill: parent
//                            drag.target: progressSlider
//                            drag.axis: Drag.XAxis
//                            drag.minimumX: 0
//                            drag.maximumX: parent.width - progressSlider.width
//                            onPositionChanged: {
//                                mediaPlayer.position = (x / (parent.width - progressSlider.width)) * mediaPlayer.duration;
//                            }
//                            onReleased: {
//                                mediaPlayer.play()
//                            }
//                            onEntered: {
//                                cursorShape = Qt.PointingHandCursor
//                            }
//                            onExited: {
//                                cursorShape = Qt.ArrowCursor
//                            }

//                            Rectangle {
//                                id: slider
//                                width: parent.height
//                                height: parent.height
//                                color: "#555555"
//                                border.color: "#aaaaaa"
//                                border.width: 1
//                                anchors.verticalCenter: parent.verticalCenter
//                                anchors.left: parent.left
//                                anchors.leftMargin: 1
//                                anchors.right: progressSlider.left
//                                anchors.rightMargin: 1
//                            }
//                        }
//                    }
//                }
//            }

//            Rectangle {
//                id: pauseButton
//                width: 30
//                height: 30
//                color: "#555555"
//                border.color: "#aaaaaa"
//                border.width: 1
//                radius: 5
//                MouseArea {
//                    anchors.fill: parent
//                    onClicked: {
//                        mediaPlayer.pause()
//                    }
//                    onEntered: {
//                        cursorShape = Qt.PointingHandCursor
//                    }
//                    onExited: {
//                        cursorShape = Qt.ArrowCursor
//                    }
//                }
//                Image {
//                    source: "qrc:/pause.png"
//                    anchors.centerIn: parent
//                }
//            }
//           }
//    }
//}






