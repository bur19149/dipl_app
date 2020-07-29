// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'gui_konstanten.dart';
import 'gui_buttons.dart';

/// Standard-Textfeld mit Überschrift
class Textfeld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String    text;        // Überschrift des Textfeldes
  final String    hintText;    // Hinweistext innerhalb des Textfeldes
  final TextStyle headerStyle; // Formatierung der Überschrift des Textfeldes
  final int       maxLength;   // maximale Anzahl Zeichen innerhalb des Textfeldes
  // @formatter:off

  // ------------------------------ Konstruktor -------------------------------

  const Textfeld(
      {this.text = 'Header', this.hintText = 'Header', this.maxLength = 64, this.headerStyle = const Schrift.ueberschrift()});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _TextfeldState();
}

class _TextfeldState extends State<Textfeld> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.text,
                  style: widget.headerStyle))),
      SizedBox(height: 7),
      _Feld(
        hintText: widget.hintText,
        maxLength: widget.maxLength,
      )
    ]);
  }
}

/// Standard-Textfeld
class _Feld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String hintText;  // Hinweistext innerhalb des Textfeldes
  final int    maxLength; // maximale Anzahl Zeichen innerhalb des Textfeldes
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const _Feld({this.hintText, this.maxLength = 64});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _FeldState();
}

class _FeldState extends State<_Feld> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,child: Theme(
        data: ThemeData(primaryColor: Farben.blaugrau),
        child: TextFormField(
            style: Schrift.ueberschrift(),
            maxLength: widget.maxLength,
            strutStyle: StrutStyle(height: 1.3),
            decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                hintText: widget.hintText,
                hintStyle: Schrift(color: Farben.grau),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 1, color: Farben.grau))))));
  }
}

class DateTimeTextfeld extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DateTimeTextfeldState();
}

class _DateTimeTextfeldState extends State<DateTimeTextfeld> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Button(
          onPressed: () => setState(() {
                expanded = !expanded;
              })),
      Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Farben.rahmenFarbe, width: 1)),
          child: Stack(children: [
            _Feld(),
            Align(
                alignment: Alignment(1, expanded ? 30 : 0),
                child: AnimatedContainer(
                  width: expanded ? 200 : 47,
                  height: expanded ? 500 : 44,
                  color: Farben.blau,
                  duration: Duration(seconds: 1),
                )),
          ]))
    ]);
  }
}
