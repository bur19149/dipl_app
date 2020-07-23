import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_topLeiste.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
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
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteMenu())),         text: 'Menüleisten-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteWidgets())),      text: 'Widgets-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteSchriftarten())), text: 'Schriftarten-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteTopleiste())),    text: 'Topleisten-Tests')
      // @formatter:on
    ]);
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
          child: Topleiste())
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
      SvgPicture.asset(svgIcons['einstellungen'],
          color: Farben.blaugrau, height: 50),
      SizedBox(height: 50),
      Button(onPressed: () {  },),
      SizedBox(height: 50),
      LoginRahmen(
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
  bool admin = true;

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
            Container(
                color: Farben.rot,
                child:
                    CustomText('Uberschrift', textart: Textarten.Uberschrift)),
            CustomText('UnterUberschrift', textart: Textarten.UnterUberschrift),
            Container(
                color: Farben.blau,
                child: CustomText('WeisseDickeUberschrift',
                    textart: Textarten.WeisseUberschrift))
          ])),
    ));
  }
}
