var status = Qt.include("qrc:/lodash_js.js")
console.log('include status', status.status)

function func() {

}
function init_words(root){
    console.log('init_words',JSON.stringify(_.chunk(["a", "b", "c", "d"], 2)));
    var request = new XMLHttpRequest
    request.open("GET","qrc:/collins_1_list_1.txt")
//         request.open("GET","https://iamyuhang.com/api/v1/words/learnings/?token=")

    request.onreadystatechange = function() {
        if (request.readyState == XMLHttpRequest.DONE) {
            var doc = request.responseText;

//                var json = JSON.parse(doc)
//                words = json.data.learnings.map(function(learn){return learn.word})
            words = doc.split("\n").map(function(w){return w.replace("\r\n",'').replace("\r",'');}).filter(function(w){return w != '' && w.length>0})
            words = _.compact(words)
            words = words.sort(function(a,b){return a.length - b.length})
//            Lodash.
            console.log("read: " + words.length, words[0], words[words.length - 1])
//                score.text = destroy_words.length.toString() +' / '+ words.length.toString()

        }
    }
    request.send()

//        console.log("seekable",bullet_audio.seekable)
//        console.log(mediaplayer, mediaplayer.availability, mediaplayer.status)
//        playSound.play()
//        player_helper.play("/home/jipai/git/ztype-qml/ztype/endure.ogg")

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
function create_tank(root,tanks,words, view,i) {
    if (!component)
        component = Qt.createComponent("Tank.qml");
    if (component.status == Component.Ready) {
        var x = Math.random() * root.width - 100
        if (x <= 0) x += Math.random()* 100
//            width
        var y = 20 * i
        var word = ''
        if (root.level >= 0) {
             word = random_word(tanks,words)
             root.level_words.push(word)
        } else {
            word = root.level_words.shift()
        }

//            if (i == 1) word = "café"
        var tank = component.createObject(view,{"x":x, "y":y, word: word, visible_word: confuse_word(word, root.level) });
//            tank. connect()
        tank.word_destroy.connect(update_score)

        tanks.push(tank)
        tank.start()
        console.log(component, tank, x,y, word);

    } else {
        console.log(component, "errString",component.errorString());

    }

//        console.log(component, "onTriggered",component.status);

}
