import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
    if (widget.speaker) {
      await flutterTts.setLanguage("ru-RU");
    } else {
      await flutterTts.setLanguage("es-CL");
    }
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

  @override
  Widget build(BuildContext context) {
    return (IconButton(
      icon: const Icon(Icons.play_circle_outline),
      tooltip: 'Escuchar',
      color: Colors.black,
      onPressed: () {
        _speak(widget.texto);
      },
    ));
  }
}
