import QtQuick 2.10

Rectangle{
    id: message

    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005
    width: parent.width*0.9
    height: parent.height/4
    radius: width/64
    anchors.centerIn: parent

    Text{
        id: messageText
        text: "Onneksi olkoon, voitit " + controller.gameRoundToPrize() + " euroa!"
        color: "white"
        anchors.centerIn: message
        font.pointSize: setFontSize()*0.9
    }

    Timer{
        id: timer
        interval: 2000
        running: true
        repeat: false
        onTriggered: {
            running = false
            message.destroy();
        }
    }
}
