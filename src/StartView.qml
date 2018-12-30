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

    Connections{
        target: controller
        onGameStateChanged: {
            playButton.borderColor = controller.gameStateToColor()
        }
    }


    ColumnLayout{
        id: menu
        enabled: !settings.isOpen

        anchors.fill: parent
        anchors.margins: parent.height/5
        spacing: parent.height*0.01

        DefaultButton{
            id: playButton
            text: "PELAA"
            borderColor: controller.gameStateToColor()
            onAction: controller.startGame()
        }

        RowLayout{
            id: setFile
            width: parent.width

            DefaultButton{
                id: fileButton
                text: "VALITSE KYSYMYSTIEDOSTO"
                pointSize: setFontSize()/1.1
                radius: playButton.width/64
                onAction: showLoadUrl()
            }

            Rectangle{
                id: reverseButton
                color: "black"
                border.color: "gold"
                border.width: playButton.width*0.005
                radius: playButton.width/64
                Layout.fillHeight: true
                Layout.preferredWidth: height

                Image {
                    anchors.fill: reverseButton
                    source: "qrc:/images/refresh.png"
                }

                MouseArea{
                    id: mousearea
                    anchors.fill: reverseButton
                    hoverEnabled: true
                    onHoveredChanged: reverseButton.color = mousearea.containsMouse ? "midnightblue" : "black"
                    onClicked: controller.reverseGame()
                }
            }
        }
        DefaultButton{
            id: quitButton
            text: "LOPETA"
            onAction: quit()
        }
    }
    SettingsMenu{
        id: settings
    }

}
