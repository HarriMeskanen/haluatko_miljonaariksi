import QtQuick 2.10
import QtQuick.Layouts 1.3

Rectangle{
    id: chart

    property int a
    property int b
    property int c
    property int d
    property int sum: a+b+c+d

    color: "black"
    border.color: "gold"
    border.width: parent.width*0.005
    width: height
    height: parent.height/2
    radius: width/64
    anchors.centerIn: parent


    Row{
       id: row
       //anchors.fill: chart
       spacing: chart.width/8
       anchors.bottom: chart.bottom
       anchors.bottomMargin: chart.border.width
       anchors.left: chart.left
       anchors.leftMargin: chart.border.width + width/16

        Rectangle{
            id: aBar
            color: "midnightblue"
            height: chart.height*a/sum
            width: chart.width/8
            anchors.bottom: row.bottom

            Text{
                text: "A"
                color: "white"
                font.pointSize: setFontSize()
                anchors.horizontalCenter: aBar.horizontalCenter
                anchors.top: aBar.bottom
            }
        }
        Rectangle{
            id: bBar
            color: "midnightblue"
            height: chart.height*b/sum
            width: chart.width/8
            anchors.bottom: row.bottom

            Text{
                text: "B"
                color: "white"
                font.pointSize: setFontSize()
                anchors.horizontalCenter: bBar.horizontalCenter
                anchors.top: bBar.bottom
            }
        }
        Rectangle{
            id: cBar
            color: "midnightblue"
            height: chart.height*c/sum
            width: chart.width/8
            anchors.bottom: row.bottom

            Text{
                text: "C"
                color: "white"
                font.pointSize: setFontSize()
                anchors.horizontalCenter: cBar.horizontalCenter
                anchors.top: cBar.bottom
            }
        }
        Rectangle{
            id: dBar
            color: "midnightblue"
            height: chart.height*d/sum
            width: chart.width/8
            anchors.bottom: row.bottom

            Text{
                text: "D"
                color: "white"
                font.pointSize: setFontSize()
                anchors.horizontalCenter: dBar.horizontalCenter
                anchors.top: dBar.bottom
            }
        }

    }

    Timer{
        id: timer
        interval: 5000
        running: true
        repeat: false
        onTriggered: {
            running = false
            chart.destroy();
        }
    }
}
