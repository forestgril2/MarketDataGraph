import QtQuick 2.0

Repeater {
    id: scale

    property int number
    property int length
    property int thickness
    anchors {
        left: parent.left
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }

    model: number
    z: 10

    Rectangle {
        id: mark

        anchors.left: parent.left
        width: scale.length
        height: scale.thickness
        y: scale.index * parent.height/scale.number - height/2
        color: "black"
    }
}
