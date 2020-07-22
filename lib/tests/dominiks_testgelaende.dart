import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/main.dart';
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
      SizedBox(height: 150),
      TerminRahmen(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Farben.weiss,
          )
        ],
      )
      //Kreuz(offen: offen, groesse: 0.7,)
    ]);
  }
}
