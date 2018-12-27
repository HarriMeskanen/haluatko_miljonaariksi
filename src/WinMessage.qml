import QtQuick 2.0

Rectangle{
    id: message

    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005
    width: parent.width
    height: parent.height/4
    radius: width/64
    anchors.centerIn: parent

    Text{
        id: messageText
        text: "Onneksi olkoon, voitit pelin!"
        color: "white"
        anchors.centerIn: message
        font.pointSize: setFontSize()*0.9
    }

    Timer{
        id: timer
        interval: 5000
        running: true
        repeat: false
        onTriggered: {
            running = false
            message.destroy();
        }
    }
}
