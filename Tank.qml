import QtQuick 2.0
import "qrc:/shanbay.js" as Shanbay
Rectangle {
    property string word: ""
    property string visible_word: ""
    property bool current: false
    property double image_x: iamge.x
    property double image_y: iamge.y

    id: tank


//    color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
    color: current ? "#132B2B" : 'black' //transparent
//    opacity: 0.8
    width: text.width +16
    height: 16//text.height + 10
    Component.onCompleted: {


    }
    signal word_destroy(string word)
//    Component.onDestroyed: {
//        word_destroy(word)

//    }


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
        tank.visible = false
        tank.word_destroy(word)

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

    Image {
        id: iamge
        width: 32
        height: 32
        anchors.left: text.right
//        anchors.right: parent.right
        x: -32
//        anchors.bottom: parent.bottom
//        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/ztype/mine.png"
        fillMode: Image.Stretch

    }
//    Component.onCompleted:
    Timer {
        id:timer
        interval: 200
        repeat: true
        onTriggered: {
            x += (Math.random() * 100 - 50) / 100
//            if (x > parent.width) x -= 5
            if (x < 0) x +=2

            y += Math.random()
            iamge.rotation += 10

        }
    }
    Timer {
        id: destroy_timer
        interval: 200
        onTriggered: {
            tank.word_destroy(word)

            tank.destroy()
            console.log("destroy")
//            Shanbay.shanbay(word, function(data){
//                console.log(data)
//            })
        }
    }
}
