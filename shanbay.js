
function func() {

}
function shanbay(word, callback){
    var request = new XMLHttpRequest
    request.open("GET","https://api.shanbay.com/bdc/search/?word=" + word)
    request.onreadystatechange = function() {
        if (request.readyState == XMLHttpRequest.DONE) {
            var doc = request.responseText;
            json = JSON.parse(doc)
            console.log("read: " + json)
            if(callback) callback(json)

        }
    }
    request.send()
//    player_helper.play("/home/jiyuhang/git/ztype-qml/ztype/endure.ogg")
}

