import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:frontend/models/modelos.dart';
import 'package:frontend/pages/settings.dart';
import 'package:frontend/widgets/mensajes.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceTranslate extends StatefulWidget {
  final bool value;
  VoiceTranslate(this.value, {Key? key}) : super(key: key);

  @override
  State<VoiceTranslate> createState() => _VoiceTranslateState();
}

class _VoiceTranslateState extends State<VoiceTranslate> {
  String? currentValue = '  Español-Mapudungún';
  final _speech = SpeechToText();
  final _tts = FlutterTts();
  bool _speechEnabled = false;
  String _text = '';
  String traducir = "";
  final List<Message> _mensajes = [];

  speak(String texto) async {
    await _tts.setLanguage("en-US");
    await _tts.setPitch(1); // 0.5 - 1.5
    await _tts.speak(texto);
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // Función que evalua la disponibilidad del microfono

  void _initSpeech() async {
    _speechEnabled = await _speech.initialize();
    setState(() {});
  }

// Función que indica el inicio del reconocimiento de voz
  void _startListening() async {
    await _speech.listen(onResult: _onSpeechResult);
    setState(() {});
  }

// Función que indica el final del reconocimiento de voz
  void _stopListening() async {
    await _speech.stop();
    setState(() {});
  }

// Función que devuelve en _text las palabras reconocidas por el microfono
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _text = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: bColor(widget.value),
        appBar: bar(context, widget.value),
        body: Scaffold(
          backgroundColor: bColor(widget.value),
          appBar: AppBar(
            backgroundColor: bColor(widget.value),
            elevation: 0,
            title: Center(
                child: Container(
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(255, 147, 147, 147).withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: const Color.fromARGB(255, 147, 147, 147),
                    style: BorderStyle.solid,
                    width: 0.80),
              ),
              height: 50,
              width: 250,
              child: DropdownButtonFormField(
                items: <String>['  Español-Mapudungún', '  Inglés-Español']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: currentValue,
                onChanged: (String? valueIn) {
                  setState(() {
                    currentValue = valueIn;
                  });
                },
                iconEnabledColor: const Color.fromARGB(255, 0, 152, 80),
                iconDisabledColor: const Color.fromARGB(255, 0, 152, 80),
                iconSize: 50,
              ),
            )),
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Column(
              children: <Widget>[
                idk(_mensajes),
                barraEnvio(widget.value, _speechEnabled, _text),
                //Temporal, meintras se generan endpoints
                ElevatedButton(
                    onPressed: () => speak("I don't know"),
                    child: Text("button")),
                // hasta aquí es temporal
                Container(
                  // separación entre barra y boton
                  padding: const EdgeInsets.only(bottom: 90),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          glowColor: Theme.of(context).primaryColor,
          endRadius: 30.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 0, 152, 80),
            onPressed:
                _speech.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speech.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        ),
      ),
    );
  }
}

AppBar bar(context, value) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Text(
      "Voz",
      style: TextStyle(
          color: tColor(value),
          fontFamily: 'Inter',
          fontSize: 20,
          fontWeight: FontWeight.w900),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConfigApp(value)),
          );
        },
        icon: const Icon(Icons.settings,
            color: Color.fromARGB(255, 115, 115, 115)),
        iconSize: 40,
      )
    ],
  );
}

Widget idk(enviados) {
  return Expanded(
      child: Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    )),
    child: ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      child: Mensajes(
          mensajes: enviados,
          textoInicial: "Presione el mic para empezar grabacion"),
    ),
  ));
}

Widget barraEnvio(value, speechEnabled, text) {
  return Container(
    decoration: const BoxDecoration(
        color: Color.fromARGB(255, 217, 217, 217),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        )),
    padding: const EdgeInsets.only(bottom: 0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            speechEnabled ? '$text' : 'Speech no está disponible',
            style: TextStyle(color: tColor(value)),
            textAlign: TextAlign.center,
          ),
        ),
        const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.send_rounded,
              color: Color.fromARGB(255, 0, 152, 80),
            ))
      ],
    ),
  );
}

Color bColor(value) {
  const List<Color> temas = [Colors.white, Color.fromARGB(255, 42, 42, 42)];
  return temas[value ? 0 : 1];
}

Color tColor(value) {
  const List<Color> temas = [Colors.black, Colors.white];
  return temas[value ? 0 : 1];
}
