import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Dialogs 1.2

Item {
    anchors.fill: parent

    BusyIndicator {
        id: loadingIcon
        width: parent.width/4
        height: width
        anchors.centerIn: parent
    }

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            controller.initializeGame(fileDialog.fileUrl)
            fileDialog.close
        }
        onRejected: {
            console.log("Canceled")
            fileDialog.close
        }
        Component.onCompleted:{
            loadingIcon.running = false
            visible = true
        }
    }
}
