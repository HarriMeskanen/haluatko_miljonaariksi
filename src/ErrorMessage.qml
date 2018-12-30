import QtQuick 2.10
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.0


Rectangle{
    id: message
    property string text
    color: "black"
    border.color: "gold"

    anchors.centerIn: parent
    width: parent.width*0.9
    height: parent.height/3
    border.width: width*0.005


    Text{
        id: messageText
        font.pointSize: setFontSize()*0.8
        text: setText(message.text, font.pointSize, message.width)
        color: "white"
        anchors.centerIn: message

    }

    CloseButton{
        anchors.right: message.right
        anchors.bottom: message.bottom
        onAction: message.destroy()
    }
}
