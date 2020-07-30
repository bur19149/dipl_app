// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  // @formatter:off

  // ------------------------------ Konstruktor -------------------------------

  const Textfeld(
      {this.text = 'Header', this.hintText = 'HintText', this.maxLength = 64, this.headerStyle = const Schrift(), this.dateTime = false});

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
      widget.dateTime ? _DateTimeTextfeld(
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
      this.error = false});

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
            data: ThemeData(primaryColor: Farben.blaugrau, errorColor: Farben.rot),
            child: TextFormField(
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
                decoration: InputDecoration(errorStyle: Schrift(fontSize: 12, color: Farben.rot),
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
//                        borderSide:
//                            BorderSide(width: 1, color: Farben.grau)
                    ))))
    )
        ;
  }
}

class _DateTimeTextfeld extends StatefulWidget {
  final String hintText;
  final int maxLength;

  const _DateTimeTextfeld({this.hintText = 'HintText', this.maxLength = 64});

  @override
  State<StatefulWidget> createState() => _DateTimeTextfeldState();
}

class _DateTimeTextfeldState extends State<_DateTimeTextfeld> {
  bool expanded = false, focus = false, error = false, teste = false;
  final _formKey = GlobalKey<FormState>();



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
  Widget build(BuildContext context) {
    var _feld = _Feld(
        validator: (value) {
          print('Datum: [$value] ##############################');
          try {
          if(_isValidDate(value)) return null;
          } catch (e) {print('**************************************\n\n$e\n\n**************************************');}
          return 'Ungültiges Datum!';},
        error: error,
        inputFormatters: [MaskTextInputFormatter(mask: '##.##.#### ##:##')],
        dateTime: true,
        contentPaddingRight: 48,
        hintText: widget.hintText,
        maxLength: widget.maxLength);

    return Column(children: [
      Button(
        onPressed: () {
          teste = !teste;
        },
      ),
      Form(
          key: _formKey,
          child: InkWell(
              onFocusChange: (change) => setState(() {
                    focus = change;
                    if (!_formKey.currentState.validate())
                      error = true;
                    else
                      error = false;
                  }),
              child: Container(
                  height: 63,
                  child: Stack(children: [
                    _feld,
                    Align(
                        alignment: Alignment.topRight,
                        child: AnimatedContainer(
                          width: 40,
                          height: 40,
                          duration: Duration(milliseconds: 100),
                          child: Stack(children: [
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(svgIcons['kalender'],
                                    color: error ? Farben.rot : (focus ? Farben.dunkelgrau : Farben.blaugrau),
                                    height: 22))
                          ]),
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              border: focus
                                  ? Border.all(width: 2,   color: error ? Farben.rot : Farben.dunkelgrau)
                                  : Border.all(width: 1.2, color: error ? Farben.rot : Color.fromRGBO(155, 155, 155, 1)),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5))),
                        )),
                  ]))))
    ]);
  }
}