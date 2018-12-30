import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle{
    id: ll

    width: parent.width/8
    height: parent.height/6
    color: "black"
    radius: height/32

    ColumnLayout{
        id: buttons
        anchors.fill: ll

        LLButton{
            text: "Käytä 50/50"
            pointSize: setFontSize()/2
            onAction: controller.viewStep(5050)
        }
        LLButton{
            text: "Käytä 50/60"
            pointSize: setFontSize()/2
            onAction: controller.viewStep(5060)
        }
        LLButton{
            text: "Kysy katsomolta"
            pointSize: setFontSize()/2
            onAction: controller.viewStep(100)
        }
    }
}
