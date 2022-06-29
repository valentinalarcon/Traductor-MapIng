import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BotonTTS extends StatefulWidget {
  final String texto;
  final bool autoplay;
  final bool speaker;

  const BotonTTS(
      {Key? key,
      required this.texto,
      required this.autoplay,
      required this.speaker})
      : super(key: key);

  @override
  _BotonTTSState createState() => _BotonTTSState();
}

class _BotonTTSState extends State<BotonTTS> {
  bool _autoplayDone = false;

  FlutterTts flutterTts = FlutterTts();

  Future _configs() async {
    await flutterTts.setLanguage("es-CL");
  }

  Future _speak(texto) async {
    await _configs();
    await flutterTts.speak(texto);
  }

  Future<void> _init() async {
    if (widget.autoplay && !(_autoplayDone)) {
      _speak(widget.texto);
      _autoplayDone = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void didUpdateWidget(BotonTTS oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.autoplay && (widget.texto != oldWidget.texto)) {
      _speak(widget.texto);
    }
  }

  void mapudungun() async {
    AudioCache player = AudioCache();
    String url = "http://10.0.2.2:5000/translator/ttsmap";
    var connect = Uri.parse(url);
    Map data = {"text": widget.texto};
    var body = jsonEncode(data);
    var response = await http.post(connect,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Accept": "*/*",
        },
        body: body);
    var temp = response.body;
    //player.loadAll(temp)
    for (int i = 0; i < response.bodyBytes.length; i++) {
      final player = AudioCache();
      String aux = temp[0];
      print(aux);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      icon: const Icon(Icons.play_circle_outline),
      tooltip: 'Escuchar',
      color: Colors.black,
      onPressed: () {
        if (widget.speaker) {
          mapudungun();
        } else {
          _speak(widget.texto);
        }
      },
    ));
  }
}
