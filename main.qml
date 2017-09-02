import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.5
import an.qt.PlayerHelper 1.0
Window {
    id: root

    property Component component: null

    property Component lock_component: null
    property Component bullet_component: null

    property var words: []

    property var tanks: []
    property var stack: []
    property var target_stack: null
    property var last_buller_audio: null

    visible: true
    width: 460//640
    height: 720//480
    title: qsTr("Ztype-qml by Ji-Yuhang")
    function random_word() {
        var tanks_words_first_letters = null
        if (tanks.length != 0 ) tanks.map(function(t){return t.word[0];})
        else tanks_words_first_letters = []
        console.log("tanks_words_first_letters:", tanks_words_first_letters)

        var dead = true
        while (dead) {

            var i = Math.floor(Math.random() * words.length - 1)
            var word = words[i]

            var trues = tanks_words_first_letters && tanks_words_first_letters.length != 0 ? tanks_words_first_letters.map(function(letter){
                if (letter === word[0])
                    return false
                else
                    return true
            }) : []

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
        var request = new XMLHttpRequest
        request.open("GET","qrc:/collins_1_list_1.txt")
//         request.open("GET","https://iamyuhang.com/api/v1/words/learnings/?token=")

        request.onreadystatechange = function() {
            if (request.readyState == XMLHttpRequest.DONE) {
                var doc = request.responseText;

//                var json = JSON.parse(doc)
//                words = json.data.learnings.map(function(learn){return learn.word})
                words = doc.split("\n")
                console.log("read: " + words.length)

            }
        }
        request.send()

//        console.log("seekable",bullet_audio.seekable)
//        console.log(mediaplayer, mediaplayer.availability, mediaplayer.status)
//        playSound.play()
//        player_helper.play("/home/jipai/git/ztype-qml/ztype/endure.ogg")

    }
    PlayerHelper {
        id: player_helper
    }

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


    function key_error(key, str) {
        console.log("key_error",key, str)
    }
    function get_tanks_words() {
        return tanks.map(function(t){return t.word;});
    }
    function get_tanks_words_first_letters() {
        var tanks_words_first_letters = null
        if (tanks.length != 0 ) tanks_words_first_letters = tanks.map(function(t){return t.word[0];})
        else tanks_words_first_letters = []
        return tanks_words_first_letters
    }



    Rectangle {
        id: view
        color: "black"
        anchors.fill: parent
        focus: true
        Image {
            anchors.fill: parent
            id: back
            z: 0
            source: "file:///home/jipai/git/ztype-qml/ztype/gradient.png"
//            source: "qrc:/ztype/gradient.png"
//            fillMode: Image.Tile
        }
        Image {
//            anchors.fill: parent
            id: grid
            width: parent.width * 2 + 100
            height: parent.height * 2 + 100
            opacity: 0.3
            z: 1
            source: "file:///home/jipai/git/ztype-qml/ztype/grid.png"

//            source: "qrc:/ztype/grid.png"
            fillMode: Image.Tile
        }

        Timer {
            id: grid_timer
            property int count: 0
            interval: 100
            running: true;
            repeat: true

            onTriggered: {
//              grid.x = grid.x - 1
              grid.y = grid.y + 1
              count += 1
                if (count >= 100){
                    count = 0
//                    grid.x = 0
                    grid.y = -height
                }
            }
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
                create_tank(0)
                create_tank(1)
                create_tank(2)
                create_tank(3)
                return
            }

            var tanks_words = get_tanks_words()
            var tanks_words_first_letters = get_tanks_words_first_letters()
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
                    key_error(lower_case_letter, "按键出错")
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
                                lock_animation(x,y)
                            }
                            lock_tank(target_stack)

                            var temp = ""
                            for (var i = 1; i < target_stack.visible_word.length; i++) {
                                temp += target_stack.visible_word[i]
                            }

                            target_stack.visible_word = temp
                            // 播放子弹声音
//                            bullet_audio.stop()
//                            bullet_audio.seek(0.3)
//                            bullet_audio.play()
//                            component
                            play_bullet_audio()
                            player_helper.play("http://media.shanbay.com/audio/uk/"+target_stack.word+".mp3");

                            create_bullet(target_stack, target_stack?target_stack.x :50 ,target_stack?target_stack.y:50)


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
                        player_helper.play("http://media.shanbay.com/audio/uk/"+target_stack.word+".mp3");


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

                        target_stack.visible_word = temp
                    }
                    // 播放子弹声音

//                    bullet_audio.stop()
//                    bullet_audio.seek(0.3)
//                    bullet_audio.play()
                    create_bullet(target_stack, target_stack?target_stack.x :50 ,target_stack?target_stack.y:50)
                    play_bullet_audio()

                } else {
                    key_error(lower_case_letter, "按键出错")
                }

            }
            console.log("stack",stack)
        }
    }
    function changed_rotation(ro){
        oppressor.rotation = ro

    }

    function create_bullet(target_stack,x,y){
        if (!bullet_component)
            bullet_component = Qt.createComponent("Bullet.qml");
        if (bullet_component.status == Component.Ready) {
//            var x = Math.random() * 100 * 6
//            var y = 10 * i
//            var word = random_word()
            var bullet = bullet_component.createObject(view,{"x":oppressor.x  - oppressor.width / 2, "y":oppressor.y - oppressor.height,"from_x":oppressor.x - oppressor.width / 2,"from_y":oppressor.y - oppressor.height,"to_x":x, "to_y":y, "target_stack": target_stack});
//            oppressor.x()
//            tanks.push(tank)
//            tank.start()
            console.log("create_bullet",bullet_component, bullet,oppressor,oppressor.x, oppressor.y,oppressor.Center,oppressor.horizontalCenter, x,y);
            bullet.rotationChanged.connect(changed_rotation)

        } else {
            console.log(bullet_component, "errString",bullet_component.errorString());

        }

        console.log(bullet_component, "bullet onTriggered",bullet_component.status);

    }

    function create_tank(i) {
        if (!component)
            component = Qt.createComponent("Tank.qml");
        if (component.status == Component.Ready) {
            var x = Math.random() * root.width - 100
            if (x <= 0) x += Math.random()* 100
//            width
            var y = 10 * i
            var word = random_word()
//            if (i == 1) word = "café"
            var tank = component.createObject(view,{"x":x, "y":y, word: word, visible_word: word });
            tanks.push(tank)
            tank.start()
            console.log(component, tank, x,y, word);

        } else {
            console.log(component, "errString",component.errorString());

        }

//        console.log(component, "onTriggered",component.status);

    }
    function lock_animation(x,y) {

        if (!lock_component)
            lock_component = Qt.createComponent("Lock.qml");
        if (lock_component.status == Component.Ready) {
//            var x = Math.random() * 100 * 6
//            var y = 10 * i
//            var word = random_word()
            var lock = lock_component.createObject(view,{"x":x, "y":y });
//            tanks.push(tank)
//            tank.start()
            console.log(lock_component, lock, x,y);

        } else {
            console.log(lock_component, "errString",component.errorString());

        }

        console.log(lock_component, "onTriggered",component.status);

    }
    function play_bullet_audio(){
        console.log("play_bullet_audio");
        player_helper.play("/home/jipai/git/ztype-qml/ztype/plasma.mp3");
        console.log("player_helper");

//        last_buller_audio
//        var temp = last_buller_audio;
//        if (last_buller_audio) {last_buller_audio.stop();last_buller_audio.seek(0)}
//        if (bullet_audio.playbackState !=
//                Audio.PlayingState) {bullet_audio.seek(0); bullet_audio.stop();bullet_audio.play(); last_buller_audio = bullet_audio ;return}
//        if (bullet_audio1.playbackState !=
//                Audio.PlayingState) {bullet_audio1.seek(0); bullet_audio1.stop(); bullet_audio1.play(); last_buller_audio = bullet_audio1 ; return}
//        if (bullet_audio2.playbackState !=
//                Audio.PlayingState) {bullet_audio2.seek(0); bullet_audio2.stop(); bullet_audio2.play();  last_buller_audio = bullet_audio2 ;return}
//        if (bullet_audio3.playbackState !=
//                Audio.PlayingState) {bullet_audio3.seek(0); bullet_audio3.stop(); bullet_audio3.play();  last_buller_audio = bullet_audio3 ;return}
//        if (bullet_audio4.playbackState !=
//                Audio.PlayingState) {bullet_audio4.seek(0); bullet_audio4.stop(); bullet_audio4.play();  last_buller_audio = bullet_audio4 ;return}
//        if (bullet_audio5.playbackState !=
//                Audio.PlayingState) {bullet_audio5.seek(0); bullet_audio5.stop(); bullet_audio5.play(); last_buller_audio = bullet_audio5 ; return}
//        if (temp) temp.stop()
//        if (temp) {temp.stop();temp.seek(0);}
//        console.log("play_bullet_audio: [0...5]",bullet_audio.position, bullet_audio1.position,bullet_audio2.position,bullet_audio3.position,bullet_audio4.position,bullet_audio5.position)
//        bullet_audio.play()
//        system




    }


    Timer {
        id: timer
        interval: 100
        onTriggered: {
            create_tank(0)
            create_tank(1)
            create_tank(2)
            create_tank(3)
//            create_tank()
//            create_tank()
//            create_tank()

        }
    }
    Audio {
        id: mediaplayer
        autoLoad: true
        autoPlay: true
        loops: Audio.Infinite
        volume: 1
//        source: "file:///home/jipai/Music/网易云音乐/魏小涵 - 飞雪玉花.mp3"
//        source: "./ztype/endure.ogg"
        source: "file:///home/jipai/git/ztype-qml/ztype/endure.ogg"
//        source: "file:///home/jipai/Desktop/endure.mp3"


    }
    SoundEffect {
        id: playSound
//        autoLoad: true
//        autoPlay: true
        loops: SoundEffect.Infinite
//        source: "./ztype/endure.ogg"
        source: "file:///home/jipai/git/ztype-qml/ztype/endure.ogg"
    }
    Audio {
        id:redalert_audio
        autoLoad: true
        loops: Audio.Infinite
        source: "file:///home/jipai/git/ztype-qml/wav/红警原子弹声音.wav"
    }
    Audio {
        id:bullet_audio
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"
    }
    Audio {
        id:bullet_audio1
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"

    }
    Audio {
        id:bullet_audio2
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"

    }
    Audio {
        id:bullet_audio3
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"

    }
    Audio {
        id:bullet_audio4
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"

    }
    Audio {
        id:bullet_audio5
        autoLoad: true
//        source: "file:///home/jipai/git/ztype-qml/wav/子弹.mp3"
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.mp3"

    }

//   /home/jipai/Music/网易云音乐

    //    focus: true

}
