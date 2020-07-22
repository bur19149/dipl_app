import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gui_konstanten.dart';

/// Enthält die in der App verwendeten Textgrößen.
/// Textgroesse normal ist 17 (Muss in der jeweiligen Klasse als Standardwert definiert werden)
abstract class Groesse {
  static const double gross = 30;
  static const double klein = 9; //TODO keine Ahnung für was das gebraucht wird /shrug
}

class TextTemplate extends StatelessWidget {
  final String text;
  final Color farbe;

  TextTemplate({@required this.text, this.farbe = Farben.dunkelgrau});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: Groesse.gross,
          fontFamily: 'Roboto',
        ));
  }
}

class UnterUberschrift extends StatelessWidget{

  final String text;

  const UnterUberschrift({@required this.text});

  @override
  Widget build(BuildContext context) {
    return TextTemplate(text: text, farbe: Farben.grau, );
  }


}