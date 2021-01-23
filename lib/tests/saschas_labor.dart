import 'package:dipl_app/frontend/pages/gui_admin_terminuebersicht.dart';
import 'package:dipl_app/backend/objects.dart' as objects;
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dipl_app/main.dart';

class KinderAnmeldungen extends StatelessWidget {

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
class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}
// @formatter:off
class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TempButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => testeKinderAnmeldungen())), text: 'testeKinderAnmeldungen'),
      TempButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => testeRegistrierteUser())), text: 'testeRegistrierteUser'),
      TempButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => testeSortierMenu())), text: 'testeSortierButton')]);
  }
// @formatter:on
  Widget testeKinderAnmeldungen() {
    return TempSeite(children: [KinderAnmeldungen(null)]);
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
          objects.UserTyp(1259, 'User', null),
          'Die Coolen Spritzen',
          null,
          null,
          true))]);
  }
}

class UserRahmen extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final objects.User user;

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
  Duration            _duration;
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
    _duration     = Duration(milliseconds: 200);
    _controller   = AnimationController(duration: _duration, vsync: this);
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
        Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 68, right: 10, top: 12, bottom: 10),
            child: Row(children: [
              Text('${widget.user.vorname} ${widget.user.nachname}', style: Schrift.ueberschrift()),
              Expanded(child: Container()),
              Kreuz(groesse: 0.5, offen: _isExpanded)])),
      ClipRect(child: Align(heightFactor: _heightFactor.value, child: child))]);
    return Rahmen(padding: EdgeInsets.all(0), children: _childrenTop);
  } // @formatter:on

  // @formatter:off
  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return InkWell(
        splashColor:    Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => _handleTap(),
      child: Stack(children: [
        AnimatedBuilder(
          animation: _controller.view,
          builder: _buildChildren,
          child: closed ? null : Container(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: EdgeInsets.only(left: 11, top: 10, right: 10, bottom: 4),
                    child:   Column(children: [
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
                Button(onPressed: (){}, svg: SVGicons.bearbeiten, text: 'User bearbeiten',       farbe: Buttonfarbe.rot, gefuellt: false),
                Button(onPressed: (){}, svg: SVGicons.schluessel, text: 'Passwort zurücksetzen', farbe: Buttonfarbe.rot, gefuellt: false),
                Button(onPressed: (){}, svg: SVGicons.loschen,    text: 'User löschen',          farbe: Buttonfarbe.rot, gefuellt: true)]))))),
      AnimatedContainer(
        child: Center(child: Text("012",style: Schrift())),
          duration: _duration,
          height: 54.5,
          width:  53,
          decoration: BoxDecoration(
              border: Border.all(color: Farben.rahmenFarbe, width: 1),
              borderRadius:  BorderRadius.only(
                  topLeft:     Radius.circular(9.4),
                  bottomLeft:  Radius.circular(_isExpanded ? 0  : 9.5),
                  bottomRight: Radius.circular(_isExpanded ? 10 : 0))))]));
  } // @formatter:on

  // -------------------------------- Dispose ---------------------------------

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
