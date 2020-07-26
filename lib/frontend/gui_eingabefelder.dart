import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gui_konstanten.dart';

class Textfeld extends StatefulWidget {
  final String text, hintText;
  final int maxLength;

  const Textfeld(
      {this.text = 'Header', this.hintText = 'Header', this.maxLength = 64});

  @override
  State<StatefulWidget> createState() => _TextfeldState();
}

class _TextfeldState extends State<Textfeld> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(widget.text,
                  textart: Textarten.UnterUberschrift))),
      SizedBox(height: 7),
      _Feld(
        hintText: widget.hintText,
        maxLength: widget.maxLength,
      )
    ]);
  }
}
/*
TextField(
style: TextStyle(fontFamily: appFont, fontSize: 20),
strutStyle: StrutStyle(height: 1.6),
decoration: InputDecoration(
contentPadding: EdgeInsets.only(left: 5, right: 5),
hintText: 'Suchen',
hintStyle: TextStyle(fontFamily: appFont, color: Farben.grau, fontSize: 20),
border: OutlineInputBorder(borderSide: BorderSide.none)),
);
*/

class _Feld extends StatefulWidget {
  final String hintText;
  final int maxLength;

  const _Feld({this.hintText, this.maxLength = 64});

  @override
  State<StatefulWidget> createState() => _FeldState();
}

class _FeldState extends State<_Feld> {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primaryColor: Farben.blaugrau),
        child: TextFormField(
            style: TextStyle(
                fontFamily: appFont,
                color: Farben.dunkelgrau,
                fontSize: Groesse.normal),
            maxLength: widget.maxLength,
            strutStyle: StrutStyle(height: 1.3),
            decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    fontFamily: appFont,
                    color: Farben.grau,
                    fontSize: Groesse.normal),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 1, color: Farben.grau)))));
  }
}
