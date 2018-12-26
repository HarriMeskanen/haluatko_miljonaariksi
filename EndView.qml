import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: endView
    anchors.fill: parent

    Image {
        id: background
        anchors.fill: endView
        source: "qrc:/images/logo.png"
    }        

    ColumnLayout{
        anchors.centerIn: parent
        width: parent.width/1.5
        height: parent.height/2
        spacing: endView.height*0.025

        DefaultButton{
            text: "PELAA UUDELLEEN"
            onAction: controller.startGame()
        }
        DefaultButton{
            text: "PALAA PÄÄVALIKKOON"
            onAction: showStartView()
        }

        DefaultButton{
            text: "LOPETA"
            onAction: quit()
        }
    }
}
