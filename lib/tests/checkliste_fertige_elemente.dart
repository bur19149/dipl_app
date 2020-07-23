import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_topLeiste.dart';
import 'package:flutter/material.dart';

class Checkliste extends StatefulWidget {
  final List<Widget> fertig = [
    // @formatter:off
    ListenText('ToggleButton', widget: CustomToggleButton(onTap: () {})),
    ListenText('Kreuz',        widget: Kreuz()),
    // @formatter:on
  ];

  final List<Widget> unfertig = [
    // @formatter:off
    ListenText('Topleiste', anmerkung: 'fast fertig'),
    ListenText('Navigationsleiste', anmerkung: 'fast fertig'),
    ListenText('SVG-Icons', anmerkung: 'teilweise importiert'),
    ListenText('Rahmen', anmerkung: 'fast fertig'),
    ListenText('Texte', anmerkung: 'Überarbeitung nötig'),
    ListenText('Standard-Button', anmerkung: 'angefangen')

    // @formatter:on
  ];

  @override
  State<StatefulWidget> createState() => _ChecklisteState();
}

class _ChecklisteState extends State<Checkliste> {
  @override
  Widget build(BuildContext context) {
    return PageView(children: [
      SafeArea(
          child: Stack(children: [
        Scaffold(
            body: ListView(
                padding:
                    EdgeInsets.only(left: 15, right: 30, top: 170, bottom: 40),
                children: widget.unfertig)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: 190,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 100),
                  Color.fromRGBO(255, 255, 255, 0)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)))),
        Positioned(
            top: 50,
            left: 15,
            child: Material(
              child: Text(
                'unfertige Elemente',
                style: TextStyle(fontSize: 40),
              ),
              color: Colors.transparent,
            ))
      ])),
      SafeArea(
          child: Stack(children: [
        Scaffold(
            body: ListView(
                padding:
                    EdgeInsets.only(left: 15, right: 30, top: 170, bottom: 40),
                children: widget.fertig)),
        Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: 190,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(255, 255, 255, 100),
                  Color.fromRGBO(255, 255, 255, 0)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)))),
        Positioned(
            top: 50,
            left: 15,
            child: Material(
              child: Text(
                'fertige Elemente',
                style: TextStyle(fontSize: 40),
              ),
              color: Colors.transparent,
            ))
      ]))
    ]);
  }
}

class ListenText extends StatelessWidget {
  final String text, anmerkung;
  final Widget widget;

  const ListenText(this.text, {this.widget, this.anmerkung});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(children: [
          Container(
              height: 10,
              width: 10,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black)),
          SizedBox(
            width: 15,
          ),
          Text(text, style: TextStyle(fontSize: 25)),
          SizedBox(
            width: 15,
          ),
          Text(anmerkung != null ? '($anmerkung)' : ''),
          Expanded(child: Container()),
          Container(
              height: 31,
              width: 31,
              child: FittedBox(child: widget != null ? widget : Container()))
        ]));
  }
}
