import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dipl_app/frontend/gui_buttons.dart' as buttonklasse;

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      Row(children: [
        Text('Sortieren nach:', style: Schrift()),
        SizedBox(width: 10),
        Expanded(child: Button(text: 'Jahr', onPressed: () {}, sortieren: true,farbe: Buttonfarbe.rot)),
        SizedBox(width: 7),
        Expanded(child: Button(text: 'Monat', onPressed: () {}, sortieren: true,farbe: Buttonfarbe.rot,)),
      ])
    ]);
  }
}

class Button extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final double       width;     // Breite des Buttond
  final VoidCallback onPressed; // Eventhandler
  final Buttonfarbe  farbe;     // Farbe des Buttons
  final bool         gefuellt;  // Ist der Button gefüllt, oder ist nur der Rand farbig?
  final String       text;      // Buttontext
  final String       svg;       // Optionales SVG-Icon, welches links neben dem Buttontext angezeigt werden kann
  final bool         sortieren; //TODO
  // @formatter:on

  // ------------------------------ Konstruktor -------------------------------

  // @formatter:off
  Button( {@required this.onPressed,
    this.width     = double.infinity,
    this.farbe     = Buttonfarbe.blaugrau,
    this.gefuellt  = true,
    this.text      = 'Button',
    this.sortieren = false,
    this.svg});

  // @formatter:on

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    Color buttonFarbe;
    Color highlightColor;

    // Definition der Highlight-, und Button-Farbe

    switch (widget.farbe) { // @formatter:off
      case Buttonfarbe.rot:			 highlightColor = Farben.rotHighlight; 	    buttonFarbe = Farben.rot;			 break; // rot:      #B70E0C; rotHighlight:      #7A0A09
      case Buttonfarbe.gelb:		 highlightColor = Farben.gelbHighlight;	    buttonFarbe = Farben.gelb;		 break; // gelb:     #FFC107; gelbHighlight:     #C49506
      case Buttonfarbe.gruen:		 highlightColor = Farben.gruenHighlight; 	  buttonFarbe = Farben.gruen;		 break; // gruen:    #28A745; gruenHighlight:    #1A692C
      case Buttonfarbe.blau:		 highlightColor = Farben.blauHighlight; 	  buttonFarbe = Farben.blau;		 break; // blau:     #17A2B8; blauHighlight:     #117585
      case Buttonfarbe.blaugrau: highlightColor = Farben.blaugrauHighlight; buttonFarbe = Farben.blaugrau; break; // blaugrau: #6C757D; blaugrauHighlight: #444A4F
      default:						       highlightColor = Farben.weissHighlight; 		buttonFarbe = Farben.weiss;		 break; // weiss:    #FFFFFF; weissHighlight:    #F2F2F2
    } // @formatter:on

    Color textColor = widget.gefuellt
        ? Farben.weiss
        : buttonFarbe; // Definition der Textfarbe

    Widget child,
        textWidget = Text(widget.text, style: Schrift(color: textColor));

    // Definition des Button-inhalts

    if (widget.sortieren) {
      child = Row(
        children: [
          Expanded(child: Container()),
          Text(widget.text, style: Schrift(color: textColor)),
          Expanded(child: Container()),
          Container(
            height: 38 /* TODO höhe im button */,
            width: .8,
            color: Colors.white,),
          SizedBox(width: 10,),
          SvgPicture.asset(SVGicons.dropbutton, height: 10, color: textColor),
          SizedBox(
            width: 10,
          )
        ],
      );
    } else if (widget.svg != null) {
      child = Row(children: [
        Expanded(child: Container()),
        SvgPicture.asset(widget.svg, height: 23, color: textColor),
        SizedBox(width: 12),
        Text(widget.text, style: Schrift(color: textColor)),
        Expanded(child: Container())
      ]);
    } else {
      child = textWidget;
    }

    // Build

    return SizedBox(
        width: widget.width,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          //TODO evetuell entfernen, alte Werte waren 8
          color: widget.gefuellt ? buttonFarbe : Farben.weiss,
          highlightColor:
              widget.gefuellt ? highlightColor : Farben.weissHighlight,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: widget.gefuellt
                  ? BorderSide.none
                  : BorderSide(color: buttonFarbe, width: 1.6)),
          onPressed: widget.onPressed,
          child: child,));
  }
}

// class SortierButton extends StatefulWidget {
//   @override
//   _SortierButtonState createState() => _SortierButtonState();
// }
//
// class _SortierButtonState extends State<SortierButton> {
//   @override
//   Widget build(BuildContext context) {
//     return Button;
//   }
// }
