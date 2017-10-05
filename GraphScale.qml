import QtQuick 2.0

Rectangle {
    id: base

    property int number: 10
    property int length: 50
    property int thickness: 5

    color: "transparent"
    width: 100

    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
    }

    Column {
        id: scale

        spacing: base.height/base.number
        anchors.fill: parent

        Repeater {
            model: 10
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
