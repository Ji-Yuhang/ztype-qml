import QtQuick 2.0
import "qrc:/shanbay.js" as Shanbay
Rectangle {
    property string word: ""
    property string visible_word: ""
    property bool current: false

    id: tank

//    color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
    color: current ? "#132B2B" : 'black' //transparent
//    opacity: 0.8
    width: text.width + 10
    height: text.height + 2
    Component.onCompleted: {


    }
    onCurrentChanged: {
        z = 2

    }
    NumberAnimation on x {
//        to: 300

    }

    function start() {
        timer.start();
    }
    function custom_destroy() {
        timer.stop()
//        visible = false
//        destroy()
        destroy_timer.start()
    }
//    onDestroyed:
//    onDestroyed: {
//        console.log("onDestroyed")
//    }

    Text {
        id: text
        text: visible_word
        visible: true
        color: current ? "orange":"white"
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
        interval: 200
        repeat: true
        onTriggered: {
            x += (Math.random() * 100 - 50) / 100
//            if (x > parent.width) x -= 5
            if (x < 0) x +=5

            y += Math.random() * 2

        }
    }
    Timer {
        id: destroy_timer
        interval: 1000
        onTriggered: {
            tank.destroy()
            console.log("destroy")
//            Shanbay.shanbay(word, function(data){
//                console.log(data)
//            })
        }
    }
}
