function func() {

}
function random_word(tanks,words) {
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
