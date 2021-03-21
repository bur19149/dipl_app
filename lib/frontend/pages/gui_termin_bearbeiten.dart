import 'package:dipl_app/backend/objects.dart' as objects;
import 'package:dipl_app/backend/pruefungen.dart';
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

//@foramtter:off
  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      Rahmen(children: [
        Align(alignment: Alignment.centerLeft,
            child: Text('Termin bearbeiten', style: Schrift.ueberschrift())),
        Teiler(),
        Textfeld(text: 'Termin Name', hintText: 'Name des Termins',pruefung: nichtLeer),
        Teiler(),
        Textfeld(text: 'Beschreibung',
            hintText: 'Terminbeschreibung',
            multiline: true,
            value: beschreibung,
            pruefung: nichtLeer,
              ),
        Teiler(),
        Textfeld(text: 'Ort', hintText: 'Wohnort', pruefung: pruefeOrt,),
        Teiler(),
        Textfeld(text: 'Anzahl freier Plätze',
          keyboardType: TextInputType.number,
            hintText: 'Platzanzahl',
            bottomHintText: '0 um Beschränkung aufzuheben',
            pruefung: sindZahlen,),
        Teiler(),
        Textfeld(text: 'Datum/Uhrzeit von', dateTime: true),
        Teiler(),
        Textfeld(text: 'Datum/Uhrzeit bis', dateTime: true),
        Teiler(),
        ExpandableInnerRahmen(children: [
          Textfeld(text: 'Öffentlich ab', dateTime: true),
          Teiler(),
          Textfeld(text: 'Öffentlich bis', dateTime: true)]),
        Button(text: 'Termin löschen', farbe: Buttonfarbe.rot,
          onPressed: () {
          //TODO
          }),
        Teiler(buttonTrenner: true),
        Button(text: 'Abbrechen',
          onPressed: () {
          //TODO
          }),
        Teiler(buttonTrenner: true),
        Button(text: 'Änderungen übernehmen',
          farbe: Buttonfarbe.gruen,
          onPressed: () {
          //TODO
          })]),
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(alignment: Alignment.centerLeft,
            child: Text('Angemeldete Gruppenleiter',
                style: Schrift.ueberschrift())),
        Teiler(),
        Rahmen(header: TopHeader())]), // TODO Rahmen durch Column mit Gruppenleitern ersetzen
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(alignment: Alignment.centerLeft,
            child: Text('Kinder Anmeldungen', style: Schrift.ueberschrift()))]),
      Teiler(rahmenTrenner: true),
      Rahmen(children: [
        Align(alignment: Alignment.centerLeft,
            child: Text('Nachträglich zum Termin anmelden',
                style: Schrift.ueberschrift())),
        Teiler(),
        Placeholder(fallbackHeight: 70),
        Teiler(),
        Textfeld(text: 'Kommentar', hintText: 'optionaler Kommentar')])]);
  } //@foramtter:on
}

class KinderAnmeldungen extends StatelessWidget { // ignore: must_be_immutable

  List<objects.AntwortTermin> antwortTermine = [];

  KinderAnmeldungen(List<objects.AntwortTermin> teilnehmerListe) {
    for(var teilnehmer in teilnehmerListe)
      if(teilnehmer.user.parent!=null)
        antwortTermine.add(teilnehmer);
    antwortTermine.sort((a, b) => '${a.user.vorname} ${a.user.nachname}'.compareTo('${b.user.vorname} ${b.user.nachname}'));
    // TODO eventuell a & b tauschen
  }

  // @formatter:off
  @override
  Widget build(BuildContext context) {
    return Rahmen(children: [
      Align(child: Text('Kinder Anmeldungen', style: Schrift.ueberschrift()), alignment: Alignment.centerLeft),
      Container(width: double.infinity,
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          child: Column(children: [
            Container(width: double.infinity, height: 1, color: Farben.rahmenFarbe),
            Container(padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(children: [
                  Expanded(child: Text('Name', style: Schrift())),
                  Expanded(child: Text('Antwort', style: Schrift()))])),
            Container(width: double.infinity, height: 1, color: Farben.rahmenFarbe),
            ..._fuelleTabelle() ]))]);
  } //@formatter:off

  List<Widget> _fuelleTabelle() {
    List<Widget> zeile = [];
    for (var antwortTermin in antwortTermine)
      if (antwortTermin.antwortUser != null)
        zeile.add(_fuelleZeile(antwortTermin));
    return zeile;
  }
// @formatter:off
  Widget _fuelleZeile(objects.AntwortTermin antwortTermin) {
    return Container(padding: EdgeInsets.only(top: 10),child: Row(
        children: [
          Expanded(child: Text('${antwortTermin.user.vorname} ${antwortTermin.user.nachname}', style: Schrift())),
          Expanded(child: Text('${antwortTermin.antwortUser.name}', style: Schrift()))]));
  }
}
// @formatter:on