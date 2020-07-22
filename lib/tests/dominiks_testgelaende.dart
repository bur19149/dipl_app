import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class DominiksTestgelaende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DominiksTestgelaendeState();
}

class _DominiksTestgelaendeState extends State<DominiksTestgelaende> {
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
      RaisedButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TesteMenu())),
          child: Text('Menüleisten-Test')),
      SizedBox(height: 50),
      TerminRahmen(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Farben.blau,
          )
        ],
      )
      //Kreuz(offen: offen, groesse: 0.7,)
    ]);
  }
}

class TesteMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TesteMenuState();
}

class _TesteMenuState extends State<TesteMenu> {
  bool adminMenu = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      Scaffold(body: Center(/*child: MenuBox()*/)),
      Align(
          alignment: Alignment.bottomCenter,
          child: Container(height: 90, color: Farben.blau)),
      AnimatedPositioned(
          right: adminMenu ? 11 : -220,
          bottom: adminMenu ? 85 : -510,
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 500),
          child: AnimatedOpacity(duration: Duration(milliseconds: 500), curve: Curves.easeOutCirc,
              opacity: adminMenu ? 1 : 0,
              child: AdminMenu())),
      Leiste(
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
