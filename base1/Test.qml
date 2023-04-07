import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQml

Window {
    title: "Video Player"
    width: 640
    height: 480
    visible: true

    MediaPlayer {
        id: player
        source: "file:/resources/assets/sample.mp4"
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    MouseArea {
        id: playArea
        anchors.fill: parent
        onPressed: mediaplayer.play();
    }
}

//    MouseArea {
//        anchors.fill: parent
//        onPressed: mediaplayer.play();
//    }

//    Rectangle {
//        width: 100
//        height: 40
//        color: "gray"
//        border.color: "black"
//        border.width: 1
//        radius: 5
//        Text {
//            text: player.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
//            anchors.centerIn: parent
//        }
//        MouseArea {
//            anchors.fill: parent
//            onClicked: player.playbackState === MediaPlayer.PlayingState ? player.pause() : player.play()
//        }
//    }

//    Rectangle {
//        width: parent.width
//        height: 20
//        color: "lightgray"
//        y: parent.height - height


//        //            onMoved: player.position = value


//        Item {
//            id: root

//            // public
//            property double maximum: player.duration
//            property double value: player.position
//            property double minimum:  0

//            anchors.fill: parent

//            signal clicked(double value);  //onClicked:{root.value = value;  print('onClicked', value)}

//            // private
//            width: 500;  height: 100 // default size
//            opacity: enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state

//            Repeater { // left and right trays (so tray doesn't shine through pill in disabled state)
//                model: 2

//                delegate: Rectangle {
//                    x:     !index?               0: pill.x + pill.width - radius
//                    width: !index? pill.x + radius: root.width - x;  height: 0.1 * root.height
//                    radius: 0.5 * height
//                    color: 'black'
//                    anchors.verticalCenter: parent.verticalCenter
//                }
//            }

//            Rectangle { // pill
//                id: pill

//                x: (value - minimum) / (maximum - minimum) * (root.width - pill.width) // pixels from value
//                width: parent.height;  height: width
//                border.width: 0.05 * root.height
//                radius: 0.5 * height
//            }

//            function setPixels(pixels) {
//                var value = (maximum - minimum) / (root.width - pill.width) * (pixels - pill.width / 2) + minimum // value from pixels
//                clicked(Math.min(Math.max(minimum, value), maximum)) // emit
//            }

//            MouseArea {
//                id: mouseArea

//                anchors.fill: parent

//                drag {
//                    target:   pill
//                    axis:     Drag.XAxis
//                    maximumX: root.width - pill.width
//                    minimumX: 0
//                }

//                onPositionChanged:  if(drag.active) setPixels(pill.x + 0.5 * pill.width) // drag pill
//                onClicked:                          setPixels(mouse.x) // tap tray
//            }


//        }
//    }


//    Connections {
//        target: player
//        function onClicked(mouse) { playPauseButton.text = player.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play" }
//        playingChanged: {
//            playPauseButton.text = player.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
//        }
//        positionChanged: {
//            slider.value = player.position
//        }
//    }

//}
