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
        loops: 1
        source: ""
    }

    function toggleSfx(){
        sfx.volume = (sfx.volume == 0) ? 1 : 0
    }

    function setSfx(id, inf){
        sfx.stop()
        if(inf)
            sfx.loops = MediaPlayer.Infinite
        else sfx.loops = 1
        sfx.source = "qrc:/sfx/" + id
        sfx.play()
    }

    function showStartView(){
        loader.source = "StartView.qml"
    }

    function showGameView(){
        loader.source = "GameView.qml"
        setSfx("lvl0.mp3", true)
    }

    function showEndView(win, correctIndex){
        loader.source = "EndView.qml"
        if(!win){
            showCondolencesMessage(correctIndex)
            setSfx("lose.mp3", false)
        }
        else if(win === 1) {
            showWinMessage()
            setSfx("win.mp3", false)
        }
        else if(win === -1){
            showConcedeMessage(correctIndex)
            setSfx("concede.mp3", false)
        }
    }


    function setFontSize(){
        var size = view.width*0.025
        if(size < 20)
            return 20
        return size
    }

    function setText(text, psize, width){
        var nText = text.length
        // how many chars will fit in one row. 0.85 to take DPI scaling into account
        var nMax = Math.round(((3/2)*(width/psize)*0.85))

        if(nText <= nMax)
            return text

        var prettyText = ""
        var rows = Math.floor(nText/nMax)
        var row = 1

        for(row; row<rows+1; row++){
            var nPretty = prettyText.length
            var ii = row*nMax

            while(true){
                if(text[ii] === " ")
                    break;
                ii -= 1
            }
            prettyText += text.substring(nPretty, ii) + "\n"
        }
        prettyText += text.substring(prettyText.length, nText)
        return prettyText
    }

    function showErrorMessage(error){
        var msg_text
        switch(error){
        case 0:
            msg_text = "Pelin alustus valitulla kysymystiedostolla epäonnistui."
            break;
        case 1:
            msg_text = "Toimintaehdot täyttävä kysymystiedosto valittava ennen pelaamista."
            break;
        case 2:
            msg_text = "Valittu kysymystiedosto pelattu loppuun. Valitse uusi kysymystiedosto tai " +
                        "nollaa tämän hetkinen kysymystiedosto jatkaaksesi pelaamista."
            break;
        default:
            msg_text = "Unknown error code"
            break;

        }
        var msg_component = Qt.createComponent("ErrorMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view,{"text": msg_text})
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

    function showConcedeMessage(correctIndex){
        var msg_component = Qt.createComponent("ConcedeMessage.qml")
        if(msg_component.status === Component.Ready){
            var msg_object = msg_component.createObject(view, {"prize":controller.gameRoundToPrize(),
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

    function showInfo(){
        var component = Qt.createComponent("Info.qml")
        if(component.status === Component.Ready){
            var object = component.createObject(view)
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
            showGameView()
        }
        onGameEnds:{
            showEndView(status, correct)
        }
        onGameContinues:{
            showCongratulationMessage()
        }
        onErrorSignal:{
            showErrorMessage(error)
        }
    }

    Component.onCompleted: {
        setSfx("theme.wav", false)
        showStartView()
    }
}
