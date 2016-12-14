import QtQuick 2.0

Item {
    id:root
    z:3
    width: 100
    height: 100
    property var to_x: null
    property var to_y: null
//    rotation:
//    onXChanged: {
//        console.log("onXChanged",x,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
//        if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
//        console.log("onStopped")
//        root.destroy()
//        }
//    }
//    onYChanged: {
//        console.log("onYChanged",x,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
//        if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
//        console.log("onStopped")
//        root.destroy()
//        }
//    }

    Image {
        id: image
        z:4
        anchors.fill: parent
//        source: "qrc:/ztype/plasma.png"
        source: "file:///Users/jiyuhang/git/ztype-qml/ztype/plasma.png"

//        qrc:/ztype/plasma.png
    }
//    property point from_point: null
//    property point to_point: null
    Component.onCompleted: {
        n_x.start()
        n_y.start()

    }
    NumberAnimation{
        id: n_x
//        from: x
        target: root
        property: "x"
        from: 500
        to: to_x
//        property: 'pos'
        duration: 500
        running: true
//        loops: Animation.Infinite
        loops: 1
//        onDurationChanged: {
//            console.log("onDurationChanged")
//            console.log("onYChanged",x,t,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
//            if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
//            console.log("onStopped")
//            root.destroy()
//            }
//        }
        onStopped: {
            console.log("onStopped")
            root.destroy()

        }
    }
    NumberAnimation on y{
        id: n_y
//        from: x
        target: root
        property: "y"
        from: 600
        to: to_y
        running: true
//        loops: Animation.Infinite
        loops: 1
//        property: 'pos'
        duration: 500
        onDurationChanged: {
            console.log("onDurationChanged")
            console.log("onYChanged",x,t,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
            if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
            console.log("onStopped")
            root.destroy()
            }
        }
        onStopped: {
            console.log("onStopped")

            root.destroy()

        }

    }

}
