import 'package:dipl_app/frontend/pages/gui_einstellungen.dart';
import 'package:dipl_app/backend/requests/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'gui_konstanten.dart';
import 'gui_text.dart';

/// Topleiste
/// Enthält Suchfunktion und Einstellungen
class Topleiste extends StatefulWidget {

  // ------------------------------- Variablen --------------------------------

  final TextEditingController controller; // Controller für Suchfeld in Topleiste
  final ValueChanged<String> onChanged;
  // ------------------------------ Konstruktor -------------------------------

  Topleiste({this.controller, this.onChanged});

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

  void _searchButtonPressed() {
    setState(() {
      fieldExpanded = !fieldExpanded;
    });
  }

  void _settingsButtonPressed() {
    requestUser().then((user) => Navigator.push(context, MaterialPageRoute(builder: (context) => EinstellungenPage(user: user))));
  }

  // --------------------------------- Build ----------------------------------
// @formatter:off
  @override
  Widget build(BuildContext context) {
    duration = Duration(milliseconds: 80); // Animationsdauer
    AnimatedContainer schatten = AnimatedContainer(
        duration: duration,
        child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, fieldExpanded ? 0.18 : 0),
                  offset: Offset(3, 3))])));
    return Stack(children: [
      Align(alignment: Alignment.center, child:
    	Row(children: [schatten,
        Expanded(
            child: SizedBox(
                height: 40, child: Stack(children: [
                  Align(
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                          curve: Curves.easeInQuart,
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 0.03,
                                    color: Color.fromRGBO(0, 0, 0, 0.18),
                                    offset: Offset(3, 3))],
                                    border: Border(
                                      top: BorderSide(width: 1, color: Farben.grau),
                                      bottom: BorderSide(width: 1, color: Farben.grau))),
                          width: fieldExpanded ?
                          MediaQuery.of(context).size.width : 0, duration: !fieldExpanded
                              ? Duration(milliseconds: 50) : duration,
                          child: _LeistenTextfield(controller: widget.controller, onChanged: widget.onChanged)))]))),
        schatten])),
      Row(children: [
        _LeistenButton(
            onPressed: _settingsButtonPressed,
            fieldExpanded: fieldExpanded,
            left: true,
            duration: duration,
            svg: SVGicons.einstellungen),
        Expanded(child: Container()),
        _LeistenButton(
            onPressed: _searchButtonPressed,
            fieldExpanded: fieldExpanded,
            left: false,
            duration: duration,
            svg: SVGicons.lupe)])]);
  } // @formatter:on
}

/// Textfeld der Suchleiste
class _LeistenTextfield extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final TextEditingController controller; // Controller für Suchfeld in Topleiste
  final ValueChanged<String> onChanged;
  // ------------------------------ Konstruktor -------------------------------

  _LeistenTextfield({this.controller, this.onChanged});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _LeistenTextfieldState();
}

class _LeistenTextfieldState extends State<_LeistenTextfield> {

  @override
  // --------------------------------- Build ----------------------------------
// @formatter:off
  @override
  Widget build(BuildContext context) {
    print('#################### _LeistenTextfieldState: ${widget.controller}');
    return TextField(controller: widget.controller ?? TextEditingController(), onChanged: widget.onChanged ?? (s) {},
        style: Schrift(
            fontWeight: FontWeight.w400, fontSize: 20, color: Farben.schwarz),
        strutStyle: StrutStyle(height: 1.6),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5, right: 5),
            hintText: 'Suchen',
            hintStyle: Schrift(
                fontWeight: FontWeight.w400, color: Farben.grau, fontSize: 20),
            border: OutlineInputBorder(borderSide: BorderSide.none)));
  } // @formatter:on
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

  // @formatter:off
  _LeistenButton({
    this.onPressed,
    this.fieldExpanded = false,
    this.left          = true,
    this.duration,
    @required this.svg});
  // @formatter:on

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
// @formatter:off
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
                          color: Farben.blaugrau, height: 23))]))),
        duration: widget.duration,
        curve: Curves.easeOutExpo,
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Farben.weiss,
            border: Border.all(width: 1, color: Farben.blaugrau),
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))]));
  } // @formatter:off
}

// TODO entfernen
// --------------------------------- SuchFunktion ----------------------------------


