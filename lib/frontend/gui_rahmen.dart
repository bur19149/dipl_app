// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'gui_buttons.dart';
import 'gui_pages.dart';

/// ausklappbarer innerer Rahmen
/// wird beim Termin erstellen und bearbeiten verwendet
class ExpandableInnerRahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final List<Widget> children; // Rahmeninhalt

  // ------------------------------ Konstruktor -------------------------------

  const ExpandableInnerRahmen({this.children});

  // ------------------------------- createState ------------------------------

  @override
  _ExpandableInnerRahmenState createState() => _ExpandableInnerRahmenState();
}

class _ExpandableInnerRahmenState extends State<ExpandableInnerRahmen>
    with SingleTickerProviderStateMixin {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool                _isExpanded;   // Ist der Rahmen sichtbar/ausgefahren?
  AnimationController _controller;   // Controller des Widgets / der Animation, definiert die Animationszeit
  Animation<double>   _heightFactor; // definiert die Animation (Kurve usw.)
  // @formatter:on

  // ------------------------------ Eventhandler ------------------------------

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  // -------------------------------- initState -------------------------------

  @override
  void initState() { // @formatter:off
    _controller   = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    _isExpanded   = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
    super.initState();
  } // @formatter:on

  // --------------------------------- Build ----------------------------------

  Widget _buildChildren(BuildContext context, Widget child) {
    return Column(children: [
      Row(children: [
        Expanded(child: Container()),
        Text('Öffentlich', style: Schrift()),
        SizedBox(width: 30),
        CustomToggleButton(
          size: 70,
          value: false,
          onTap: () => _handleTap(),
        ),
        Expanded(child: Container())
      ]),
      Teiler(),
      AnimatedOpacity(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
          opacity: _isExpanded ? 1 : 0,
          child: ClipRect(
              child: Align(heightFactor: _heightFactor.value, child: child))),
      Teiler(height: _isExpanded ? 20 : 0)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : Container(
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Rahmen(
                        children: widget.children ?? [], shadow: false))));
  }
}

/// ausklappbarer Rahmen
/// wird bei der Terminübersicht verwendet (Terminkarten)
class ExpandableRahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String       header;         // Titel/Überschrift des Rahmens
  final String       bottomHeader;   // Text in der Fußleiste
  final List<Widget> childrenTop;    // immer sichtbarer Teil des Rahmens
  final List<Widget> childrenBottom; // ein- und ausblendbarer Teil des Rahmens
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const ExpandableRahmen( // @formatter:off
      {this.header        = 'Header',
      this.bottomHeader   = 'Header',
      this.childrenTop    = const [],
      this.childrenBottom = const []});
  // @formatter:on

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _ExpandableRahmenState();
}

class _ExpandableRahmenState extends State<ExpandableRahmen>
    with SingleTickerProviderStateMixin {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool                _isExpanded;     // Ist der Rahmen sichtbar/ausgefahren?
  AnimationController _controller;     // Controller des Widgets / der Animation, definiert die Animationszeit
  Animation<double>   _heightFactor;   // definiert die Animation (Kurve usw.)
  List<Widget>        _childrenTop;    // immer sichtbarer Teil des Rahmens
  // @ormatter:on

  // ------------------------------ Eventhandler ------------------------------

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
  }

  // -------------------------------- initState -------------------------------

  @override
  void initState() { // @formatter:off
    _controller   = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
    _isExpanded   = PageStorage.of(context)?.readState(context) ?? false;
    if (_isExpanded) _controller.value = 1.0;
    super.initState();
  } // @formatter:on

  // --------------------------------- Build ----------------------------------

  Widget _buildChildren(BuildContext context, Widget child) {
    _childrenTop = [];
    _childrenTop.addAll([
      Row(children: [
        Text(widget.header, style: Schrift.ueberschrift()),
        Expanded(child: Container()),
        Kreuz(groesse: 0.5, offen: _isExpanded),
        SizedBox(width: 5)
      ]),
      SizedBox(height: 10),
      ...widget.childrenTop,
      ClipRect(child: Align(heightFactor: _heightFactor.value, child: child))
    ]);
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => _handleTap(),
        child: Rahmen(
            header: BottomHeader(header: widget.bottomHeader),
            children: _childrenTop));
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;

    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : Container(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Column(children: widget.childrenBottom))));
  }

  // -------------------------------- Dispose ---------------------------------

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Standard-Rahmen
class Rahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final List<Widget> children; // Inhalt des Rahmens
  final Widget       header;   // optionaler Header des Rahmens
  final bool         shadow;   // Hat der Rahmen einen Schatten?
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const Rahmen({this.children = const [], this.header, this.shadow = true});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _RahmenState();
}

