import 'dart:ui';

/// Enthält alle in der App verwendeten Farben.
abstract class Farben {
  // ------------------ normale Farben ------------------

  /// Farbe ([Color]) grün: #28A745
  static const Color gruen = Color.fromRGBO(40, 167, 69, 1);

  /// Farbe ([Color]) rot: #B70E0C
  static const Color rot = Color.fromRGBO(183, 14, 12, 1);

  /// Farbe ([Color]) gelb: #FFC107
  static const Color gelb = Color.fromRGBO(255, 193, 7, 1);

  /// Farbe ([Color]) weiss: #FFFFFF
  static const Color weiss = Color.fromRGBO(255, 255, 255, 1);

  /// Farbe ([Color]) schwarz: #000000
  static const Color schwarz = Color.fromRGBO(0, 0, 0, 1);

  /// Farbe ([Color]) blaugrau: #6C757D
  static const Color blaugrau = Color.fromRGBO(108, 117, 125, 1);

  /// Farbe ([Color]) blau: #17A2B8
  static const Color blau = Color.fromRGBO(23, 162, 184, 1);

  // --------------------- Grautöne ---------------------

  /// Farbe ([Color]) grau: #BDBDBD
  static const Color grau = Color.fromRGBO(189, 189, 189, 1);

  /// Farbe ([Color]) hellgrau: #F2F2F2
  static const Color hellgrau = Color.fromRGBO(242, 242, 242, 1);

  /// Farbe ([Color]) dunkelgrau: #505050
  static const Color dunkelgrau = Color.fromRGBO(80, 80, 80, 1);

  // ----------------- Highlight Farben -----------------

  /// Farbe ([Color]) rotHighlight: #7A0A09
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color rotHighlight = Color.fromRGBO(122, 10, 9, 1);

  /// Farbe ([Color]) gelbHighlight: #C49506
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color gelbHighlight = Color.fromRGBO(196, 149, 6, 1);

  /// Farbe ([Color]) gruenHighlight: #1A692C
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color gruenHighlight = Color.fromRGBO(26, 105, 44, 1);

  /// Farbe ([Color]) blauHighlight: #117585
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color blauHighlight = Color.fromRGBO(17, 117, 133, 1);

  /// Farbe ([Color]) blaugrauHighlight: #444A4F
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color blaugrauHighlight = Color.fromRGBO(68, 74, 79, 1);

  /// Farbe ([Color]) weissHighlight: #F2F2F2
  /// **Bitte nicht verwenden!**
  /// Wird nur in der _gui.dart_ verwendet!
  static const Color weissHighlight = hellgrau;
}

/// Enthält die in der App verwendeten Textgrößen.
/// Textgroesse normal ist 17 (Muss in der jeweiligen Klasse als Standardwert definiert werden)
abstract class Groesse {
  static const double gross = 30;
  static const double klein = 9;
}

// @formatter:off
/// Enthält alle in der App vorkommenden Buttonfarben.
enum Farbe {
	gruen,		// #28A745
	rot,			// #B70E0C
	gelb,			// #FFC107
	blaugrau,	// #6C757D
	blau			// #17A2B8
} // @formatter:on