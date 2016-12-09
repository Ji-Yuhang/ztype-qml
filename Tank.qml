import QtQuick 2.0

Rectangle {
    property string word: ""
//    color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
    color: "red"
    width: text.width + 10
    height: text.height + 2
    Component.onCompleted: {


    }

    function start() {
        timer.start();
    }
    Text {
        id: text
        text: word
        visible: true
        color: "green"
        font {
            pointSize: 12
        }

        anchors.centerIn: parent
    }

//    Image {
//        id: iamge
//        source: ""
//    }
//    Component.onCompleted:
    Timer {
        id:timer
        interval: 500
        repeat: true
        onTriggered: {
            x += Math.abs((Math.random() * 100 - 50) / 10)

            y += Math.random() * 10

        }
    }

}
