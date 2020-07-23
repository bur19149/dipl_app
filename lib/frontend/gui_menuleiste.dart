// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Navigationsleiste
class Menuleiste extends StatefulWidget {
  // TODO scaffold ev. gegen anderes Widget austauschen
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final Scaffold scaffold; // Scaffold unter der Menüleiste
  final bool     admin;    // Ist der Nutzer ein Admin oder ein User?
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  Menuleiste({this.scaffold = const Scaffold(), this.admin = false});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _MenuleisteState();
}

class _MenuleisteState extends State<Menuleiste> {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool home         = true;  // Wird das Home-Menü gerade angezeigt?
  bool meineTermine = false; // Wird das Meine-Termine-Menü gerade angezeigt?
  bool adminMenu    = false; // Wird das Admin-Menü gerade angezeigt?
  // @formatter:on

  // ------------------------------ Eventhandler ------------------------------

  void handleHome() {
    setState(() {
      if(!home) {
        home = true;
        meineTermine = false;
      }
      adminMenu = false;
    });
  }

  void handleMeineTermine() {
    setState(() {
      if(!meineTermine) {
        home = false;
        meineTermine = true;
      }
      adminMenu = false;
    });
  }

  void showAdminMenu() {
    setState(() {
      adminMenu = !adminMenu;
    });
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      widget.scaffold,
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 90, color: Farben.blau)),
      widget.admin
          ? AnimatedPositioned(
              right: adminMenu ? 11 : -220,
              bottom: adminMenu ? 85 : -510,
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 500),
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc,
                  opacity: adminMenu ? 1 : 0,
                  child: _AdminMenu()))
          : Container(),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 90,
              padding: EdgeInsets.only(left: 11, right: 11),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: _LeistenButton(
                    text: 'Home',
                    onPressed: handleHome,
                    svg: svgIcons['haus'],
                    admin: widget.admin,
                    active: home,
                  )),
                  SizedBox(width: 10),
                  Expanded(
                      child: _LeistenButton(
                    text: 'Meine Termine',
                    onPressed: handleMeineTermine,
                    svg: svgIcons['kalender'],
                    admin: widget.admin,
                    active: meineTermine,
                  )),
                  SizedBox(width: 10),
                  widget.admin
                      ? Expanded(
                          child: _LeistenButton(
                          text: 'Admin Bereich',
                          onPressed: showAdminMenu,
                          svg: svgIcons['administrator'],
                          admin: widget.admin,
                          active: adminMenu,
                        ))
                      : Container(),
                ],
              )))
    ]));
  }
}

/// In der Navigationsleiste enthaltener Button
class _LeistenButton extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String       text;      // Textinhalt des Buttons
  final String       svg;       // Icon des Buttons
  final bool         active;    // Befindet sich der Nutzer aktuell in dem Menütab des Buttons?
  final bool         admin;     // Ist der Nutzer ein Admin oder ein User?
  final VoidCallback onPressed; // Eventhandler
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  _LeistenButton({@required this.text,
    this.onPressed,
    this.active,
    @required this.svg,
    this.admin = false});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<_LeistenButton> {
  // TODO auskommentierten Code entweder entfernen oder verwenden
  // ------------------------------- Variablen --------------------------------

  //bool _active; // Befindet sich der Nutzer aktuell in dem Menütab des Buttons?

  // -------------------------------- initState -------------------------------

  //@override
  //void initState() {
  //  _active = widget.active;
  //  super.initState();
  //}

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: RaisedButton(
            onPressed: widget.onPressed,
            child: _LeistenButtonChild(
              text: widget.text,
              admin: widget.admin,
              svg: widget.svg,
              active: widget.active,
            ),
            color: Farben.weiss,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: widget.active ? Farben.rot : Farben.blaugrau,
                    width: 1))));
  }
}

/// Buttoninhalt der Navigationsleiste
/// Enthält einen Text und ein Icon im SVG-Format
class _LeistenButtonChild extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final bool   active; // Befindet sich der Nutzer aktuell in dem Menütab des Buttons?
  final bool   admin;  // Ist der Nutzer ein Admin oder ein User?
  final String text;   // Textinhalt des Buttons
  final String svg;    // Icon des Buttons
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  _LeistenButtonChild(
      {this.admin = false, @required this.text, @required this.svg, this.active = false});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _LeistenButtonChildState();
}

class _LeistenButtonChildState extends State<_LeistenButtonChild> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return widget.admin
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(widget.svg, height: 17,
          color: widget.active ? Farben.rot : Farben.blaugrau),
      SizedBox(height: 5),
      Text(
        widget.text,
        style: TextStyle(
            fontSize: 9, color: widget.active ? Farben.rot : Farben.blaugrau),
      )
    ])
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(widget.svg, height: 17,
          color: widget.active ? Farben.rot : Farben.blaugrau),
      SizedBox(width: 7),
      Text(
        widget.text,
        style: TextStyle(
            fontSize: 12, color: widget.active ? Farben.rot : Farben.blaugrau),
      )
    ]);
  }
}

/// Admin-Bereich Untermenü
class _AdminMenu extends StatefulWidget {
  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<_AdminMenu> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _MenuBox(),
      SizedBox(
        height: 10,
      ),
      _MenuBox()
    ]);
  }
}

/// Box des Admin-Bereich Untermenüs der Menüleiste
class _MenuBox extends StatefulWidget {
  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _MenuBoxState();
}

class _MenuBoxState extends State<_MenuBox> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
            color: Farben.weiss,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.blaugrau, width: 1)));
  }
}
