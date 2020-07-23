// -------------------------------- Imports ---------------------------------

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'gui_konstanten.dart';

/// Topleiste
/// Enthält Suchfunktion und Einstellungen
class Topleiste extends StatefulWidget {
  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _TopleisteState();
}

class _TopleisteState extends State<Topleiste> {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool     fieldExpanded = false; // Ist die Suchleiste sichtbar?
  Duration duration;              // Animationsdauer
  // @formatter:on

  // ------------------------------ Eventhandler ------------------------------

  void _buttonPressed() {
    setState(() {
      fieldExpanded = !fieldExpanded;
    });
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    duration = Duration(milliseconds: 80); // Animationsdauer
    AnimatedContainer schatten = AnimatedContainer(
        duration: duration,
        child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, fieldExpanded ? 0.18 : 0),
                  offset: Offset(3, 3))
            ])));
    return Stack(children: [
      Row(children: [
        schatten,
        Expanded(
            child: SizedBox(
                height: 50,
                child: Stack(children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedContainer(
                          curve: Curves.easeInQuart,
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 0.03,
                                    color: Color.fromRGBO(0, 0, 0, 0.18),
                                    offset: Offset(3, 3))
                              ],
                              border: Border(
                                top: BorderSide(width: 1, color: Farben.grau),
                                bottom:
                                    BorderSide(width: 1, color: Farben.grau),
                              )),
                          width: fieldExpanded
                              ? MediaQuery.of(context).size.width
                              : 0,
                          duration: !fieldExpanded
                              ? Duration(milliseconds: 50) // Animationsdauer
                              : duration,
                          child: _LeistenTextfield()))
                ]))),
        schatten
      ]),
      Row(children: [
        _LeistenButton(
            onPressed: _buttonPressed,
            fieldExpanded: fieldExpanded,
            left: true,
            duration: duration,
            svg: svgIcons['einstellungen']),
        Expanded(child: Container()),
        _LeistenButton(
            onPressed: _buttonPressed,
            fieldExpanded: fieldExpanded,
            left: false,
            duration: duration,
            svg: svgIcons['lupe'])
      ])
    ]);
  }
}

/// Textfeld der Suchleiste
class _LeistenTextfield extends StatefulWidget {
  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _LeistenTextfieldState();
}

class _LeistenTextfieldState extends State<_LeistenTextfield> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontFamily: appFont, fontSize: 20),
      strutStyle: StrutStyle(height: 1.6),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
          hintText: 'Suchen',
          hintStyle: TextStyle(fontFamily: appFont, color: Farben.grau, fontSize: 20),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}

/// Buttons der Topleiste (Einstellungen und Suchfunktion)
class _LeistenButton extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final GestureTapCallback onPressed;     // Eventhandler
  final bool               fieldExpanded; // Ist das Suchfeld sichtbar?
  final bool               left;          // Ist der Button links oder rechts auf der Leiste?
  final Duration           duration;      // Animationsdauer
  final String             svg;           // Dateipfad des SVG-Icons
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  _LeistenButton({this.onPressed,
    this.fieldExpanded = false,
    this.left = true,
    this.duration,
    @required this.svg});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<_LeistenButton> {
  // ------------------------------- Variablen --------------------------------

  BorderRadius borderRadius; // abgerundete Kanten

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    // @formatter:off
    borderRadius = BorderRadius.only(
        bottomLeft:  Radius.circular(!widget.left && widget.fieldExpanded ? 0 : 10),
        topLeft:     Radius.circular(!widget.left && widget.fieldExpanded ? 0 : 10),
        bottomRight: Radius.circular( widget.left && widget.fieldExpanded ? 0 : 10),
        topRight:    Radius.circular( widget.left && widget.fieldExpanded ? 0 : 10));
    // @formatter:on

    return AnimatedContainer(
        child: Material(
            color: Colors.transparent,
            borderRadius: borderRadius,
            child: InkWell(
                borderRadius: borderRadius,
                onTap: widget.onPressed,
                child: Stack(children: [
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(widget.svg,
                          color: Farben.blaugrau, height: 23))
                ]))),
        duration: widget.duration,
        curve: Curves.easeOutExpo,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Farben.weiss,
            border: Border.all(width: 1, color: Farben.blaugrau),
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))
            ]
        )
    );
  }
}
