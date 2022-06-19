import 'dart:html';

import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';

class TextTranslate extends StatefulWidget {
  final bool value;
  TextTranslate(this.value, {Key? key}) : super(key: key);

  @override
  State<TextTranslate> createState() => _TextTranslateState();
}

class _TextTranslateState extends State<TextTranslate> {
  String? currentValue = '  Español-Mapudungún';
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
              color: const Color.fromARGB(255, 147, 147, 147).withOpacity(0.2),
              child: DropdownButton(
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
                  child: buildMessage(widget.value),
                ),
              )),
        ),
      ),
    );
  }
}

AppBar bar(context, value) {
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

Widget buildMessage(value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0),
    height: 50.0,
    color: const Color.fromARGB(255, 217, 217, 217),
    child: Row(
      children: const <Widget>[
        Expanded(
            child: TextField(
          style: TextStyle(color: Colors.black),
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: "Escribe frase para traducir",
            hintStyle: TextStyle(color: Colors.black),
          ),
        )),
        IconButton(
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
