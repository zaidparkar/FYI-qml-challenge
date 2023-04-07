import QtQuick
import QtQuick.Window
import QtMultimedia

Window {
    id: window
    visible: true
    width: 720
    height: 480
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

        id: button

        // public
        property string text: 'Play'

        // private
        width: 50;  height: 30 // default size
        border.color: text? 'black': 'transparent' // Keyboard
        border.width: 0.05 * button.height
        radius:       0.2  * button.height
        opacity:      enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state
        anchors.top: player.bottom
        anchors.horizontalCenter: parent.horizontalCenter

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




    //    MediaPlayer {
    //        id: mediaPlayer
    //        source: "resources/sample.mp4"
    //    }

    //    VideoOutput {
    //        id: videoOutput
    //        anchors.fill: parent
    //    }

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






