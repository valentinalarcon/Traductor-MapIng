import 'dart:convert';
import 'package:frontend/widgets/buildMessage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';

class TextTranslate extends StatefulWidget {
  final bool value;
  final String _direccion;
  TextTranslate(this.value, this._direccion, {Key? key}) : super(key: key);

  @override
  State<TextTranslate> createState() => _TextTranslateState();
}

class _TextTranslateState extends State<TextTranslate> {
  String? currentValue = '  Español-Mapudungún';
  final myController = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: bColor(widget.value),
      appBar: bar(context, widget.value, widget._direccion),
      body: Scaffold(
        backgroundColor: bColor(widget.value),
        appBar: AppBar(
          backgroundColor: bColor(widget.value),
          elevation: 0,
          title: Center(
              child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 147, 147, 147).withOpacity(0.2),
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
          child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: BuildMessage(
                  myController,
                  currentValue,
                  widget._direccion,
                ),
              )),
        ),
      ),
    ));
  }
}

AppBar bar(context, value, direccion) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Text(
      "Texto",
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
            MaterialPageRoute(
                builder: (context) => ConfigApp(value, direccion)),
          );
        },
        icon: const Icon(Icons.settings,
            color: Color.fromARGB(255, 115, 115, 115)),
        iconSize: 40,
      )
    ],
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
