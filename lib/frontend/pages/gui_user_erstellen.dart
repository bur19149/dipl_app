import 'package:dipl_app/frontend/gui_eingabefelder.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/material.dart';
import '../gui_buttons.dart';
import '../gui_pages.dart';
import '../gui_rahmen.dart';
import '../gui_text.dart';

class UserErstellenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserErstellenPageState();
}

class _UserErstellenPageState extends State<UserErstellenPage> {
  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Stammdaten', style: Schrift.ueberschrift())),
        Teiler(), Textfeld(text: 'E-Mail', hintText: 'E-Mail Adresse'),
        Teiler(), Textfeld(text: 'Vorname(n)', hintText: 'Vorname'),
        Teiler(), Textfeld(text: 'Nachname', hintText: 'Nachname'),
        Teiler(), Placeholder(fallbackHeight: 70),
        Teiler(), Textfeld(text: 'Postleitzahl', hintText: 'PLZ'),
        Teiler(), Textfeld(text: 'Ort', hintText: 'Wohnort'),
        Teiler(), Placeholder(fallbackHeight: 140),
        Teiler(), Button(text: 'Abbrechen', onPressed: () {}),
        Teiler(buttonTrenner: true), Button(text: 'Anlegen', onPressed: () {}, farbe: Buttonfarbe.gruen),
      ])
    ]);
  }
}
