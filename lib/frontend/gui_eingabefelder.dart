// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'gui_konstanten.dart';
import 'gui_buttons.dart';

/// Standard-Textfeld mit Überschrift
class Textfeld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String    text;        // Überschrift des Textfeldes
  final String    hintText;    // Hinweistext innerhalb des Textfeldes
  final TextStyle headerStyle; // Formatierung der Überschrift des Textfeldes
  final int       maxLength;   // maximale Anzahl Zeichen innerhalb des Textfeldes
  final bool      dateTime;
  final Wrapper   value;
  // @formatter:off

  // ------------------------------ Konstruktor -------------------------------

  const Textfeld(
      {this.text = 'Header', this.hintText = 'HintText', this.maxLength = 64, this.headerStyle = const Schrift(), this.dateTime = false, this.value});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _TextfeldState();
}

class _TextfeldState extends State<Textfeld> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.text,
                  style: widget.headerStyle))),
      SizedBox(height: 7),
      widget.dateTime ? _DateTimeTextfeld(value: widget.value,
          hintText: widget.hintText,
          maxLength: widget.maxLength) :
      _Feld(
        hintText: widget.hintText,
        maxLength: widget.maxLength,
      )
    ]);
  }
}

/// Standard-Textfeld
class _Feld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String                   hintText;            // Hinweistext innerhalb des Textfeldes
  final int                      maxLength;           // maximale Anzahl Zeichen innerhalb des Textfeldes
  final double                   contentPaddingLeft;
  final double                   contentPaddingRight;
  final List<TextInputFormatter> inputFormatters;
  final bool                     dateTime;
  final bool                     error;
  final Function(String)         validator;
  final TextEditingController    controller;

  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const _Feld(
      {this.hintText,
      this.maxLength = 64,
      this.contentPaddingLeft = 10,
      this.contentPaddingRight = 10,
      this.inputFormatters,
      this.dateTime = false,
      this.validator,
      this.error = false,
      this.controller});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _FeldState();
}

class _FeldState extends State<_Feld> {
  List<TextInputFormatter> _inputFormatters;

  @override
  void initState() {
    _inputFormatters =
        widget.inputFormatters != null ? widget.inputFormatters : [];
    super.initState();
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: widget.error ? 63 : 40,
        child: Theme(
            data: ThemeData(
                primaryColor: Farben.blaugrau, errorColor: Farben.rot),
            child: TextFormField(
                controller: widget.controller,
                validator: widget.validator == null
                    ? (text) => null
                    : widget.validator,
                keyboardType: widget.dateTime
                    ? TextInputType.datetime
                    : TextInputType.text,
                style: Schrift(color: Farben.schwarz),
                maxLength: widget.maxLength,
                inputFormatters: _inputFormatters,
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
                        right: widget.contentPaddingRight),
                    hintText: widget.hintText,
                    hintStyle: Schrift(color: Farben.grau),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )))));
  }
}

class _DateTimeTextfeld extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final String hintText;
  final int    maxLength;
  final Wrapper value;
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  const _DateTimeTextfeld({this.hintText = 'HintText', this.maxLength = 64, this.value});

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _DateTimeTextfeldState();
}

class _DateTimeTextfeldState extends State<_DateTimeTextfeld> {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  bool                  _focus   = false;
  bool                  _error   = false;
  final                 _formKey = GlobalKey<FormState>(); // Key
  TextEditingController controller;
  // @formatter:on

  Future<DateTime> _showCustomDatePicker({@required BuildContext context}) { // @formatter:off
    return showDatePicker(
        context:         context,
        initialDate:     DateTime.now(),
        firstDate:       DateTime(2000),
        lastDate:        DateTime(2030),
        helpText:        'Wähle Datum',
        fieldLabelText:  'Gib ein Datum ein',
        errorFormatText: 'Ungültiges Datum!',
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

  String _convertDate(String value) { // @formatter:off
    var list = RegExp(r'(\d{2})\.(\d{2})\.(\d{4})\s(\d{2}):(\d{2})').allMatches(value).elementAt(0);
    return '${list.group(3).toString().padLeft(4, '0')}-'
           '${list.group(2).toString().padLeft(2, '0')}-'
           '${list.group(1).toString().padLeft(2, '0')} '
           '${list.group(4).toString().padLeft(2, '0')}:'
           '${list.group(5).toString().padLeft(2, '0')}:00';
  } // @formatter:on

  bool _isValidDate(String input) {
    return input == _toOriginalFormatString(DateTime.parse(input));
  }

  String _toOriginalFormatString(DateTime dateTime) { // @formatter:off
    return '${dateTime.year  .toString().padLeft(4, '0')}-'
           '${dateTime.month .toString().padLeft(2, '0')}-'
           '${dateTime.day   .toString().padLeft(2, '0')} '
           '${dateTime.hour  .toString().padLeft(2, '0')}:'
           '${dateTime.minute.toString().padLeft(2, '0')}:00';
  } // @formatter:on

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) { // @formatter:off
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
        inputFormatters: [MaskTextInputFormatter(mask: '##.##.#### ##:##')],
        contentPaddingRight: 48,
        dateTime:  true,
        hintText:  widget.hintText,
        maxLength: widget.maxLength);

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
                      child: InkWell(onTap: () async {
                        var dateTime = await _showDateTimePicker(context);
                        if (dateTime != null) {
                          controller.text = DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
                          widget.value.value = dateTime;
                        }
                        setState(() { _error = !_formKey.currentState.validate(); });
                      },  child: AnimatedContainer(
                          width:  40,
                          height: 40,
                          duration: Duration(milliseconds: 100),
                          child: Stack(children: [
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(svgIcons['kalender'],
                                    height: 22,
                                    color: _error ? Farben.rot        : (
                                           _focus ? Farben.dunkelgrau : Farben.blaugrau)))
                          ]),
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              border: _focus ? Border.all(width: 2,   color: _error ? Farben.rot : Farben.dunkelgrau)
                                             : Border.all(width: 1.2, color: _error ? Farben.rot : Color.fromRGBO(155, 155, 155, 1)),
                              borderRadius: BorderRadius.only(
                                  topRight:    Radius.circular(5),
                                  bottomRight: Radius.circular(5)))
                      )))
                ]))));
  } // @formatter:on
}

class Wrapper {
  var value;
  Wrapper({this.value});
}