import QtQuick 2.0

Item {
    id:root
    z:3
    width: 100
    height: 100
    property var from_x: null
    property var from_y: null

    property var to_x: null
    property var to_y: null
    property var target_stack: null
    property double speed: 1.0
    property var last_rotation: null
    rotation: {
        if(last_rotation && !target_stack) return last_rotation
//        if(!target_stack) return last_rotation
        if (last_rotation) return last_rotation

        var temp_y = y
        if (temp_y <= to_y){
            temp_y = to_y
        }
        var temp_to_y = target_stack.y
        if(temp_to_y <= (temp_y - 3)) return last_rotation

        var ro = 360 - Math.atan(1.0 * (to_x - x) / (temp_to_y - temp_y)) *180 / Math.PI
        console.log("bullet, rotation: ",JSON.stringify({to_x: to_x, x: x, temp_to_y: temp_to_y, y: temp_y}), ro)
        last_rotation = ro
        return ro
    }
    
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
        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.png"

//        qrc:/ztype/plasma.png
    }
//    property point from_point: null
//    property point to_point: null
    Component.onCompleted: {
//        n_x.start()
//        n_y.start()

    }
    Timer {
        id: timer
           interval: 1;
           running: false;
           repeat: true
           onTriggered: {
               var last_x = root.x
               var last_y = root.y
               var temp_to_x = target_stack.x
               var temp_to_y = target_stack.y

               var xx = last_x + speed
               var yy = last_y + speed

               if (yy <= temp_to_y){
                   timer.stop()
                   root.destroy()

               } else {
                   root.x = xx
                   root.y = yy
               }
           }

       }
    NumberAnimation{
        id: n_x
//        from: x
        target: root
        property: "x"
        from: from_x
        to: target_stack? (target_stack.x - target_stack.width / 2): to_x
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
        from: from_y
        to:  target_stack? (target_stack.y - target_stack.height / 2) : to_y
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
