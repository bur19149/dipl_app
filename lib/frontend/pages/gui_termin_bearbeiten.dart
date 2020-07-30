import 'package:dipl_app/frontend/gui_eingabefelder.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';

import '../gui_buttons.dart';
import '../gui_konstanten.dart';
import '../gui_pages.dart';
import '../gui_rahmen.dart';

class TerminBearbeitenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminBearbeitenPageState();
}

class _TerminBearbeitenPageState extends State<TerminBearbeitenPage> {
  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Termin bearbeiten', style: Schrift.ueberschrift())),
        Textfeld(text: 'Termin Name', hintText: 'Name des Termins'),
        Textfeld(text: 'Beschreibung', hintText: 'Terminbeschreibung', multiline: true),
        Textfeld(text: 'Ort', hintText: 'Wohnort'),
        Textfeld(text: 'Anzahl freier Plätze', hintText: 'Platzanzahl', bottomHintText: '0 um Beschränkung aufzuheben'),
        Textfeld(text: 'Datum/Uhrzeit von', dateTime: true),
        Textfeld(text: 'Datum/Uhrzeit bis', dateTime: true),
        Row(children: [
          Expanded(child: Container()),
          Text('Öffentlich', style: Schrift()),
          SizedBox(width: 30),
          CustomToggleButton(
            size: 70,
            onTap: () {},
          ),
          Expanded(child: Container())
        ]),
        Button(
          text: 'Termin löschen',
          farbe: Buttonfarbe.rot,
          onPressed: () {},
        ),
        Button(
          text: 'Abbrechen',
          onPressed: () {},
        ),
        Button(
          text: 'Änderungen übernehmen',
          farbe: Buttonfarbe.gruen,
          onPressed: () {},
        ),
      ])
    ]);
  }
}
