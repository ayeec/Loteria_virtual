/*$(document).ready(function () {
    $("#MainContent_imgBtnMakeNoise").on('click', function (e) {
        //debugger;
        //var u1 = new SpeechSynthesisUtterance('Hola mundo cruel..');
        var u1 = new SpeechSynthesisUtterance(document.getElementById('MainContent_lblCardAtHand').textContent);
        u1.lang = 'es-MX';
        u1.pitch = 1;
        u1.rate = 1;
        //u1.voice = voices[10];
        u1.voiceURI = 'native';
        u1.volume = 1;
        speechSynthesis.speak(u1);

    });
});*/function makeNoise() {
    debugger;
    var u1 = new SpeechSynthesisUtterance(document.getElementById('MainContent_lblCardAtHand').textContent);
    //u1.lang = 'en-US';
    try{
        var voices = window.speechSynthesis.getVoices();

        for (i = 0; i < voices.length; i++) {
            if (voices[i].lang == 'es-MX') {
                u1.voice = voices[i];
                break;
            }
        }
    }
    catch (err) {
        //ignore and continue
    }

    //u1.lang = 'es-MX';
    u1.pitch = 1;
    u1.rate = 1;
    //u1.voice = voices[10];
    //u1.voiceURI = 'native';
    u1.volume = 1;
    speechSynthesis.speak(u1);

    //Update counter
    document.getElementById("MainContent_hdnUsedSound").value = parseInt(document.getElementById("MainContent_hdnUsedSound").value) + 1;
};