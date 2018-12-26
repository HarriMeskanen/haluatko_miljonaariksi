import QtQuick 2.10
import QtQuick.Layouts 1.3


Rectangle{
    property string text: ""
    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005

    Layout.preferredHeight: setFontSize()*2
    Layout.minimumHeight: 50
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: width/64

    Text{
        anchors.centerIn: parent
        font.pointSize: setFontSize()/2
        text: setText(parent.text, font.pointSize, parent.width)
        color: "white"
    }
}


