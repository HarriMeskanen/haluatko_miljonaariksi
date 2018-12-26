import QtQuick 2.11
import QtQuick.Layouts 1.3


Rectangle{
    id: button

    property string text: ""
    signal action()

    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005

    Layout.fillWidth: true
    Layout.fillHeight: true
    Layout.minimumHeight: 50
    Layout.minimumWidth: 50
    radius: width/64

    Text{
        id: buttonText
        text: button.text
        color: "white"
        anchors.centerIn: button
        font.pointSize: setFontSize()/2

    }

    MouseArea{
        id: mousearea
        anchors.fill: button

        onClicked: {
            button.state == 'selected' ? button.state = "" : button.state = 'selected';
            button.action()
        }

    }

    states: [
        State {
            name: "selected"
            PropertyChanges {
                target: button
                color: "yellow"
            }
            PropertyChanges{
                target: buttonText
                color: "black"
            }
        },
        State {
            name: "correct"
            PropertyChanges {
                target: button
                color: "green"
            }
        }

    ]
}
