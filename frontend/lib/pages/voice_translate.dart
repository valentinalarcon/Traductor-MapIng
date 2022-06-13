import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceTranslate extends StatefulWidget {
  final bool value;
  VoiceTranslate(this.value, {Key? key}) : super(key: key);

  @override
  State<VoiceTranslate> createState() => _VoiceTranslateState();
}

class _VoiceTranslateState extends State<VoiceTranslate> {
  final SpeechToText _speech = SpeechToText(); // Hay que modificar
  final bool _speechEnabled = false;
  String _text = '';
  String traducir = "";
  List<String> _mensajes = []; //Hay que modificar
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  // Función que evalua la disponibilidad del microfono

  void _initSpeech() async {
    //_speechEnabled = await _speech.initialize();
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              idk(),
              barraEnvio(widget.value),
              Container(
                // separación entre barra y boton
                padding: const EdgeInsets.only(bottom: 90),
              )
            ],
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
            onPressed: null,
            //_speech.isNotListening ? _startListening : _stopListening,
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

Widget idk() {
  return Expanded(
      child: Container(
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
    )),
    child: const ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      //child: Funcion(
      //mensajes: _mensajes,
      //textoInicial: "Presione el mic para empezar grabacion"),
    ),
  ));
}

Widget barraEnvio(value) {
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
            "",
            //_speechEnabled ? '$_text' : 'Speech no está disponible',
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
