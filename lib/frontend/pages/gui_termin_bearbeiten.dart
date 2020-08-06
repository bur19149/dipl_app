import 'package:dipl_app/frontend/gui_eingabefelder.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import '../gui_konstanten.dart';
import '../gui_buttons.dart';
import '../gui_rahmen.dart';
import '../gui_pages.dart';

class TerminBearbeitenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminBearbeitenPageState();
}

class _TerminBearbeitenPageState extends State<TerminBearbeitenPage> {
  Wrapper beschreibung = Wrapper();


  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Termin bearbeiten', style: Schrift.ueberschrift())),
        Teiler(),
        Textfeld(text: 'Termin Name', hintText: 'Name des Termins'),
        Teiler(),
        Textfeld(
            text: 'Beschreibung',
            hintText: 'Terminbeschreibung',
            multiline: true, value: beschreibung, validator: (text) {
              if(text.isNotEmpty) {
                beschreibung.value = text;
                return null;
              }
              return 'ungültig';}),
        Teiler(),
        Textfeld(text: 'Ort', hintText: 'Wohnort'),
        Teiler(),
        Textfeld(
            text: 'Anzahl freier Plätze',
            hintText: 'Platzanzahl',
            bottomHintText: '0 um Beschränkung aufzuheben'),
        Teiler(),
        Textfeld(text: 'Datum/Uhrzeit von', dateTime: true),
        Teiler(),
        Textfeld(text: 'Datum/Uhrzeit bis', dateTime: true),
        Teiler(),
        ExpandableInnerRahmen(children: [
          Textfeld(text: 'Öffentlich ab', dateTime: true),
          Teiler(),
          Textfeld(text: 'Öffentlich bis', dateTime: true),
        ]),
        Button(
          text: 'Termin löschen',
          farbe: Buttonfarbe.rot,
          onPressed: () {},
        ),
        Teiler(buttonTrenner: true),
        Button(
          text: 'Abbrechen',
          onPressed: () {},
        ),
        Teiler(buttonTrenner: true),
        Button(
          text: 'Änderungen übernehmen',
          farbe: Buttonfarbe.gruen,
          onPressed: () {},
        ),
      ]),
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Angemeldete Gruppenleiter',
                style: Schrift.ueberschrift())), Teiler(), Rahmen(header: TopHeader()) // TODO Rahmen durch Column mit Gruppenleitern ersetzen
      ]),
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Kinder Anmeldungen', style: Schrift.ueberschrift()))
      ]),
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Nachträglich zum Termin anmelden',
                style: Schrift.ueberschrift())),
        Teiler(),
        Placeholder(fallbackHeight: 70),
        Teiler(),
        Textfeld(text: 'Kommentar', hintText: 'optionaler Kommentar')
      ])
    ]);
  }
}
