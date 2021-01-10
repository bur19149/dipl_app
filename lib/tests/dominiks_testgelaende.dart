import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:dipl_app/frontend/pages/gui_termin_bearbeiten.dart';
import 'package:dipl_app/frontend/pages/gui_terminuebersicht.dart';
import 'package:dipl_app/frontend/pages/gui_user_erstellen.dart';
import 'package:dipl_app/frontend/pages/gui_einstellungen.dart';
import 'package:dipl_app/frontend/gui_eingabefelder.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_topLeiste.dart';
import 'package:dipl_app/backend/requests/debug.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_pages.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';

class DominiksTestgelaende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DominiksTestgelaendeState();
}

class _DominiksTestgelaendeState extends State<DominiksTestgelaende> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      // @formatter:off
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteMenu())),            text: 'Menüleisten-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteWidgets())),         text: 'Widgets-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteSchriftarten())),    text: 'Schriftarten-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteTopleiste())),       text: 'Topleisten-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminUebersichtPage())), text: 'Terminübersicht-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteDropDownButton())),  text: 'Dropdown-Button-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EinstellungenPage())),    text: 'Teste Einstelungen-Seite'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminBearbeitenPage())), text: 'Teste Termin-bearbeiten-Seite'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserErstellenPage())),    text: 'Teste User-erstellen-Seite')
      // @formatter:on
    ]);
  }
}

class TesteDropDownButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteDropDownButtonState();
}

class _TesteDropDownButtonState extends State<TesteDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      Button(onPressed: () {}),
      DropdownButton(
        items: [DropdownMenuItem(child: Text('Hallo'))],
        onChanged: (value) {}),
      Container(
        height: 1000,
      )]);
  }
}

class TesteTopleiste extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteTopleisteState();
}

class _TesteTopleisteState extends State<TesteTopleiste> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      Container(
          //decoration: BoxDecoration(border: Border.all(color: Farben.schwarz)),
          child: Topleiste())]);
  }
}

class TesteWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteWidgetsState();
}

class _TesteWidgetsState extends State<TesteWidgets> {
  bool expanded = false;
  Wrapper dateTime;

  void expand(bool offen) {
    setState(() {
      expanded = offen;
    });
  }

  @override
  void initState() {
    dateTime = Wrapper();
    super.initState();
  }
// @formatter:off
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: ListView(
                padding: EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 50),
                children: [
                  Rahmen(header: TopHeader()), Teiler(rahmenTrenner: true),
                  ExpandableRahmen(
                      childrenTop: [Text('Hallo')],
                      childrenBottom: [Text('Hallo Welt')]),
                  SizedBox(height: 50),
                  Button(text: 'print Datum', onPressed: () => print('Datum: [${dateTime.value}]')),
                  Rahmen(children: [
                    Textfeld(dateTime: true, text: 'Datum/Uhrzeit von', value: dateTime)]),
                  SizedBox(height: 50),
                  Container(height: 100, color: Farben.blau),
                  Button(text: 'Terminliste', onPressed: () async {
                    print('1##################');
                    var liste = requestAlleTermine();
                    printListe(await liste);
                    print('2##################');
              })])));
  }
}// @formatter:on

class TesteMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteMenuState();
}

class _TesteMenuState extends State<TesteMenu> {
  bool admin = true;
// @formatter:off
  @override
  Widget build(BuildContext context) {
    return Menuleiste(
        admin: admin,
        scaffold: Scaffold(
            body: Center(
                child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        admin = !admin;
                      });
                    },
                    child: Text('change Menu')))));
  }// @formatter:on
}

class TesteSchriftarten extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteSchriftartenState();
}
// @formatter:off
class _TesteSchriftartenState extends State<TesteSchriftarten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: ListView(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
                  children: [
                    Text('TextfeldText', style: Schrift()),
                    Container(color: Farben.rot,
                        child: Text('Uberschrift', style: Schrift.titel())),
                    Text('UnterUberschrift', style: Schrift.ueberschrift()),
                    Container(color: Farben.blau,
                        child: Text('WeisseDickeUberschrift',
                            style: Schrift.titelFooter()))]))));
  }// @formatter:on
}

class CustomDropDownButton extends StatefulWidget {
  @override
  _CustomDropDownButtonState createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  bool _istAusgeklappt = false;
  BoxBorder _border = Border.all(color: Farben.rahmenFarbe, width: 1);
  Duration _animationDuration = Duration(milliseconds: 200);
// @formatter:off
  @override
  Widget build(BuildContext context) {
    double radius = _istAusgeklappt ? 0 : 10;
    return Container(
        width: double.infinity,
        height: 40,
        child: Stack(children: [
          AnimatedContainer(
              duration: _animationDuration,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.amber, //TODO white
                  border: _border,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius)))),
          Align(alignment: Alignment.centerRight,
              child: AnimatedContainer(
                duration: _animationDuration,
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.red, //TODO white
                    border: _border,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(radius))),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 15,
                                    width: 15,
                                    color: Colors.green) //TODO Platzhalter für die Animation
                    )]))),
          AnimatedContainer(
              duration: _animationDuration,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                //      color: istAusgeklappt ? Colors.black : Colors.purple,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(radius),
                      bottomRight: Radius.circular(radius))),
              child: InkWell(
                onTap: () => handleDropDown(),
                // child: Container(
                //   height: double.infinity,
                //   width: double.infinity,
                // ),
              ))]));
  }// @formatter:on

  handleDropDown() {
    setState(() {
      _istAusgeklappt = !_istAusgeklappt;
    });
  }
}