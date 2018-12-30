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

    Connections{
        target: controller
        onGameStateChanged: {
            playButton.borderColor = controller.gameStateToColor()
        }
    }

    ColumnLayout{
        anchors.centerIn: parent
        width: parent.width/1.5
        height: parent.height/2
        spacing: endView.height*0.025

        DefaultButton{
            id: playButton
            borderColor: controller.gameStateToColor()
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
