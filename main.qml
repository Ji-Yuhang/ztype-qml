import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: root

    property Component component: null
    property var words: []

    property var tanks: []
    property var stack: []
    property var target_stack: null

    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    function random_word() {
        var tanks_words_first_letters = tanks.map(function(t){return t.word[0];})
        console.log("tanks_words_first_letters:", tanks_words_first_letters)

        var dead = true
        while (dead) {

            var i = Math.floor(Math.random() * words.length - 1)
            var word = words[i]

            var trues = tanks_words_first_letters.map(function(letter){
                if (letter === word[0])
                    return false
                else
                    return true
            })

            var can = true
            for (var j = 0; j< trues.length; j++) {
                if(trues[j] == true) {
                    can = true


                } else {
                    can = false
                    break
                }
            }
            if (can) {
                dead = false
            }
        }



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

    }

    //    Text {
    //        text: qsTr("Hello World")
    //        anchors.centerIn: parent
    //    }
    function key_error(key, str) {
        console.log("key_error",key, str)
    }

    Rectangle {
        id: view
        anchors.fill: parent
        focus: true
        Keys.enabled: true
        Keys.onPressed: {
            var key = event.key
            console.log("key pressed",key)
            event.accepted = true;

            var tanks_words = tanks.map(function(t){return t.word;})
            console.log(tanks_words)
            var tanks_words_first_letters = tanks.map(function(t){return t.word[0];})
            var lower_case_letter = String.fromCharCode(key).toLowerCase()
            if(stack.length == 0) {
                for (var i = 0; i < tanks_words_first_letters.length; i++) {
                    //                String.fromCharCode(65).toLowerCase()
                    var letter = null
                    if (stack.length == 0) {
                        letter = tanks_words_first_letters[i]
                        if (letter === lower_case_letter) {
                            for (var j = 1; j < tanks_words[i].length; j++) {
                                stack.push(tanks_words[i][j])
                            }
                            target_stack = tanks[i]
                        } else {
                            //                        key_error(lower_case_letter, "按键出错")
                        }
                    }
                    //                key_error(lower_case_letter, "按键出错")

                    //                if (letter === lower_case_letter) {
                    //                    stack.push(key)
                    //                    console.log("Good, You catch it:", key, letter,stack)

                    //                } else {
                    //                    console.log("Error, You lose it:", key, letter)

                    //                }
                }
            }
            else if(stack.length != 0) {
                letter = stack[0]
                if (letter === lower_case_letter) {
                    stack.shift()
                    if (stack.length == 0) {


                        var index = null
                        for (var i = 0; i < tanks.length; i++) {
                            if(tanks[i] == target_stack) {
                                index = i
                            }
                        }
                        if (index ){

                            target_stack.custom_destroy()
                            target_stack = null

                            tanks[index] = tanks[0]
                            tanks.shift()
                        }


//                        target_stack = null
//                        target_stack
                    } else {
                        var temp = ""
                        for (var i = 1; i < target_stack.visible_word.length; i++) {
                            temp += target_stack.visible_word[i]
                        }

                        target_stack.visible_word = temp
                    }

                } else {
                    key_error(lower_case_letter, "按键出错")
                }

            }
            console.log("stack",stack)
        }
    }

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
                var tank = component.createObject(view,{"x":x, "y":y, word: word, visible_word: word });
                tanks.push(tank)
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
