import 'package:dipl_app/backend/objects.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/pages/gui_admin_terminuebersicht.dart';
import 'package:dipl_app/backend/objects.dart' as objects;
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter_svg/svg.dart';

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TempButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => testeRegistrierteUser())),
          text: 'testeRegistrierteUser'),
      TempButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => testeSortierMenu())),
          text: 'testeSortierButton'),
    ]);
  }

  Widget testeSortierMenu() {
    return TempSeite(children: [SortierMenu()]);
  }

  Widget testeRegistrierteUser() {
    return TempSeite(children: [
      UserRahmen(objects.User(
          01,
          'Jon',
          'Doe',
          'JonDoe@gmail.com',
          '1210',
          'New York',
          UserTyp(1259, 'User', null),
          'Die Coolen Spritzen',
          null,
          null,
          true))
    ]);
  }
}

class UserRahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final User user;

  // ------------------------------ Konstruktor -------------------------------

  const UserRahmen(this.user); // @formatter:off

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _UserRahmenState();
}

class _UserRahmenState extends State<UserRahmen>
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
// @formatter:off
  Widget _buildChildren(BuildContext context, Widget child) {
    _childrenTop = [];
    _childrenTop.addAll([
      Stack(children: [Container(width: double.infinity, padding: EdgeInsets.only(left: 68, right: 10, top: 12, bottom:10), child:
      Row(children: [
        Text('${widget.user.vorname} ${widget.user.nachname}', style: Schrift.ueberschrift()),
        Expanded(child: Container()),
        Kreuz(groesse: 0.5, offen: _isExpanded),
        ])),//TODO Animation muss noch gemacht werden.
      AnimatedContainer(duration: Duration(milliseconds: 500),height: 52, width: 52, color: Colors.red)]),
      ClipRect(child: Align(heightFactor: _heightFactor.value, child: child))]);
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => _handleTap(),
        child: Rahmen(padding: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            children: _childrenTop));
  } // @formatter:on

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
// @formatter:off
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed ? null : Container(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: EdgeInsets.only(left: 11, top: 10, right: 10, bottom: 4),
                    child: Column(children: [
                  SizedBox(height: 5),
                  Row(children: [
                    Container(width: 20, child: Center(child: SvgPicture.asset(SVGicons.email, height: 20,width: 20, color: Farben.blaugrau))),
                    Container(width: 10),
                    Text('${widget.user.email}', style: Schrift())]),
                  SizedBox(height: 5),
                  Row(children: [
                    Container(width: 20, child: Center(child: SvgPicture.asset(SVGicons.berechtigung, height: 25, width: 25, color: Farben.blaugrau))),
                    Container(width: 10),
                    Text('${widget.user.typ.name}', style: Schrift())]),
                  SizedBox(height: 5),
                  Row(children: [
                    Container(width: 20, child: Center(child: SvgPicture.asset(SVGicons.mehrereBenutzer, height: 20,width: 20,color: Farben.blaugrau))),
                    Container(width: 10),
                    Text('${widget.user.jugendgruppe}',style: Schrift())]),
                  SizedBox(height: 5),
                  Row(children: [Container(width: 20, child: Center(child: SvgPicture.asset(SVGicons.standort, height: 19, width: 25, color: Farben.blaugrau))),
                    Container(width: 10),
                    Text('${widget.user.plz} ${widget.user.ort}',style: Schrift())]),
                  SizedBox(height: 5),
                  Row(children: [
                    Container(width: 20, child: Center(child: SvgPicture.asset(SVGicons.verknuepft, height: 18, width: 18, color: Farben.blaugrau))),
                    Container(width: 10),
                    Text('${widget.user.vorname} ${widget.user.nachname}', style: Schrift())]),
                  SizedBox(height: 15),
                Button(onPressed: (){}, svg: SVGicons.bearbeiten, text: 'User bearbeiten', farbe: Buttonfarbe.rot, gefuellt: false),
                Button(onPressed: (){}, svg: SVGicons.schluessel, text: 'Passwort zurücksetzen', farbe: Buttonfarbe.rot, gefuellt: false),
                Button(onPressed: (){}, svg: SVGicons.loschen,    text: 'User löschen', farbe: Buttonfarbe.rot, gefuellt: true)])))));
 } // @formatter:on

  // -------------------------------- Dispose ---------------------------------

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
