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
    property double speed: 80.0 //40.0
    property double last_rotation: 0
    property double last_distance: 0
    signal rotationChanged(double rotation)

//    signal (double rotation)

//    rotation: {
//        if (target_stack) {
//            var a_x = root.x
//            var a_y = root.y
//            var b_x = target_stack.x
//            var b_y = target_stack.y

//            var distance_x = Math.abs(a_x - b_x)
//            var distance_y = Math.abs(a_y - b_y)
//            var distance = Math.sqrt(Math.pow(distance_x,2) + Math.pow(distance_y,2))
//            var ro = 360 - Math.atan(distance_x / distance_y) *180 / Math.PI
//            last_rotation = ro
//            return ro


//        } else {

//            return last_rotation ? last_rotation : 0
//        }
//    }

//    rotation: {
//        if(last_rotation && !target_stack) return last_rotation
////        if(!target_stack) return last_rotation
//        if (last_rotation) return last_rotation

//        var temp_y = y
//        if (temp_y <= to_y){
//            temp_y = to_y
//        }
//        var temp_to_y = target_stack.y
//        if(temp_to_y <= (temp_y - 3)) return last_rotation

//        var ro = 360 - Math.atan(1.0 * (to_x - x) / (temp_to_y - temp_y)) *180 / Math.PI
//        console.log("bullet, rotation: ",JSON.stringify({to_x: to_x, x: x, temp_to_y: temp_to_y, y: temp_y}), ro)
//        last_rotation = ro
//        return ro
//    }
    
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
        source: "qrc:/ztype/plasma.png"
//        source: "file:///home/jipai/git/ztype-qml/ztype/plasma.png"

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
           interval: 60;
           running: true;
           repeat: true
           onTriggered: {
               if (target_stack) {
                   var a_x = root.x
                   var a_y = root.y
                   var b_x = target_stack.image_x + target_stack.x - 32
                   var b_y = target_stack.y
//                   console.log('target tank', target_stack.x, target_stack.y, target_stack.image_x, target_stack.image_y)

                   var distance_x = Math.abs(a_x - b_x)
                   var distance_y = Math.abs(a_y - b_y)
                   var distance = Math.sqrt(Math.pow(distance_x,2) + Math.pow(distance_y,2))

                   var diff_x = speed * distance_x * 1.0 / distance
                   var diff_y = speed * distance_y * 1.0 / distance



                   var xx = a_x
                   var yy = a_y
                   if (b_x >= a_x)
                       xx = a_x + diff_x
                   else
                       xx = a_x - diff_x

                   if (b_y >= a_y)
                       yy = a_y + diff_y
                   else
                       yy = a_y - diff_y


                   var ro = 360 - Math.atan((b_x - a_x) / (b_y - a_y)) *180 / Math.PI
//                   console.log('onTriggered ', distance_x, distance_y, distance, diff_x, diff_y,a_x,a_y, xx, yy, ro )

                   if (distance <= speed/2.0 ){
                       timer.stop()
                       root.destroy()
                       root.rotationChanged(0)


                   } else {
                       if ( last_distance > 0 && last_distance <= distance){
                           timer.stop()
                           root.destroy()
                           root.rotationChanged(0)

                       }

                       root.x = xx
                       root.y = yy
                       root.rotation = ro
                       last_rotation = ro
                       root.rotationChanged(ro)

                       last_distance = distance

//                       console.log('onTriggered ', distance_x, distance_y, distance, diff_x, diff_y,a_x,a_y, xx, yy )
                   }
               } else {
                   timer.stop()
                   root.destroy()
                   root.rotationChanged(0)

               }


           }

       }
//    NumberAnimation{
//        id: n_x
////        from: x
//        target: root
//        property: "x"
//        from: from_x
//        to: target_stack? (target_stack.x - target_stack.width / 2): to_x
////        property: 'pos'
//        duration: 500
//        running: true
////        loops: Animation.Infinite
//        loops: 1
////        onDurationChanged: {
////            console.log("onDurationChanged")
////            console.log("onYChanged",x,t,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
////            if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
////            console.log("onStopped")
////            root.destroy()
////            }
////        }
//        onStopped: {
//            console.log("onStopped")
//            root.destroy()

//        }
//    }
//    NumberAnimation on y{
//        id: n_y
////        from: x
//        target: root
//        property: "y"
//        from: from_y
//        to:  target_stack? (target_stack.y - target_stack.height / 2) : to_y
//        running: true
////        loops: Animation.Infinite
//        loops: 1
////        property: 'pos'
//        duration: 500
//        onDurationChanged: {
//            console.log("onDurationChanged")
//            console.log("onYChanged",x,t,to_x,to_y,Math.abs(x - to_x),Math.abs(y - to_y))
//            if (Math.abs(x - to_x) <= 2 && Math.abs(y - to_y) <= 2) {
//            console.log("onStopped")
//            root.destroy()
//            }
//        }
//        onStopped: {
//            console.log("onStopped")

//            root.destroy()

//        }

//    }

}
