import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

Rectangle {
    id: page_root

    anchors.fill: parent
    color: "white"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("####")
            bars.model = page_root.screenBars(page_root.height, page_root.width, bars.barwidth)
        }
    }

    Repeater {
        id: bars
        property double barwidth: 10

        model: page_root.screenBars(page_root.height, page_root.width, barwidth)

        Item {
            id: candle

            property double high: 0
            property double low: 0
            property double open: 0
            property double close: 0
            property bool upBar: close < open

            Rectangle {
                id: body

                height: candle.upBar ? candle.open - candle.close : candle.close - candle.open
                color: upBar ? "green" : "red"

                x: index * width
                y: candle.upBar ? candle.close : candle.open

                width: bars.barwidth
            }

            Rectangle {
                id: wick

                anchors.horizontalCenter: body.horizontalCenter
                width: bars.barwidth/3
                height: candle.low - candle.high
                y: candle.high + candle.height
                color: body.color
            }

            Component.onCompleted: {
                open = bars.model[index][0]
                close = bars.model[index][1]
                high = bars.model[index][2]
                low = bars.model[index][3]
            }
        }
    }

//    Repeater {
//        id: scaleV
//        property int number: 10
//        model: number
//        z: 10

//        Rectangle {
//            id: mark

//            anchors.left: page_root.left
//            width: 20
//            height: 2
//            y: index * page_root.height/scaleV.number - height/2
//            color: "black"
//        }
//    }

    GraphScale {
    }

    function screenBars(height, width, barwidth) {
        var n = parseInt(width/barwidth) +1

        var open
        var close
        var high
        var low
        var upBar


        var model = [[700,610,600,730]]
        var max = model[0][2]
        var min = model[0][3]

        for (var i = 1; i < n; i++) {

            open = model[i-1][1]
            close = open + 100 - 200*Math.random()
            upBar = close < open

            high = upBar ? close - 50 * Math.random() : open - 50 * Math.random()
            low = upBar ? open + 50 * Math.random() : close + 50 * Math.random()

            max = max >= high ? max : high
            min = min <= low ? min : low

            model[i] = [open, close, high, low]
        }

        var range = max - min
        var offset = (max + min)/2
        var scaleFactor = (height/range)

        console.log("### scale, offset: " + scaleFactor + ", " + offset)
        for (i = 0; i < n; i++) {
            for (var j = 0; j < 4; j++) {
                model[i][j] = model[i][j] - offset
                model[i][j] = model[i][j] * scaleFactor
                model[i][j] = model[i][j] + height/2
            }
        }

        return model
    }
}
