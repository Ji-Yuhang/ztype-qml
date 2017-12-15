var status = Qt.include("qrc:/lodash_js.js")
console.log('include status', status.status)


function func() {

}
function init_words(root){
    console.log('init_words',JSON.stringify(_.chunk(["a", "b", "c", "d"], 2)));
    var request = new XMLHttpRequest
//    request.open("GET","qrc:/collins_1_list_1.txt")
    request.open("GET","qrc:/colins_1_list_4.txt")
//    request.open("GET","qrc:/collins_1_list_2.txt")
//         request.open("GET","https://iamyuhang.com/api/v1/words/learnings/?token=")

    request.onreadystatechange = function() {
        if (request.readyState == XMLHttpRequest.DONE) {
            var doc = request.responseText;

//                var json = JSON.parse(doc)
//                words = json.data.learnings.map(function(learn){return learn.word})
            var words = doc.split("\n").map(function(w){return w.replace("\r\n",'').replace("\r",'');}).filter(function(w){return w != '' && w.length>0})
            words = _.compact(words)
//            words = words.sort(function(a,b){return a.length - b.length})

            console.log("read: " + words.length, words[0], words[words.length - 1])
//                score.text = destroy_words.length.toString() +' / '+ words.length.toString()
            root.words = words

        }
    }
    request.send()

//        console.log("seekable",bullet_audio.seekable)
//        console.log(mediaplayer, mediaplayer.availability, mediaplayer.status)
//        playSound.play()
//        player_helper.play("/home/jipai/git/ztype-qml/ztype/endure.ogg")

}
function init_webster(root){
    var request = new XMLHttpRequest
    request.open("GET","qrc:/webster_mini.json")

    request.onreadystatechange = function() {
        if (request.readyState == XMLHttpRequest.DONE) {
            var doc = request.responseText;
            var json = JSON.parse(doc)
//

            var size = _.size(json)
            console.log("read webster.json size: ", size)
            root.webster = json

        }
    }
    request.send()
}

function random_word(tanks,words) {
    var tanks_words_first_letters = null
    if (tanks.length != 0 ) tanks.map(function(t){return t.word[0];})
    else tanks_words_first_letters = []
    console.log("tanks_words_first_letters:", tanks_words_first_letters)

    var dead = true
    while (dead) {

        var i = 0 // Math.floor(Math.random() * words.length - 1)
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

function key_error(key, str) {
    console.log("key_error",key, str)
}
function get_tanks_words(tanks) {
    return tanks.map(function(t){return t.word;});
}
function get_tanks_words_first_letters(tanks) {
    var tanks_words_first_letters = null
    if (tanks.length != 0 ) tanks_words_first_letters = tanks.map(function(t){return t.word[0];})
    else tanks_words_first_letters = []
    return tanks_words_first_letters
}
function confuse_word(word, level){
    console.log('confuse_word',word,level)
    level = level || 0
    var temp_level = level

    var temp = ""
    for (var j = 0; j< word.length; j++) {
        if (j == 0) {
            temp += word[j]
        } else {
            if (temp_level > 0){
                temp += '*'
                temp_level -= 1

            } else {
                temp += word[j]
            }
        }
    }

    return temp
}

function create_n_tanks(parent_view, words, level) {
    if (!component) component = Qt.createComponent("Tank.qml");
    if (component.status == Component.Ready) {
        var new_tanks = _.map(words, function(word, i) {
            console.log('forEach:',word)
            var x = Math.random() * parent_view.width - 100
            if (x <= 0) x += Math.random()* 100
            var y = 20 * i


            // if (i == 1) word = "café"
            var webster_data  = root.bgl(word)
            var yinjie_yinbiao_text = _.get(webster_data, '3')
            var yinjie_yinbiao =  _.split(yinjie_yinbiao_text, '||')
            var yinjie = _.get(yinjie_yinbiao, '0')
            var yinbiao = _.get(yinjie_yinbiao, '1')
            if (yinbiao) {
                while(_.includes(yinbiao, 'charset')) {

                    yinbiao = yinbiao.replace('<charset c=T>','&#x')
                    yinbiao = yinbiao.replace('</charset>','')
                }
            }
            if (yinjie) {
                while(_.includes(yinjie, 'charset')) {
                    yinjie = yinjie.replace('<charset c=T>','&#x')
                    yinjie = yinjie.replace('</charset>','')
                }
            }
            if (!yinjie) yinjie = word
            if (yinjie && !yinbiao) yinjie = word

            var zh = _.get(webster_data, '2')

            var tank = component.createObject( parent_view, {
                                                  scene: parent_view,
                                                  "x": x,
                                                  "y": y,
                                                  word: word,
                                                  visible_word: confuse_word(yinjie || word, level),
                                                  webster_data: webster_data,
                                                  yinjie: yinjie,
                                                  yinbiao: yinbiao,
                                                  zh: zh
                                              });
            tank.word_destroy.connect(update_score)
//            tank.start()
            console.log(component, tank, x,y, word);
            return tank
        })

        parent_view.tanks = _.concat(parent_view.tanks, new_tanks)


    } else {
        console.error(component, "errString", component.errorString());
    }
}




//function create_tank(root,tanks,words, view,i) {
//    if (!component)
//        component = Qt.createComponent("Tank.qml");
//    if (component.status == Component.Ready) {
//        var x = Math.random() * root.width - 100
//        if (x <= 0) x += Math.random()* 100
////            width
//        var y = 20 * i
//        var word = ''
//        if (root.level >= 0) {
//             word = random_word(tanks,words)
//             root.level_words.push(word)
//        } else {
//            word = root.level_words.shift()
//        }

////            if (i == 1) word = "café"
//        var tank = component.createObject(view,{"x":x, "y":y, word: word, visible_word: confuse_word(word, root.level) });
////        tank.word_destroy.connect(update_score)

//        tanks.push(tank)
//        tank.start()
//        console.log(component, tank, x,y, word);

//    } else {
//        console.log(component, "errString",component.errorString());

//    }

////        console.log(component, "onTriggered",component.status);

//}

function create_bullet(parent_view, oppressor, target_stack,x,y){
    if (!bullet_component)
        bullet_component = Qt.createComponent("Bullet.qml");
    if (bullet_component.status == Component.Ready) {
//            var x = Math.random() * 100 * 6
//            var y = 10 * i
//            var word = Ztype.random_word(tanks,words)
        var bullet = bullet_component.createObject(parent_view,{"x":oppressor.x  - oppressor.width / 2, "y":oppressor.y - oppressor.height,"from_x":oppressor.x - oppressor.width / 2,"from_y":oppressor.y - oppressor.height,"to_x":x, "to_y":y, "target_stack": target_stack});
//            oppressor.x()
//            tanks.push(tank)
//            tank.start()
        console.log("create_bullet",bullet_component, bullet,oppressor,oppressor.x, oppressor.y,oppressor.Center,oppressor.horizontalCenter, x,y);
//        bullet.rotationChanged.connect(changed_rotation)

    } else {
        console.log(bullet_component, "errString",bullet_component.errorString());

    }

    console.log(bullet_component, "bullet onTriggered",bullet_component.status);

}
function changed_rotation(ro){
    oppressor.rotation = ro

}
function is_omit_letter(letter){
    if (letter == '·' || letter == "'"  || letter == "," )
        return true

    return false
}
