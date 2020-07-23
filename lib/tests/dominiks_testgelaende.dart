import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DominiksTestgelaende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DominiksTestgelaendeState();
}

class _DominiksTestgelaendeState extends State<DominiksTestgelaende> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TempButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TesteMenu())),
          text: 'Menüleisten-Test'),
      TempButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TesteWidgets())),
          text: 'Widgets-Tests'),
      TempButton(
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => TesteSchriftarten())),
          text: 'Schriftarten-Tests')
    ]);
  }
}

class TesteWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteWidgetsState();
}

class _TesteWidgetsState extends State<TesteWidgets> {
  bool offen = false;

  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      CustomToggleButton(onTap: () {
        setState(() {
          offen = !offen;
        });
      }),
      SizedBox(height: 50),
      SvgPicture.asset(svgIcons['haus'], color: Farben.gruen, height: 50),
      SizedBox(height: 50),
      TerminRahmen(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            color: Farben.blau,
          )
        ],
      )
    ]);
  }
}

class TesteMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteMenuState();
}

class _TesteMenuState extends State<TesteMenu> {
  bool adminMenu = false, admin = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Scaffold(
          body: Center(
              child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      admin = !admin;
                    });
                  },
                  child: Text('change Menu')))),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 90, color: Farben.blau)),
      admin
          ? AnimatedPositioned(
              right: adminMenu ? 11 : -220,
              bottom: adminMenu ? 85 : -510,
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 500),
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc,
                  opacity: adminMenu ? 1 : 0,
                  child: AdminMenu()))
          : Container(),
      Leiste(
          admin: admin,
          home: () {},
          meineTermine: () {},
          adminBereich: () {
            setState(() {
              adminMenu = !adminMenu;
            });
          })
    ]));
  }
}

class TesteSchriftarten extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteSchriftartenState();
}

class _TesteSchriftartenState extends State<TesteSchriftarten> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: ListView(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
              children: [
            CustomText('TextfeldText', textart: Textarten.TextfeldText),
            CustomText('Uberschrift', textart: Textarten.Uberschrift),
            CustomText('UnterUberschrift', textart: Textarten.UnterUberschrift),
            CustomText('WeisseDickeUberschrift',
                textart: Textarten.WeisseDickeUberschrift),
          ])),
    ));
  }
}
