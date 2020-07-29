// -------------------------------- Imports ---------------------------------

import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'gui_konstanten.dart';

class Button extends StatefulWidget {
  final double width;
  final VoidCallback onPressed;
  final Buttonfarbe farbe;
  final bool gefuellt;
  final String text;
  final String svg;

  Button(
      {this.width = double.infinity,
      @required this.onPressed,
      this.farbe = Buttonfarbe.blaugrau,
      this.gefuellt = true,
      this.text = 'Button',
      this.svg});

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    Color buttonFarbe;
    Color highlightColor;

    switch (widget.farbe) { // @formatter:off
      case Buttonfarbe.rot:			 highlightColor = Farben.rotHighlight; 	    buttonFarbe = Farben.rot;			 break; // rot:      #B70E0C; rotHighlight:      #7A0A09
      case Buttonfarbe.gelb:		 highlightColor = Farben.gelbHighlight;	    buttonFarbe = Farben.gelb;		 break; // gelb:     #FFC107; gelbHighlight:     #C49506
      case Buttonfarbe.gruen:		 highlightColor = Farben.gruenHighlight; 	  buttonFarbe = Farben.gruen;		 break; // gruen:    #28A745; gruenHighlight:    #1A692C
      case Buttonfarbe.blau:		 highlightColor = Farben.blauHighlight; 	  buttonFarbe = Farben.blau;		 break; // blau:     #17A2B8; blauHighlight:     #117585
      case Buttonfarbe.blaugrau: highlightColor = Farben.blaugrauHighlight; buttonFarbe = Farben.blaugrau; break; // blaugrau: #6C757D; blaugrauHighlight: #444A4F
      default:						       highlightColor = Farben.weissHighlight; 		buttonFarbe = Farben.weiss;		 break; // weiss:    #FFFFFF; weissHighlight:    #F2F2F2
    } // @formatter:on

    Color textColor = widget.gefuellt ? Farben.weiss : buttonFarbe;

    Widget child,
        textWidget = Text(widget.text,
            style: Schrift(color: textColor));

    if (widget.svg != null) {
      child = Row(children: [Expanded(child: Container()),
        SvgPicture.asset(widget.svg, height: 23,
            color: textColor),
        SizedBox(width: 12),
        Text(widget.text,
            style: Schrift(color: textColor)),
        Expanded(child: Container())
      ]);
    } else {
      child = textWidget;
    }
    return SizedBox(
        width: widget.width,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          color: widget.gefuellt ? buttonFarbe : Farben.weiss,
          highlightColor: widget.gefuellt ? highlightColor : Farben
              .weissHighlight,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),
              side: widget.gefuellt ? BorderSide.none : BorderSide(
                  color: buttonFarbe, width: 1.6)),
          onPressed: widget.onPressed,
          child: child,
        )
    );
  }
}

class CustomToggleButton extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------
  // @formatter:off
  final bool               value; // Standardwert
  final GestureTapCallback onTap; // Eventhandler
  final double             size;  // Groesse (Breite)
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  CustomToggleButton(
      {this.size = 70, this.value = true, @required this.onTap, Key key})
      : super(key: key);

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  // ------------------------------- Variablen --------------------------------

  bool _value = true; // aktueller Wert

  // -------------------------------- initState -------------------------------

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  // ------------------------------ Eventhandler ------------------------------

  void _changeValue() {
    setState(() {
      _value = !_value;
      widget.onTap.call();
    });
  }

  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size,
        height: widget.size / 2,
        child: FittedBox(
            fit: BoxFit.contain,
            child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: _changeValue,
                child: Container(
                    height: 70,
                    width: 140,
                    child: Stack(children: [
                      Align(
                          alignment: FractionalOffset(0.5, 0.5),
                          child: Container(
                            // Button-Hintergrund
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Farben.grau,
                                borderRadius:
                                BorderRadius.all(Radius.circular(11)),
                                border: Border.all(
                                    color: Farben.hellgrau, width: 3)),
                          )),
                      AnimatedPositioned(
                          left: _value ? 70 : 0,
                          duration: Duration(milliseconds: 200),
                          child: AnimatedContainer(
                            // Button-Knopf
                              curve: Curves.linearToEaseOut,
                              duration: Duration(milliseconds: 200),
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                  color: _value ? Farben.gruen : Farben.rot,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(
                                      color: Farben.hellgrau, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.2),
                                        spreadRadius: 0.1,
                                        blurRadius: 8,
                                        offset: Offset(5, 5))
                                  ])))
                    ])))));
  }
}
