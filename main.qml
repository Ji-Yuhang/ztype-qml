import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: root

    property Component component: null
    property var words: []

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    function random_word() {
        var i = Math.floor(Math.random() * words.length - 1)
        var word = words[i]

        words[i] = words[0]
        words.shift()
        console.log(i,word,words.length)

        return word
    }

    Component.onCompleted: {
//        timer.start()
        var request = new XMLHttpRequest
            request.open("GET","qrc:/macmillan_all_words.txt")
            request.onreadystatechange = function() {
                    if (request.readyState == XMLHttpRequest.DONE) {
                        var doc = request.responseText;
                        words = doc.split("\n")
                        console.log("read: " + words.length)
    //                    var json = JSON.parse(doc);
    //                    callback.update(json);
                    }
                }
            request.send()
    //        console.log(request.responseText)

    }

    MouseArea {
        id:area
        anchors.fill: parent
        onClicked: {
            timer.start()
        }
        Keys.enabled: true
        Keys.onPressed: {
            var key = event.key
            console.log("key pressed",key)
        }
    }
//    focus: true
    Keys.forwardTo: [area]
    Keys.enabled: true
    Keys.onPressed: {
        var key = event.key
        console.log("key pressed",key)
    }
//    Text {
//        text: qsTr("Hello World")
//        anchors.centerIn: parent
//    }
    Timer {
        id: timer
        interval: 100
        onTriggered: {
            if (!component)
                component = Qt.createComponent("Tank.qml");
            if (component.status == Component.Ready) {
                var x = Math.random() * 100 * 6
                var y = 1
                var word = random_word()
                var tank = component.createObject(root,{"x":x, "y":y, word: word });
                tank.start()
                console.log(component, tank, x,y, word);

            } else {
                console.log(component, "errString",component.errorString());

            }

            console.log(component, "onTriggered",component.status);


        }
    }
//    focus: true

}
