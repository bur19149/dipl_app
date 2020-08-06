// -------------------------------- Imports ---------------------------------

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'gui_konstanten.dart';

/// Standard-Textfeld mit Überschrift
class Textfeld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String    text;                           // Überschrift des Textfeldes
  final String    hintText;                       // Hinweistext innerhalb des Textfeldes
  final String    bottomHintText;                 // Hinweistext unterhalb des Textfeldes
  final TextStyle headerStyle;                    // Formatierung der Überschrift des Textfeldes
  final int       maxLength;                      // maximale Anzahl Zeichen innerhalb des Textfeldes
  final bool      dateTime;                       // Ist das Textfeld ein DateTimeTextfeld?
  final Wrapper   value;                          // Inhalt des Textfeldes
  final List<TextInputFormatter> inputFormatters; // definiert den zulässigen Textinhalt und ermöglicht es Textmasken zuzuweisen
  final bool multiline;                           // Hat das Textfeld mehrere Zeilen?
  // @formatter:off

  // ------------------------------ Konstruktor -------------------------------

  const Textfeld({ // @formatter:off
        this.text        = 'Header',
        this.hintText    = 'HintText',
        this.maxLength   = 64,
        this.headerStyle = const Schrift(),
        this.dateTime    = false,
        this.multiline   = false,
        this.value,
        this.inputFormatters,
        this.bottomHintText});
  // @formatter:on

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _TextfeldState();
}

class _TextfeldState extends State<Textfeld> {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  String  hintText; // Hinweistext innerhalb des Textfeldes
  // @formatter:on

  // -------------------------------- initState -------------------------------

  @override
  void initState() {
    if (widget.dateTime && widget.hintText == 'HintText') {
      hintText = DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now());
    } else {
      hintText = widget.hintText;
    }
    super.initState();
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.text, style: widget.headerStyle))),
      SizedBox(height: 7),
      widget.dateTime
          ? _DateTimeTextfeld(
              value: widget.value ?? Wrapper(), hintText: hintText)
          : _Feld(
              inputFormatters: widget.inputFormatters ?? [],
              multiline: widget.multiline,
              hintText: hintText,
              maxLength: widget.maxLength,
            ),
      widget.bottomHintText == null
          ? Container()
          : Container(
              height: 25,
              padding: EdgeInsets.only(left: 9),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(widget.bottomHintText,
                      style: Schrift(color: Farben.grau, fontSize: 15))))
    ]);
  }
}

/// Standard-Textfeld
class _Feld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String                   hintText;            // Hinweistext innerhalb des Textfeldes
  final int                      maxLength;           // maximale Anzahl Zeichen innerhalb des Textfeldes
  final double                   contentPaddingLeft;  // Abstand des Textes zum linken Rand des Textfeldes
  final double                   contentPaddingRight; // Abstand des Textes zum rechten Rand des Textfeldes
  final List<TextInputFormatter> inputFormatters;     // definiert den zulässigen Textinhalt und ermöglicht es Textmasken zuzuweisen
  final bool                     dateTime;            // Ist das Textfeld ein DateTimeTextfeld?
  final bool                     error;               // Ist der eingegebene Text fehlerhaft?
  final bool                     multiline;           // Hat das Textfeld mehrere Zeilen?
  final Function(String)         validator;           // Prüfung ob der Inhalt des Textfeldes valide ist
  final TextEditingController    controller;          // Controller des Textfeldes; wird verwendet um einen Text in das Textfeld zu schreiben
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const _Feld({ // @formatter:off
    this.maxLength           = 64,
    this.contentPaddingLeft  = 10,
    this.contentPaddingRight = 10,
    this.dateTime            = false,
    this.error               = false,
    this.multiline           = false,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.controller});
  // @formatter:on

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _FeldState();
}

class _FeldState extends State<_Feld> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.error ? (widget.multiline ? 93 : 63) : (widget.multiline
            ? 70
            : 40),
        child: Theme(
            data: ThemeData(
                primaryColor: Farben.blaugrau, errorColor: Farben.rot),
            child: TextFormField(minLines: widget.multiline ? 2 : null,
                maxLines: widget.multiline ? null : 1,
                controller: widget.controller,
                validator: widget.validator == null
                    ? (text) => null
                    : widget.validator,
                keyboardType: widget.dateTime
                    ? TextInputType.datetime
                    : TextInputType.text,
                style: Schrift(color: Farben.schwarz),
                maxLength: widget.maxLength,
                inputFormatters: widget.inputFormatters ?? [],
                strutStyle: StrutStyle(height: 1.3),
                decoration: InputDecoration(
                    errorStyle: Schrift(fontSize: 12, color: Farben.rot),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide:
                        BorderSide(width: 2, color: Farben.dunkelgrau)),
                    counterText: '',
                    contentPadding: EdgeInsets.only(
                        left: widget.contentPaddingLeft,
                        right: widget.contentPaddingRight,
                        top: widget.multiline ? 10 : 0,
                        bottom: widget.multiline ? 10 : 0),
                    hintText: widget.hintText,
                    hintStyle: Schrift(color: Farben.grau),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )))));
  }
}

