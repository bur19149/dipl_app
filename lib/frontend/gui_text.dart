import 'package:flutter/material.dart';
import 'gui_konstanten.dart';

/// Enthält die in der App verwendeten Textgrößen.
/// Textgroesse normal ist 17 (Muss in der jeweiligen Klasse als Standardwert definiert werden)
abstract class Groesse {
  static const double normal = 24;
  static const double klein =
      9; //TODO keine Ahnung für was das gebraucht wird /shrug
  static const double gross = 38;
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
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: farbe,
          fontStyle: FontStyle.normal,
          fontWeight: fontWeight,
          fontSize: fontSize,
          fontFamily: appFont,
        ));
  }
}

class _UnterUberschrift extends StatelessWidget {
  final String text;

  _UnterUberschrift({@required this.text});

  @override
  Widget build(BuildContext context) {
    return _TextTemplate(
      text: text,
      farbe: Farben.blaugrau,
      fontWeight: FontWeight.w400,
    );
  }
}

class _TextfeldText extends StatelessWidget {
  final String text;

  _TextfeldText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return _TextTemplate(
      text: text,
      farbe: Farben.blaugrau,
      fontWeight: FontWeight.w300,
    );
  }
}

class _Uberschrift extends StatelessWidget {
  final String text;

  _Uberschrift({@required this.text});

  @override
  Widget build(BuildContext context) {
    return _TextTemplate(
      text: text, fontSize: Groesse.gross, farbe: Farben.weiss,);
  }
}

class _WeisseUberschrift extends StatelessWidget {
  final String text;

  _WeisseUberschrift({@required this.text});

  @override
  Widget build(BuildContext context) {
    return _TextTemplate(
        text: text,
        farbe: Farben.weiss,
        fontWeight: FontWeight.w300,
        fontSize: Groesse.normal);
  }
}

class CustomText extends StatelessWidget {
  final Textarten textart;
  final String text;

  CustomText(this.text, {@required this.textart});

  @override
  Widget build(BuildContext context) {
    switch(textart){ // @formatter:off
      case Textarten.Uberschrift:       return _Uberschrift       (text: text);
      case Textarten.TextfeldText:      return _TextfeldText      (text: text);
      case Textarten.UnterUberschrift:  return _UnterUberschrift  (text: text);
      case Textarten.WeisseUberschrift: return _WeisseUberschrift (text: text);
      default:                          return _TextfeldText      (text: text);
    } // @formatter:on
  }
}

enum Textarten {
  Uberschrift,
  TextfeldText,
  UnterUberschrift,
  WeisseUberschrift,
}