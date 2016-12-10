import QtQuick 2.0

Rectangle {
    id: root
    width: a * 4
    height: a * 4
    readonly property real sqrt3: 1.7320508075688772

    property  real a: 100

    property real a2: a * 2
    property real a3: a * 3
    property real a4: a * 4
    property real asqrt3: a * sqrt3
    property real a2sqrt3: a2 * sqrt3
//    opacity: 1.0

    color: "transparent"
//    color: "red"

//    background: "transparent"
    Component.onCompleted: {
        animate_a.start()
    }
    onAChanged: {
//        console.log("onAChanged",a)
//        canvas.markDirty(Qt.rect(0, 0, canvas.width, canvas.height))
//        canvas.width = a
//        canvas.height = a
        if (a <= 4) {
            root.destroy()

        }

//        canvas
    }
    RotationAnimation {
        target: root
        to: 180
        duration: 400
        running: true
        loops: Animation.Infinite
    }

    NumberAnimation{
        id: animate_a
        target: root
        property: "a"
        from: 100
        to: 2
        duration: 400
        running: true
//        loops: Animation.Infinite
        loops: 1
        easing.type: Easing.Linear
        onDurationChanged: {
            console.log("onDurationChanged")
        }




    }
    Canvas {
        id:canvas
//        antialiasing: true
//        canvas.

//        canvas.antialiasing:
//        opacity: 1.0
//        property  real a: root.a

        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(Qt.rect(0, 0, canvas.width, canvas.height))

            ctx.lineWidth = 2
            ctx.strokeStyle = "yellow"
            ctx.fillStyle = "transparent"

            // 正6边形 begin
            ctx.beginPath()
            ctx.moveTo(a,0)
            ctx.lineTo(a3,0)
            ctx.lineTo(a4,asqrt3)
            ctx.lineTo(a3,a2sqrt3)
            ctx.lineTo(a,a2sqrt3)
            ctx.lineTo(0,asqrt3)
            ctx.closePath()
            ctx.fill()
            ctx.stroke()
            // 正6边形 end
        }
    }

}
