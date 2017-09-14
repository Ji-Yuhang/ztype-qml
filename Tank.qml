import QtQuick 2.0
import "qrc:/shanbay.js" as Shanbay
import "qrc:/lodash_qml.js" as Lodash

Rectangle {
    property string word: ""
    property string visible_word: ""
    property bool current: false
    property double image_x: iamge.x
    property double image_y: iamge.y
    property var scene: NULL

    id: tank


//    color: Qt.rgba(Math.random(),Math.random(),Math.random(),Math.random())
    color: current ? "#132B2B" : 'black' //transparent
//    opacity: 0.8
    width: text.width +16
    height: 16//text.height + 10
    Component.onCompleted: {
        timer.start();

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

//    function start() {
//        timer.start();
//    }
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
    Rectangle{
        color: current ? "#132B2B" : 'black' //transparent
        anchors.top: text.bottom
        anchors.horizontalCenter: text.horizontalCenter
        width: yinjie.width +16
        height: {
            if (current) {
                if (root && root.webster){
                    var h = 25
                    var webster_data = root.webster[word]
                    var yinjie = Lodash._.get(webster_data, '1')
                    var yinbiao = Lodash._.get(webster_data, '2')
                    if (yinjie && yinbiao) return h*2
                    if (yinjie && !yinbiao) return h
                    if (!yinjie && yinbiao) return h
                    if (!yinjie && !yinbiao) return 0

                } else {
                    return 0
                }
            } else {
                return 0
            }
        }
        Text {
            id: yinjie
            visible: current
            z:3
//            width: text.width +16
//            height: 32
            text: {
                if (root && root.webster){
                    var webster_data = root.webster[word]
                    var yinjie = Lodash._.get(webster_data, '1')
                    var yinbiao = Lodash._.get(webster_data, '2')

                    console.log('webster_data', webster_data, yinjie, yinbiao)
                    return yinjie || ''

                }
                return ''

            }

            color: current ? "orange":"white"
            font {
                pointSize: 14
            }

//            anchors.top: text.bottom
//            anchors.horizontalCenter: text.horizontalCenter
        }
        Text {
            id: yinbiao
            visible: current
            z:3
            text: {
                if (root && root.webster){
                    var webster_data = root.webster[word]
                    var yinjie = Lodash._.get(webster_data, '1')
                    var yinbiao = Lodash._.get(webster_data, '2')

                    console.log('webster_data', webster_data, yinjie, yinbiao)
                    return yinbiao || ''

                }
                return ''

            }

            color: current ? "orange":"white"
            font {
                pointSize: 14
            }

            anchors.top: yinjie.bottom
            anchors.horizontalCenter: yinjie.horizontalCenter
        }
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
//            if (x > parent.width) x -= 5
            if (x < 0){
                x += 4
            } else if (scene && x > scene.width -10){
                x -=4
            } else {
                x += (Math.random() * 100 - 50) / 100
            }


            if (scene && y > scene.height - 10){
                y -= Math.random()

            } else if (scene && y < 10){
                y += Math.random()

            } else {
                y += Math.random()

            }

//            if ( y > )
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
