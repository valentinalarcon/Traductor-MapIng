import 'package:flutter/material.dart';
import 'package:frontend/pages/settings.dart';

class InfoEquipo extends StatefulWidget {
  final bool value;
  const InfoEquipo(this.value, {Key? key}) : super(key: key);

  @override
  State<InfoEquipo> createState() => _InfoEquipoState();
}

class _InfoEquipoState extends State<InfoEquipo> {
  List<String> a = ["Tremend", "Increible", "Epicardo"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: bar(context, widget.value),
        backgroundColor: bColor(widget.value),
      ),
    );
  }
}

AppBar bar(context, value) {
  return AppBar(
    backgroundColor: bColor(value),
    title: Row(
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConfigApp(value)),
            );
          },
          icon: Icon(Icons.arrow_back_outlined, color: tColor(value)),
          iconSize: 50,
        ),
        SizedBox(
          width: 200,
          height: 50,
          child: Center(
              child: Text(
            "Información",
            style: TextStyle(
                color: tColor(value),
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.w900),
          )),
        ),
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