/// Textfeld zur Eingabe von Zeitangaben
class _DateTimeTextfeld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String  hintText;  // Hinweistext innerhalb des Textfeldes
  final Wrapper value;     // Inhalt des Textfeldes
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const _DateTimeTextfeld({this.hintText = 'HintText', this.value});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _DateTimeTextfeldState();
}

class _DateTimeTextfeldState extends State<_DateTimeTextfeld> {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool                  _focus   = false;                  // Ist das Textfeld aktuell ausgewählt?
  bool                  _error   = false;                  // Ist der eingegebene Text fehlerhaft?
  final                 _formKey = GlobalKey<FormState>(); // Key für das Formular; wird zum validieren vom Inhalt des Textfeldes benötigt
  TextEditingController controller;                        // Controller des Textfeldes; wird verwendet um das Ergebnis des Datepickers in das Textfeld zu schreiben
  // @formatter:on

  // ---------------------------- DateTime-Picker -----------------------------

  /// definiert das Aussehen des DatePickers
  Future<DateTime> _showCustomDatePicker({@required BuildContext context}) { // @formatter:off
    return showDatePicker(
        context:         context,
        initialDate:     DateTime.now(),
        firstDate:       DateTime(2000),
        lastDate:        DateTime(2030),
        helpText:        'Wähle Datum',
        fieldLabelText:  'Gib ein Datum ein',
        errorFormatText: 'Ungültiges Datum!',
        fieldHintText:   '',
        locale:      const Locale("de", "DE"),
        builder:     (BuildContext context, Widget child) => Theme(
              data: ThemeData.light().copyWith(
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
                colorScheme: ColorScheme.light(
                  primary:   Farben.rot,
                  onPrimary: Farben.weiss,
                  surface:   Farben.rot,
                  onSurface: Farben.schwarz,
                ),
                dialogBackgroundColor: Farben.weiss,
              ),
              child: child,
            ));
  } // @formatter:on

  /// definiert das Aussehen des TimePickers
  Future<TimeOfDay> _showCustomTimePicker({@required BuildContext context}) { // @formatter:off
    return showTimePicker(
        context:     context,
        initialTime: TimeOfDay.now(),
        builder:     (BuildContext context, Widget child) => Theme(
              data: ThemeData.light().copyWith(
                buttonTheme:  ButtonThemeData(textTheme: ButtonTextTheme.primary),
                primaryColor: Farben.rot,
                accentColor:  Farben.rot,
                colorScheme:  ColorScheme.light(primary: Farben.rot),
                dialogBackgroundColor: Farben.weiss,
              ),
              child: child,
            ));
  } // @formatter:on

  /// Verknüft Date- & TimePicker und blendet diese ein. Liefert ein Future<DateTime> zurück
  Future<DateTime> _showDateTimePicker(BuildContext context) async { // @formatter:off
    DateTime dateTime;
    await _showCustomDatePicker(context: context).then((value) async {
      if (value != null) {
        TimeOfDay timeOfDay = await _showCustomTimePicker(context: context);
        dateTime = DateTime(value.year, value.month, value.day, timeOfDay.hour, timeOfDay.minute);
      }
    });
    return dateTime;
  } // @formatter:on

  // --------------------------- Validitätsprüfung ----------------------------

  /// Konvertiert den Inhalt des Textfeldes in einen für DateTime verwertbaren String
  String _convertDate(String value) { // @formatter:off
    var list = RegExp(r'(\d{2})\.(\d{2})\.(\d{4})\s(\d{2}):(\d{2})').allMatches(value).elementAt(0);
    return '${list.group(3).toString().padLeft(4, '0')}-'
           '${list.group(2).toString().padLeft(2, '0')}-'
           '${list.group(1).toString().padLeft(2, '0')} '
           '${list.group(4).toString().padLeft(2, '0')}:'
           '${list.group(5).toString().padLeft(2, '0')}:00';
  } // @formatter:on

  /// Prüft ob der Datums-String zulässig ist
  bool _isValidDate(String input) {
    return input == _toOriginalFormatString(DateTime.parse(input));
  }

  /// Wandelt das DateTime in einen String um
  /// Wird für _isValidDate benötigt, da DateFormat in diesem Fall nicht funktioniert, bzw. das Ergebnis von _isValidDate verfälscht
  String _toOriginalFormatString(DateTime dateTime) { // @formatter:off
    return '${dateTime.year  .toString().padLeft(4, '0')}-'
           '${dateTime.month .toString().padLeft(2, '0')}-'
           '${dateTime.day   .toString().padLeft(2, '0')} '
           '${dateTime.hour  .toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}:00';
  } // @formatter:on

