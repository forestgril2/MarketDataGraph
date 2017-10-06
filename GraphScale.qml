import QtQuick 2.0

Rectangle {
    id: base

    property int number: 10
    property int length: 50
    property int thickness: 2

    color: "transparent"
    width: length

    anchors {
        top: parent.top
        bottom: parent.bottom
    }

    Column {
        id: scale

        spacing: base.height/base.number - thickness
        anchors {
            fill: parent
            topMargin: -thickness/2
        }

        Repeater {
            model: +number
            z: 10

            Rectangle {
                id: mark

                width: base.length
                height: base.thickness
                color: "black"
            }
        }
    }
}
