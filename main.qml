import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.5
import an.qt.PlayerHelper 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import "qrc:/ztype.js" as Ztype
import "qrc:/lodash_qml.js" as Lodash

Window {
    id: root

//    property alias shout_scene_root: shout_scene.root
//    property alias listen_scene_root: listen_scene.root


    property Component component: null

    property Component lock_component: null
    property Component bullet_component: null

    property var current_scene: null


    property var words: []
    property var destroy_words: []
    property var level_words: []

    property var start_time: null

    property var tanks: []
    property var stack: []
    property var target_stack: null
    property var last_buller_audio: null
    property var level: 0

    modality: Qt.WindowModal

    visible: true
    width: 460//640
    height: 720//480
    title: qsTr("Ztype-qml by Ji-Yuhang")

    Component.onCompleted: {
        console.log(JSON.stringify(Lodash._.chunk(["a", "b", "c", "d"], 2)));
        Ztype.init_words(root)
//        shout_scene_root = root
//        listen_scene_root = root
    }
    PlayerHelper {
        id: player_helper
    }


    ShoutScene {
        id: shout_scene
        z: 5
        color: 'transparent' //transparent
        root: root
        visible: false
        anchors.fill: parent
        focus: false
        Component.onCompleted: {
//            shout_scene_root = root
        }
    }
    ListenScene {
        z: 5
        id: listen_scene
//        root: root

        visible: false
        focus: false

        anchors.fill: parent
        Component.onCompleted: {
//            listen_scene_root = root
        }
    }

    Column {
        id: column_buttons
        z: 4
        anchors.centerIn: parent
        spacing: 2

        Button {
            id: shout_button
            text: "射击模式"
            background: Rectangle {
                      implicitWidth: 100
                      implicitHeight: 40
                      opacity: enabled ? 1 : 0.3
                      border.color: shout_button.down ? "#17a81a" : "#21be2b"
                      border.width: 1
                      radius: 2
                      color: '#132B2B'

                  }
            contentItem: Text {
                      text: shout_button.text
                      font: shout_button.font
                      opacity: enabled ? 1.0 : 0.3
                      color: shout_button.down ? "#132B2B" : "#21be2b"
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                  }
                onClicked: {
                    column_buttons.visible = false
                    shout_scene.visible = true
                    shout_scene.focus = true

                    listen_scene.visible = false
                    current_scene = shout_scene
                }
        }
        Button {
            id: listen_button

            text: "听力模式"
            background: Rectangle {
                      implicitWidth: 100
                      implicitHeight: 40
                      opacity: enabled ? 1 : 0.3
                      border.color: listen_button.down ? "#17a81a" : "#21be2b"
                      border.width: 1
                      radius: 2
                      color: '#132B2B'

                  }
            contentItem: Text {
                      text: listen_button.text
                      font: listen_button.font
                      opacity: enabled ? 1.0 : 0.3
                      color: listen_button.down ? "#132B2B" : "#21be2b"
                      horizontalAlignment: Text.AlignHCenter
                      verticalAlignment: Text.AlignVCenter
                      elide: Text.ElideRight
                  }
            onClicked: {
                column_buttons.visible = false
                shout_scene.visible = false
                listen_scene.visible = true
                listen_scene.focus = true

                current_scene = listen_scene

            }
        }
    }

    Image {
        anchors.fill: parent
        id: back
        z: 0
//            source: "file:///home/jipai/git/ztype-qml/ztype/gradient.png"
        source: "qrc:/ztype/gradient.png"
//            fillMode: Image.Tile
    }
    Image {
//            anchors.fill: parent
        id: grid
        width: parent.width * 3 + 100
        height: parent.height * 3 + 100
        opacity: 0.3
        z: 1
//            source: "file:///home/jipai/git/ztype-qml/ztype/grid.png"
        source: "qrc:/ztype/grid.png"
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
            grid.opacity -= 0.002
            count += 1
            if (count >= 100){
                count = 0
                //                    grid.x = 0
//                var diff_y =
                grid.y = current_scene ? -current_scene.height: root.height
                grid.opacity = 0.3
            }
            if (root.start_time){
                var current = Date.now()
                var diff = current - root.start_time
                var sec = parseInt(diff / 1000)
                var min = parseInt(sec / 60)
                sec = parseInt(sec % 60)

                start_time_text.text = min.toString() + '\''+ sec.toString() + '\'\''
            }



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
//            var word = Ztype.random_word(tanks,words)
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

    function update_score(word){
        if (destroy_words.indexOf(word) == -1 ) destroy_words.push(word)
        score.text = destroy_words.length.toString() +' / '+ words.length.toString()
        score.update()
        console.log('update_score',word,score.text)
    }

    function lock_animation(x,y) {

        if (!lock_component)
            lock_component = Qt.createComponent("Lock.qml");
        if (lock_component.status == Component.Ready) {
//            var x = Math.random() * 100 * 6
//            var y = 10 * i
//            var word = Ztype.random_word(tanks,words)
            var lock = lock_component.createObject(view,{"x":x, "y":y });
//            tanks.push(tank)
//            tank.start()
            console.log(lock_component, lock, x,y);
            if (!root.start_time) root.start_time = Date.now()

        } else {
            console.log(lock_component, "errString",component.errorString());

        }

        console.log(lock_component, "onTriggered",component.status);

    }
    function play_bullet_audio(){
        console.log("play_bullet_audio");
        player_helper.play("/home/jipai/git/ztype-qml/ztype/plasma.mp3");
//        player_helper.play("ztype/plasma.mp3");

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
