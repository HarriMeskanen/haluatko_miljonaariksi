import QtQuick 2.0


Rectangle{
    id: button

    property string text: ""
    property real pointSize: setFontSize()/2
    property string borderColor: "gold"
    signal action()

    color: "black"
    border.color: borderColor

    width: parent.width/8
    height: parent.height/18
    border.width: width*0.005

    anchors.right: parent.right
    anchors.top: parent.top
    anchors.topMargin: parent.height/8
    radius: width/64

    Text{
        id: buttonText
        text: button.text
        color: "white"
        anchors.centerIn: button
        font.pointSize: button.pointSize

    }

    MouseArea{
        id: mouseArea
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
