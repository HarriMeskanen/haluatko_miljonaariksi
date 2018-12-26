import QtQuick 2.11
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    id: startView
    anchors.fill: parent

    Image {
        id: background
        anchors.fill: startView
        width: view.width
        height: view.height
        source: "qrc:/images/logo.png"
    }

    ColumnLayout{
        anchors.centerIn: startView
        width: startView.width*0.5
        height: startView.height/2
        spacing: startView.height*0.025

        DefaultButton{
            id: playButton
            text: "PELAA"
            onAction: {
                controller.startGame()
            }

        }

        DefaultButton{
            id: fileButton
            text: "VALITSE KYSYMYSTIEDOSTO"
            borderColor: controller.gameStateToColor()
            onAction: showLoadUrl()

            Connections{
                target: controller
                onGameStateChanged: fileButton.borderColor = controller.gameStateToColor()
            }
        }

        DefaultButton{
            id: quitButton
            text: "LOPETA"
            onAction: quit()
        }
    }

}
