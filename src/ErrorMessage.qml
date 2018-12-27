import QtQuick 2.10
import QtQuick.Dialogs 1.2



MessageDialog {
    id: message
    title: "Virhe"
    text: "Tiedoston avaaminen tai käyttöönotto epäonnistui."
    onAccepted: {
        message.close
    }
    Component.onCompleted: {
        visible = true
    }
}
