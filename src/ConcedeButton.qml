import QtQuick 2.0


Rectangle{
    id: button

    property real pointSize: setFontSize()/2
    property string borderColor: "gold"
    signal action()

    color: "black"
    border.color: borderColor

    width: parent.width/8
    height: parent.height/18
    border.width: width*0.005
    radius: width/64

    Text{
        id: buttonText
        text: "Luovuta"
        color: "white"
        anchors.centerIn: parent
        font.pointSize: parent.pointSize

    }

    MouseArea{
        id: mouseArea
        anchors.fill: button
        hoverEnabled: true

        onHoveredChanged: {
            parent.color = containsMouse ? "midnightblue" : "black"
        }

        onClicked: {
            parent.action()
        }

    }
}
