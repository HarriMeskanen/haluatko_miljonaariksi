import QtQuick 2.0

Rectangle{
    id: button

    signal action()

    color: "black"
    border.color: "gold"

    height: parent.height/4
    width: 2*height
    border.width: parent.width*0.005

    Text{
        id: buttonText
        text: "ok"
        color: "white"
        anchors.centerIn: button
        font.pointSize: button.height/2

    }

    MouseArea{
        id: mousearea
        anchors.fill: button
        hoverEnabled: true

        onHoveredChanged: {
            button.color = containsMouse ? "midnightblue" : "black"
        }

        onClicked: {
            button.action()
        }
    }
}

