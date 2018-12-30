import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle{
    id: menu

    property bool isOpen: false
    property real closedWidth: height/12

    color: "black"
    border.color: "gold"

    height: parent.height*0.9
    width: closedWidth + isOpen*(parent.width/2)
    border.width: height*0.005
    radius: height/64

    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    anchors.rightMargin: -2*border.width


    MouseArea{
        id: toggle

        height: parent.height
        width: parent.closedWidth

        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        hoverEnabled: true
        onHoveredChanged: menu.color = containsMouse ? "midnightblue" : "black"
        onClicked: {
            buttonText.rotation = buttonText.rotation == 0 ? 180 : 0
            menu.isOpen = menu.isOpen ? false : true
        }
        Text {
            id: buttonText

            anchors.centerIn: parent
            rotation: 0

            text: "<"
            font.pointSize: setFontSize()
            color: "white"
        }
    }

    Rectangle{
        id: fg

        color: "black"
        border.color: "gold"

        anchors.fill: menu
        anchors.leftMargin: menu.closedWidth
        border.width: menu.height*0.005
    }


    ColumnLayout{
        id: settings
        visible: menu.isOpen
        anchors.fill: fg
        spacing: 0

        DefaultButton{
            id: toggleSoundButton
            text: "VAIMENNA/PALAUTA ÄÄNI"
            radius: 0
            onAction: toggleSfx()
        }

        DefaultButton{
            id: infoButton
            text: "INFO"
            radius: 0
            onAction: showInfo()
        }
    }

}


