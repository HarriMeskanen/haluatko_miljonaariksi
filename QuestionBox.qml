import QtQuick 2.10
import QtQuick.Layouts 1.3


Rectangle{
    property string text: ""
    property int fontSize: setFontSize()/2
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
        font.pointSize: parent.fontSize
        text: parent.text
        color: "white"
    }
}


