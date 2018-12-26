import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

Item {
    id: view
    anchors.fill: parent

    Image {
        id: background
        width: view.width
        height: view.height
        anchors.fill: view
        source: "qrc:/images/logo.png"
    }

    Connections{
        target: model

        onModelChanged:{
            choices.reset()
            question.text = model.question
            a.text = setText(model.a, setFontSize(), view.width)
            b.text = setText(model.b, setFontSize(), view.width)
            c.text = setText(model.c, setFontSize(), view.width)
            d.text = setText(model.d, setFontSize(), view.width)
        }

        onLevelChanged:{
            setSfx("lvl" + level + ".mp3")
        }

        onVoteResults:{
            showVoteResults(a,b,c,d)
        }
    }

    LifeLines{
        id: ll
    }

    ColumnLayout{
        id: questionAndChoices
        anchors.centerIn: parent
        width: parent.width*0.8
        height: parent.height/3


        QuestionBox{
            id: question
        }

        GridLayout{
            id: choices
            Layout.fillWidth: true
            columns: 2

            function reset(){
                a.state = ""; b.state = ""; c.state = ""; d.state = "";
            }

            GameButton{
                id: a
                onAction: controller.viewStep(0)
            }
            GameButton{
                id: b
                onAction: controller.viewStep(1)
            }
            GameButton{
                id: c
                onAction: controller.viewStep(2)
            }
            GameButton{
                id: d
                onAction: controller.viewStep(3)
            }
        }
    }

}
