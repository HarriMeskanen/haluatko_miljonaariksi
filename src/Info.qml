import QtQuick 2.10
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

Rectangle {
    id: info
    anchors.fill: parent
    color: "white"

    property int fsize: setFontSize()/1.5

    MouseArea{
        anchors.fill: parent
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 50

        Item {
            Layout.fillWidth: true

            Text{
                id: header
                text: "INFO"
                font.pixelSize: info.fsize
                font.bold: true
                font.underline: true
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }


        Item{
            id: licenceInfo
            Layout.fillHeight: true
            Layout.fillWidth: true
            Row{
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    id: licenceInfoText
                    text: "Lisenssi: "
                    font.pixelSize: info.fsize
                    font.bold: true
                }
                Text{
                    text: '<a href=\"https://www.gnu.org/licenses/lgpl-3.0.en.html">GNU LESSER GENERAL PUBLIC LICENSE</a>'
                    onLinkActivated: Qt.openUrlExternally("https://www.gnu.org/licenses/lgpl-3.0.en.html")
                    font.pixelSize: info.fsize
                }
            }
        }

        Item{
            id: repoInfo
            Layout.fillHeight: true
            Layout.fillWidth: true
            Row{
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    text: "Lähdekoodi: "
                    font.bold: true
                    font.pixelSize: info.fsize
                }
                Text{
                    text:'<a href=\"https://github.com/HarriMeskanen/haluatko_miljonaariksi.git">GitHub repository</a>'
                    onLinkActivated: Qt.openUrlExternally("https://github.com/HarriMeskanen/haluatko_miljonaariksi.git")
                    font.pixelSize: info.fsize
                }
            }
        }

        Item{
            id: questionInfo
            Layout.fillHeight: true
            Layout.fillWidth: true

            Column{
                spacing: 10
                anchors.verticalCenter: parent.verticalCenter
                Text{
                    text: "Kysymystiedostossa käytettävä formaatti:"
                    font.bold: true
                    font.pixelSize: info.fsize
                }
                Text {
                    text: "vaikeusaste[0,3];kysymys;A;B;C;D;oikea vastaus[0,3]"
                    font.pixelSize: info.fsize
                }
                Item{
                    height: 10
                }
                Text{
                    text: "Esim vaikeustasoltaan vaikein kysymys voisi olla:"
                    font.pixelSize: info.fsize
                }
                Text{
                    text: "3;Mikä on Suomen pääkaupunki?;Oulu;Tampere;Helsinki;Turku;2"
                    font.italic: true
                    font.pixelSize: info.fsize
                }
                Text {
                    text: "Huom! kysymystiedoston ensimmäisen rivin tulee olla mielivaltainen otsikkorivi."
                    font.pixelSize: info.fsize
                }
            }
        }
    }

    Button{
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10

        text: "OK"
        onClicked: {
            info.destroy()
        }
    }

}
