import QtQuick 2.0

Rectangle {
    id: message
    property int prize: 0
    property string correctChoice: ""

    width: parent.width*0.9
    height: parent.height/3
    anchors.centerIn: parent
    radius: parent.width/64
    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005

    Column{
        anchors.centerIn: parent
        Text{
            text: "Hävisit. Voitit kuitenkin " + message.prize + "e."
            color: "white"
            font.pointSize: setFontSize()
        }
        Text{
            text: setText("Oikea vastaus olisi ollut: " + message.correctChoice, font.pointSize, message.width)
            color: "white"
            font.pointSize: setFontSize()
        }
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
