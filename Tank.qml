import QtQuick 2.0

Rectangle {
    property string word: ""
    property string visible_word: ""

//    color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
    color: "black"
    width: text.width + 10
    height: text.height + 2
    Component.onCompleted: {


    }

    function start() {
        timer.start();
    }
    function custom_destroy() {
        timer.stop()
//        visible = false
        destroy()
        console.log("destroy")
    }
//    onDestroyed:
//    onDestroyed: {
//        console.log("onDestroyed")
//    }

    Text {
        id: text
        text: visible_word
        visible: true
        color: "white"
        font {
            pointSize: 14
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