  // -------------------------------- initState -------------------------------

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    var _feld = _Feld(controller: controller,
        validator: (value) {
          if (value.isEmpty) return null;
          try {
            var converted = _convertDate(value);
            if (_isValidDate(converted)) {
              widget.value.value = DateTime.parse(converted);
              return null;
            }
          } catch (e) {}
          return 'Ungültiges Datum!';
        },
        error: _error,
        inputFormatters: [
          DateTimeInputFormatter(),
          MaskTextInputFormatter(mask: '##.##.#### ##:##')
        ],
        contentPaddingRight: 48,
        dateTime: true,
        hintText: widget.hintText,
        maxLength: 16);

    return Form(
        key: _formKey,
        child: InkWell(
            onFocusChange: (change) =>
                setState(() {
                  _focus = change;
                  if (!_focus) _error = !_formKey.currentState.validate();
                }),
            child: Container(
                height: _error ? 63 : 40,
                child: Stack(children: [
                  _feld,
                  Align(
                      alignment: Alignment.topRight,
                      child: AnimatedContainer(
                          width: 40,
                          height: 40,
                          duration: Duration(milliseconds: 100),
                          child: Material(color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)),
                              child: InkWell(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(4),
                                      bottomRight: Radius.circular(4)),
                                  onTap: () async {
                                    var dateTime = await _showDateTimePicker(
                                        context);
                                    if (dateTime != null) {
                                      controller.text = DateFormat(
                                          'dd.MM.yyyy HH:mm').format(dateTime);
                                      widget.value.value = dateTime;
                                    }
                                    setState(() {
                                      _error =
                                      !_formKey.currentState.validate();
                                    });
                                  }, child: Stack(children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(SVGicons.kalender,
                                        height: 22,
                                        color: _error ? Farben.rot : (
                                            _focus ? Farben.dunkelgrau : Farben
                                                .blaugrau)))
                              ]))),
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              border: _focus ? Border.all(width: 2,
                                  color: _error ? Farben.rot : Farben
                                      .dunkelgrau)
                                  : Border.all(width: 1.2,
                                  color: _error ? Farben.rot : Color.fromRGBO(
                                      155, 155, 155, 1)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5)))
                      ))
                ]))));
  }
}

/// Wrapper um Variablen an Parent-Widgets weiterzugeben zu können
class Wrapper {
  var value;

  Wrapper({this.value});
}

// TODO eventuell eine elegantere Lösung implementieren
/// Formatter für DateTime-Textfelder
class DateTimeInputFormatter extends TextInputFormatter { // @formatter:off
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text, length = text.length;
    switch (length) {
      case  1: return RegExp(r'[0-3]')                                                                                                 .hasMatch(text) ? newValue : oldValue;
      case  2: return RegExp(r'(?:0[1-9]|[12]\d|3[01])')                                                                               .hasMatch(text) ? newValue : oldValue;
      case  3: return RegExp(r'(?:0[1-9]|[12]\d|3[01])(?:\.|[01])')                                                                    .hasMatch(text) ? newValue : oldValue;
      case  4: return RegExp(r'(?:0[1-9]|[12]\d|3[01])(?:\.|[01])')                                                                    .hasMatch(text) ? newValue : oldValue;
      case  5: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])')                                                            .hasMatch(text) ? newValue : oldValue;
      case  6: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])(?:\.|[12])')                                                 .hasMatch(text) ? newValue : oldValue;
      case  7: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.[12]')                                                      .hasMatch(text) ? newValue : oldValue;
      case  8: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:19|20)')                                                 .hasMatch(text) ? newValue : oldValue;
      case  9: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199|20[0123])')                                          .hasMatch(text) ? newValue : oldValue;
      case 10: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))')                                .hasMatch(text) ? newValue : oldValue;
      case 11: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))(?:\s|[012])')                    .hasMatch(text) ? newValue : oldValue;
      case 12: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))\s[012]')                         .hasMatch(text) ? newValue : oldValue;
      case 13: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))\s(?:[01]\d|2[0-3])')             .hasMatch(text) ? newValue : oldValue;
      case 14: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))\s(?:[01]\d|2[0-3])(?:\:|[0-5])') .hasMatch(text) ? newValue : oldValue;
      case 15: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))\s(?:[01]\d|2[0-3])\:[0-5]')      .hasMatch(text) ? newValue : oldValue;
      case 16: return RegExp(r'(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[012])\.(?:199\d|20(?:[012]\d|30))\s(?:[01]\d|2[0-3])\:[0-5]\d')    .hasMatch(text) ? newValue : oldValue;
      default: return newValue;
    }
  }
} // @formatter:on