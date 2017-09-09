import QtQuick 2.0
import "qrc:/ztype.js" as Ztype
import "qrc:/lodash_qml.js" as Lodash

Rectangle {
//    Rectangle {
        id: view

        property var root: null
        property var words: []
        property var destroy_words: []
        property var level_words: []

        property var start_time: null

        property var tanks: []
        property var stack: []
        property var target_stack: null
        property var last_buller_audio: null
        property int level: 0

        Component.onCompleted: {
            console.log('ShoutScene.onCompleted',root)
        }

        color: "black"
        anchors.fill: parent
        focus: true

        MouseArea {
            id:area
            anchors.fill: parent
            onClicked: {
    //            mediaplayer.play()

                timer.start()


    //            console.log("mediaplaye error:",mediaplayer.errorString)
    //            redalert_audio.play()
    //            playSound.play()
            }

        }
        Timer {
            id: timer
            interval: 100
            onTriggered: {
//                (root,tanks,words, view, i)
                var level = 0
                var words = root.words.slice(0,4)
                Ztype.create_n_tanks(view, words, level)
//                Ztype.create_tank(root,root.tanks, root.words, view, 0)
//                Ztype.create_tank(root,root.tanks, root.words, view, 1)
//                Ztype.create_tank(root,root.tanks, root.words, view, 2)
//                Ztype.create_tank(root,root.tanks, root.words, view, 3)
//                if (root.level > 4) {
//                    root.level = 1
//                    root.level_words = []
//                } else {
//                    root.level = root.level + 1

//                }

            }
        }
        Timer {
            id: scene_timer
            property int count: 0
            interval: 500
            running: true;
            repeat: true

            onTriggered: {
                if (view.start_time){
                    var current = Date.now()
                    var diff = current - view.start_time
                    var sec = parseInt(diff / 1000)
                    var min = parseInt(sec / 60)
                    sec = parseInt(sec % 60)

                    start_time_text.text = min.toString() + '\''+ sec.toString() + '\'\''
                }
            }
        }

        Text {
            id: score
            z: 6
            visible: true
            color: "white"
            font {
                pointSize: 20
            }
            text: destroy_words.length.toString() +' / '+ words.length.toString()
            anchors.centerIn: parent
        }
        Text {
            id: start_time_text
            z: 7
            visible: true
            color: "white"
            font {
                pointSize: 14
            }
            text: ''
            anchors.top: score.bottom
            anchors.verticalCenter: score.verticalCenter
            anchors.horizontalCenter: score.horizontalCenter
        }


        Oppressor {
            id: oppressor
            width: 50
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

        }

//        Canvas {
//            anchors.fill: parent
//            onPaint: {
//                var ctx = getContext("2d")

//            }
//        }

        Keys.enabled: true
        Keys.onPressed: {
            var key = event.key
            console.log("key pressed",key)
            event.accepted = true;

            if (key == Qt.Key_Enter || key == Qt.Key_Return){
                console.log('KeyEnter')

                if (target_stack && target_stack.word){
                    var local_mp3_path = "/home/jipai/vimrc/shanbaymp3/"+target_stack.word+".mp3"
                    if (player_helper.exists(local_mp3_path)){
                        player_helper.play(local_mp3_path)
                    } else {
                        player_helper.play("http://media.shanbay.com/audio/uk/"+target_stack.word+".mp3");

                    }
                }


//                create_tank(0)
//                create_tank(1)
//                create_tank(2)
//                create_tank(3)

                return
            }

            var tanks_words = Ztype.get_tanks_words(tanks)
            var tanks_words_first_letters = Ztype.get_tanks_words_first_letters(tanks)
            var lower_case_letter = String.fromCharCode(key).toLowerCase()
//            console.log("[tanks_words,tanks_words_first_letters,lower_case_letter]",tanks_words,tanks_words_first_letters,lower_case_letter)

            if (stack.length ==0) {
                function one_word_finish_callback() {

                }
                // 栈中的单词已经全部输入正确，销毁之
                one_word_finish_callback()

                function push_other_word() {

                }
                // 继续入栈其他的单词
                push_other_word()
            } else {
                // 当前栈中已经有单词

            }
            function match_stack(lower_case_letter) {
                var stack_rear = stack[0]
                if (lower_case_letter == stack_rear) {
                    // 匹配成功
                    function one_letter_of_word_callback() {

                    }
                    one_letter_of_word_callback()
                } else {
                    // 匹配失败
                    Ztype.key_error(lower_case_letter, "按键出错")
                }

            }
            match_stack(lower_case_letter)

            if(stack.length == 0) {
                for (var i = 0; i < tanks_words_first_letters.length; i++) {
                    //                String.fromCharCode(65).toLowerCase()
                    var letter = null
                    if (stack.length == 0 && tanks_words_first_letters[i]) {
                        letter = tanks_words_first_letters[i].toLowerCase()
                        if (letter === lower_case_letter) {
                            for (var j = 1; j < tanks_words[i].length; j++) {
                                stack.push(tanks_words[i][j])
                            }
                            target_stack = tanks[i]
                            target_stack.current = true



                            function lock_tank(target_stack) {
                                var x = target_stack.x
                                var y =target_stack.y
//                                var point = target_stack.mapToItem(root,0,0)
//                                console.log("lock_tank_ mapToItem: ",x,y,point,point.x,point.y)

//                                lock_animation(point.x,point.y)
                                lock_animation(x + target_stack.width,y)
                            }
                            lock_tank(target_stack)

                            var temp = ""
                            for (var i = 1; i < target_stack.visible_word.length; i++) {
                                temp += target_stack.visible_word[i]
                            }

                            var temp_right = target_stack.width
                            target_stack.visible_word = temp
                            target_stack.x += temp_right -target_stack.width
                            // 播放子弹声音
//                            bullet_audio.stop()
//                            bullet_audio.seek(0.3)
//                            bullet_audio.play()
//                            component
                            play_bullet_audio()
//                            exists
                            var local_mp3_path = "/home/jipai/vimrc/shanbaymp3/"+target_stack.word+".mp3"
                            if (player_helper.exists(local_mp3_path)){
                                player_helper.play(local_mp3_path)
                            } else {
                                player_helper.play("http://media.shanbay.com/audio/uk/"+target_stack.word+".mp3");

                            }


                            Ztype.create_bullet(view, oppressor, target_stack, target_stack?target_stack.x :50 ,target_stack?target_stack.y:50)


                        } else {
                            //                        Ztype.key_error(lower_case_letter, "按键出错")
                        }
                    }
                    //                Ztype.key_error(lower_case_letter, "按键出错")

                    //                if (letter === lower_case_letter) {
                    //                    stack.push(key)
                    //                    console.log("Good, You catch it:", key, letter,stack)

                    //                } else {
                    //                    console.log("Error, You lose it:", key, letter)

                    //                }
                }
            }
            else if(stack.length != 0) {
                letter = stack[0].toLowerCase()
                if(letter == 'é') letter = 'e'
                if (letter == lower_case_letter) {
                    stack.shift()
                    if (stack.length == 0) {


                        var index = null
                        for (var i = 0; i < tanks.length; i++) {
                            if(tanks[i] == target_stack) {
                                index = i
                            }
                        }
//                        console.log("stack empty!!!", index)


                            target_stack.visible_word = ""
                            target_stack.custom_destroy()
                        var local_mp3_path = "/home/jipai/vimrc/shanbaymp3/"+target_stack.word+".mp3"
                        if (player_helper.exists(local_mp3_path)){
                            player_helper.play(local_mp3_path)
                        } else {
//                            player_helper.play("http://media.shanbay.com/audio/uk/"+target_stack.word+".mp3");

                        }


                            target_stack = null
                        if (index != null){
//                            console.log("will shift tanks ",index,tanks, tanks.length)
                            tanks[index] = tanks[0]
                            tanks.shift()
//                            console.log("did shift tanks ",index,tanks, tanks.length)
                        }


//                        target_stack = null
//                        target_stack
                    } else {
                        var temp = ""
                        for (var i = 1; i < target_stack.visible_word.length; i++) {
                            temp += target_stack.visible_word[i]
                        }

                        var temp_right = target_stack.width
                        target_stack.visible_word = temp
                        target_stack.x += temp_right -target_stack.width
                        console.log('temp_right', temp_right, target_stack.x, target_stack.width)
                    }
                    // 播放子弹声音

//                    bullet_audio.stop()
//                    bullet_audio.seek(0.3)
//                    bullet_audio.play()
                    Ztype.create_bullet(view, oppressor,target_stack, target_stack?target_stack.x :50 ,target_stack?target_stack.y:50)
                    play_bullet_audio()

                } else {
                    Ztype.key_error(lower_case_letter, "按键出错")
                }

            }
            console.log("stack",stack)
        }
//    }
}
