// -------------------------------- Imports ---------------------------------

import 'package:flutter/material.dart';
import 'gui_konstanten.dart';

/// Enthält die in der App verwendeten Textgrößen.
/// Textgroesse normal ist 17 (Muss in der jeweiligen Klasse als Standardwert definiert werden)
abstract class Groesse { // @formatter:off
  static const double gross  = 34;
  static const double normal = 19;
  static const double klein  =  9;
} // @fomratter:on

class Schrift extends TextStyle { // @formatter:off
  // ------------------------------ Standardwerte -----------------------------

  static const FontWeight _fontWeight = FontWeight.w300;
  static const Color      _color      = Farben.blaugrau;
  static const double     _fontSize   = Groesse.normal;
  static const String     _fontFamily = appFont;

  // ----------------------------- Konstruktoren ------------------------------

  /// Standardtextgröße
  const Schrift(
      { FontWeight fontWeight = _fontWeight,
        Color      color      = _color,
        double     fontSize   = _fontSize,
        String     fontFamily = _fontFamily})
      : super(fontWeight: fontWeight, color: color, fontSize: fontSize, fontFamily: fontFamily);

  /// Titel wie z. B. im Anmeldebildschirm verwendet
  const Schrift.titel(
      { FontWeight fontWeight = FontWeight.normal,
        Color      color      = Farben.weiss,
        double     fontSize   = Groesse.gross,
        String     fontFamily = _fontFamily})
      : this(fontWeight: fontWeight, color: color, fontSize: fontSize, fontFamily: fontFamily);

  ///  Titel wie z. B. bei den Footern der Termine verwendet
  const Schrift.titelFooter(
      { FontWeight fontWeight = FontWeight.w300,
        Color      color      = Farben.weiss,
        double     fontSize   = Groesse.normal,
        String     fontFamily = _fontFamily})
      : this(fontWeight: fontWeight, color: color, fontSize: fontSize, fontFamily: fontFamily);

  /// Standardüberschrift
  const Schrift.ueberschrift(
      { FontWeight fontWeight = FontWeight.w500,
        Color      color      = Farben.blaugrau,
        double     fontSize   = _fontSize,
        String     fontFamily = _fontFamily})
      : this(fontWeight: fontWeight, color: color, fontSize: fontSize, fontFamily: fontFamily);
} // @formatter:on