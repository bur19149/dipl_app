import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gui_konstanten.dart';

/// Enthält die in der App verwendeten Textgrößen.
/// Textgroesse normal ist 17 (Muss in der jeweiligen Klasse als Standardwert definiert werden)
abstract class Groesse {
  static const double normal = 30;
  static const double klein = 9; //TODO keine Ahnung für was das gebraucht wird /shrug
  static const double gross = 50;
}

class _TextTemplate extends StatelessWidget {
  final String text;
  final Color farbe;
  final FontWeight fontWeight;
  final double fontSize;

//@formatter:off
  _TextTemplate({@required this.text, this.farbe = Farben.dunkelgrau,
    this.fontWeight = FontWeight.normal, this.fontSize = Groesse.normal});
//@formatter:on

  @override
  Widget build(BuildContext context){
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
          fontSize: Groesse.normal,
          fontFamily: 'Roboto',
        ));
  }
}

class UnterUberschrift extends StatelessWidget {
  final String text;

  UnterUberschrift({@required this.text});

  @override
  Widget build(BuildContext context){
    return _TextTemplate(
      text: text,
      farbe: Farben.grau,
      fontWeight: FontWeight.bold,
    );
  }
}

class TextfeldText extends StatelessWidget {
  final String text;

  TextfeldText({@required this.text});

  @override
  Widget build(BuildContext context){
    return _TextTemplate(
      text: text,
      farbe: Farben.grau,
      fontWeight: FontWeight.normal,
    );
  }
}

class Uberschrift extends StatelessWidget {
  final String text;

  Uberschrift({@required this.text});

  @override
  Widget build(BuildContext context){
    return _TextTemplate(text: text, fontSize: Groesse.gross);
  }
}

class WeisseDickeUberschrift extends StatelessWidget {
  final String text;

  WeisseDickeUberschrift({@required this.text});

  @override
  Widget build(BuildContext context){
    return _TextTemplate(
      text: text, farbe: Farben.weiss, fontWeight: FontWeight.normal, fontSize: Groesse.normal);
  }
}

class CustomText extends StatelessWidget {
  final Textarten textart;
  final String text;

  CustomText(this.text, {@required this.textart});

  @override
  Widget build(BuildContext context){
    switch(textart){
      case Textarten.Uberschrift: return Uberschrift(text: text);
      case Textarten.TextfeldText: return TextfeldText(text: text);
      case Textarten.UnterUberschrift: return UnterUberschrift(text: text);
      case Textarten.WeisseDickeUberschrift: return WeisseDickeUberschrift(text: text);
      default: return TextfeldText(text: text);
    }
  }
}

enum Textarten {
  Uberschrift,
  TextfeldText,
  UnterUberschrift,
  WeisseDickeUberschrift,
}