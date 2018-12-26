import QtQuick 2.9
import QtQuick.Window 2.2
import QtMultimedia 5.9

Window {
    id: view
    visible: true
    width: 1280
    height: 720
    title: qsTr("Haluatko miljardööriksi?")


    Loader{
        id: loader
        anchors.fill: parent
        focus: true

        function setProperty(p, val){
            item.p = val
        }
    }

    MediaPlayer{
        id: sfx
        loops: MediaPlayer.Infinite
        source: "qrc:/sfx/theme.wav"
    }

    function setSfx(id){
        sfx.stop()
        sfx.source = "qrc:/sfx/" + id
        sfx.play()
    }

    function showStartView(){
        loader.source = "StartView.qml"
    }

    function showGameView(){
        loader.source = "GameView.qml"
        setSfx("lvl0.mp3")
    }

    function showEndView(win, correctIndex){
        loader.source = "EndView.qml"
        if(win){
            showWinMessage()
            setSfx("win.mp3")
        }
        else {
            showCondolencesMessage(correctIndex)
            setSfx("lose.mp3")
        }
    }

    function setFontSize(){
        var size = view.width*0.025
        if(size < 20)
            return 20
        return size
    }

    function setText(text, psize, width){
        var textLength = text.length
        var maxLength = (3/2)*(width/psize)
        if(textLength <= maxLength)
            return text

        var mul = Math.floor(textLength/maxLength)
        var prettyText = ""
        var i = 1
        for(i; i<mul+1; i++){
            prettyText += text.substring((i-1)*maxLength,i*maxLength) + "\n"
        }
        prettyText += text.substring((i-1)*maxLength, text.length)
        return prettyText
    }

    function showErrorMessage(){
        var msg_component = Qt.createComponent("ErrorMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view)
        }
    }

    function showWinMessage(){
        var msg_component = Qt.createComponent("WinMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view)
        }
    }

    function showCongratulationMessage(){
        var msg_component = Qt.createComponent("CongratulationMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view)
        }
    }

    function showCondolencesMessage(correctIndex){
        var msg_component = Qt.createComponent("CondolencesMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view, {"prize":controller.gameResultToPrize(),
                                                                "correctChoice": indexToChoice(correctIndex)})
        }
    }

    function showLoadUrl(){
        var component = Qt.createComponent("LoadUrl.qml")
        if(component.status === Component.Ready){
            var object = component.createObject(view)
        }
    }

    function showVoteResults(a, b, c, d){
        var component = Qt.createComponent("VoteResultChart.qml")
        if(component.status === Component.Ready){
            var object = component.createObject(view, {"a":a,"b":b,"c":c,"d":d})
        }
    }

    function indexToChoice(i){
        switch(i){
        case 0:
            return model.a
        case 1:
            return model.b
        case 2:
            return model.c
        case 3:
            return model.d
        }

    }

    function quit(){
        controller.quit()
    }

    Connections{
        target: controller

        onGameStarts:{
            if(status)
                showGameView()
        }
        onGameEnds:{
            showEndView(status, correct)
        }
        onGameContinues:{
            showCongratulationMessage()
        }
    }

    Component.onCompleted: {
        sfx.play()
        showStartView()
    }
}
