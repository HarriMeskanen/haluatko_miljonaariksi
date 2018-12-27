import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle{
    id: button

    property string text: ""
    property real pointSize: setFontSize()
    property string borderColor: "gold"
    signal action()

    color: "black"
    border.color: borderColor
    border.width: parent.width*0.005

    Layout.fillWidth: true
    Layout.fillHeight: true
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
            button.color = "black"
            mouseArea.enabled = false
            buttonText.text = ""
        }

    }
}