class _RahmenState extends State<Rahmen> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    Widget topWidget = Container(); // optionaler Header (oben)
    Widget bottomWidget = Container(); // optionaler Header (unten)

    // Prüfungen: Existiert Header? Wenn ja, welcher?

    if (widget.header is LoginHeader || widget.header is TopHeader)
      topWidget = widget.header;
    if (widget.header is BottomHeader) bottomWidget = widget.header;

    // setze Rahmeninhalt zusammen

    List<Widget> children = [];
    children.addAll([
      topWidget,
      Padding(
          padding: EdgeInsets.only(bottom: 25, top: 20, left: 11, right: 11),
          child: Column(children: widget.children)),
      bottomWidget
    ]);

    // Build

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              widget.shadow ? BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3)) : BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0))
            ],
            color: Farben.weiss,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.rahmenFarbe, width: 1)),
        child: Column(children: children));
  }
}

/// Rahmen zur Darstellung von Terminen
/// wird bei der Terminübersicht verwendet (Terminkarten)
class TerminRahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final List<Widget> children; // Inhalt des Rahmens

  // ------------------------------ Konstruktor -------------------------------

  const TerminRahmen({this.children = const []});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _TerminRahmenState();
}

class _TerminRahmenState extends State<TerminRahmen> {
  // ------------------------------- Variablen --------------------------------

  bool _offen = false; // Ist der Rahmen gerade geöffnet?

  // ------------------------------ Eventhandler ------------------------------

  void _oeffnen() {
    setState(() {
      _offen = !_offen;
    });
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: _oeffnen,
        child: Stack(children: [
          Rahmen(children: widget.children, header: BottomHeader()),
          Positioned(
              right: 15,
              top: 15,
              child: Kreuz(
                offen: _offen,
                groesse: 0.6,
              ))
        ]));
  }
}

/// Rahmen der Loginseite
class LoginRahmen extends StatelessWidget {
  // ------------------------------- Variablen --------------------------------

  final List<Widget> children; // Inhalt des Rahmens

  // ------------------------------ Konstruktor -------------------------------

  const LoginRahmen({this.children});

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Rahmen(
      header: LoginHeader(),
      children: children,
    );
  }
}

/// Header der Loginseite
class LoginHeader extends StatelessWidget {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.only(left: 11),
        decoration: BoxDecoration(
            color: Farben.rot,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.5), topRight: Radius.circular(9.5))),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Anmelden', style: Schrift.titel())));
  }
}

/// Fußleiste
/// wird bei Terminkarten verwendet
class BottomHeader extends StatelessWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String header; // Headertext
  final Color  color;  // Farbe des Headers
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const BottomHeader({this.header = 'Header', this.color = Farben.gruen});

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(header, style: Schrift.titelFooter())),
        height: 45,
        padding: EdgeInsets.only(left: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9.5),
                bottomRight: Radius.circular(9.5))));
  }
}

/// einfacher Header für Standard-Rahmen
class TopHeader extends StatelessWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final Color  farbe;     // Farbe des Headers
  final Color  rahmen;    // Farbe des Rahmens
  final Color  textfarbe; // Farbe des Headertexts
  final String text;      // Headertext
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  // @formatter:off
  const TopHeader({
    this.farbe     = Farben.blaugrau,
    this.rahmen    = Farben.rahmenFarbe,
    this.textfarbe = Farben.weiss,
    this.text      = 'TopHeader'});
  // @formatter:on

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.only(left: 11),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(text, style: Schrift.ueberschrift(color: textfarbe))),
          // TODO
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              color: farbe,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(9), topRight: Radius.circular(9)))),
      Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  top: rahmen == null
                      ? BorderSide.none
                      : BorderSide(color: rahmen))))
    ]);
  }
}

/// Kreuz welches rechts oben beim ExpandableRahmen angezeigt wird.
class Kreuz extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final bool   offen;   // Ist der Rahmen aktuell geöffnet?
  final double groesse; // Größe des Kreuzes (Multiplikator für Stanardgröße 60)
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const Kreuz({this.offen = false, this.groesse = 1});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _KreuzState();
}

class _KreuzState extends State<Kreuz> with TickerProviderStateMixin {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  AnimationController _controller;
  Duration            duration = Duration(milliseconds: 250);
  // @formatter:on

  // ---------------------------- didUpdateWidget -----------------------------

  @override
  void didUpdateWidget(Kreuz oldWidget) {
    if (widget.offen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  // -------------------------------- initState -------------------------------

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: duration,
      vsync: this,
    );
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60 * widget.groesse,
        width: 60 * widget.groesse,
        child: Align(
            alignment: Alignment.center,
            child: Stack(children: [
              RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          color: Farben.rot,
                          height: widget.offen ? 0 : 50 * widget.groesse,
                          width: 11.5 * widget.groesse,
                          duration: duration,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Farben.rot,
                          height: 11.5 * widget.groesse,
                          width: 50 * widget.groesse,
                        ))
                  ]))
            ])));
  }
}