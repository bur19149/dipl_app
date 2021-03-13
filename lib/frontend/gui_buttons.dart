import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'gui_eingabefelder.dart';
import 'gui_konstanten.dart';
import 'dart:math';

/// Standard-Button
class Button extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

	// @formatter:off
  final double       width;     // Breite des Buttons
  final VoidCallback onPressed; // Eventhandler
  final Buttonfarbe  farbe;     // Farbe des Buttons
  final bool         gefuellt;  // Ist der Button gefüllt, oder ist nur der Rand farbig?
  final bool         sortieren; // Ist der Button ein Sortierbutton?
  final bool         active;    // Ist der Sortierbutton aktiv?
  final String       text;      // Buttontext
  final String       svg;       // Optionales SVG-Icon, welches links neben dem Buttontext angezeigt werden kann
  // @formatter:on

	// ------------------------------ Konstruktor -------------------------------

	// @formatter:off
  Button( {@required this.onPressed,
    this.width     = double.infinity,
    this.farbe     = Buttonfarbe.blaugrau,
    this.gefuellt  = true,
    this.text      = 'Button',
    this.sortieren = false,
    this.active    = false,
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
    }

		Color textColor = widget.gefuellt ? Farben.weiss : buttonFarbe; // Definition der Textfarbe
// @formatter:on

		Widget child,
				textWidget = Text(widget.text, style: Schrift(color: textColor));

		// Definition des Button-inhalts

    if (widget.sortieren){
      child = Row(
          children: [
            Expanded(child: Container()),
            Text(widget.text, style: Schrift(color: textColor)),
            Expanded(child: Container()),
            Container(
                height: 38,
                width: .8,
                color: Colors.white),
            SizedBox(width: 10), //SvgPicture.asset(SVGicons.dropbutton, height: 10, color: textColor),
            Flippable(
                back:  SvgPicture.asset(SVGicons.dropbutton, height: 10, color: textColor),
                front: SvgPicture.asset(SVGicons.dropbutton, height: 10, color: textColor),
                isFlipped: widget.active),
            SizedBox(width: 10)]);
    } else if (widget.svg != null) {
      child = Row(children: [
        Expanded(child: Container()),
        SvgPicture.asset(widget.svg, height: 18, color: textColor),
        SizedBox(width: 12),
        Text(widget.text, style: Schrift(color: textColor)),
        Expanded(child: Container())
      ]);
    } else {
      child = textWidget;
    }

		double _padding = widget.sortieren ? 0 : 8;

		// Build

		return SizedBox(
				width: widget.width,
				child: RaisedButton(
						padding: EdgeInsets.only(top: _padding, bottom: _padding),
						color: widget.gefuellt ? buttonFarbe : Farben.weiss,
						highlightColor:
						widget.gefuellt ? highlightColor : Farben.weissHighlight,
						shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(5.0),
								side: widget.gefuellt ? BorderSide.none : BorderSide(
										color: buttonFarbe, width: 1.6)),
						onPressed: widget.onPressed,
						child: child));
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
																			color: Farben.hellgrau, width: 3)))),
											AnimatedPositioned(
													left: _value ? 70 : 0,
													duration: Duration(milliseconds: 200),
													child: AnimatedContainer( // Button-Knopf
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

class CustomDropDownButton extends StatelessWidget {

	// ------------------------------- Variablen --------------------------------

	// @formatter:off
	final String 			 header;
	final TextStyle 	 headerstyle;
	final List<String> contains;
	final Wrapper 		 selected;
	// @formatter:on
	CustomDropDownButton(
			{this.header = 'Header', this.headerstyle = const Schrift(), @required this.selected, this.contains = const [
			]});

	@override
	Widget build(BuildContext context) {
		return Column(children: [
			Container(child: Align(alignment: Alignment.centerLeft,
					child: Text(header, style: headerstyle))), SizedBox(height: 7),
			_CustomDropDown(selected: selected, contains: contains)
		]);
	}

}

class _CustomDropDown extends StatefulWidget {

	final List<String> contains;
	final Wrapper selected;

	_CustomDropDown({this.contains = const [], @required this.selected});

	@override
	_CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<_CustomDropDown> {
	bool _istAusgeklappt = false;
	BoxBorder _border = Border.all(color: Farben.blaugrau, width: 1);
	Duration _animationDuration = Duration(milliseconds: 50);
	OverlayEntry _overlayEntry;
	LayerLink _layerLink = LayerLink();
	List<Widget> _selectable = [];

	@override
	void initState() {
		for (var s in widget.contains)
			_selectable.addAll([InkWell(child: Container(width: double.infinity,
					height: 40,
					child: Text('$s', style: Schrift())),
					onTap: () {
						// TODO Lösche aktuell ausgewähltes aus Liste und füge zuletzt ausgefwähltes Element wieder hinzu
						widget.selected.value = s;
						_closeMenu();
					})]);
		super.initState();
	}


	@override
	Widget build(BuildContext context) {
		double radius = _istAusgeklappt ? 0 : 10;
		return CompositedTransformTarget(
				link: this._layerLink,
				child: Container(
						width: double.infinity,
						height: 40,
						child: Stack(children: [
							AnimatedContainer(
									child: Align(alignment: Alignment.centerLeft,
											child: Text('${widget.selected.value}', style: Schrift())),
									padding: EdgeInsets.only(left: 11),
									duration: _animationDuration,
									height: 40,
									width: double.infinity,
									decoration: BoxDecoration(
											color: Farben.weiss,
											border: _border,
											borderRadius: BorderRadius.only(
													topLeft: Radius.circular(10),
													topRight: Radius.circular(10),
													bottomLeft: Radius.circular(radius),
													bottomRight: Radius.circular(radius)))),
							Align(
									alignment: Alignment.centerRight,
									child: AnimatedContainer(
											duration: _animationDuration,
											height: 40,
											width: 40,
											decoration: BoxDecoration(
													color: Farben.weiss,
													border: _border,
													borderRadius: BorderRadius.only(
															topRight: Radius.circular(10),
															bottomRight: Radius.circular(radius))),
											child: Stack(
													children: [
														Align(
																alignment: Alignment.center,
																child: Container(
																		height: 12,
																		width: 12,
																		child: Flippable(back: SvgPicture.asset(
																				SVGicons
																						.dreieck, color: Farben.blaugrau),
																				front: SvgPicture.asset(SVGicons
																						.dreieck,
																						color: Farben.blaugrau),
																				isFlipped: !_istAusgeklappt,
																				duration: Duration(milliseconds: 230))))]))),
							AnimatedContainer(
									duration: _animationDuration,
									height: 40,
									width: double.infinity,
									decoration: BoxDecoration(
											borderRadius: BorderRadius.only(
													topLeft: Radius.circular(10),
													topRight: Radius.circular(10),
													bottomLeft: Radius.circular(radius),
													bottomRight: Radius.circular(radius))),
									child: InkWell(
										onTap: () => _handleDropDown(),
									))])));
	}

	_handleDropDown() {
		if (_istAusgeklappt)
			_closeMenu();
		else
			_openMenu();
	}

	OverlayEntry _overlayEntryBuilder() {
		RenderBox renderBox = context.findRenderObject();
		var size = renderBox.size;

		return OverlayEntry(builder: (context) {
			return Positioned(
					width: size.width,
					child: CompositedTransformFollower(
							link: this._layerLink,
							showWhenUnlinked: false,
							offset: Offset(0.0, size.height - 1), child: Material(
							color: Colors.transparent,
							child: Container(
									decoration: BoxDecoration(borderRadius: BorderRadius.only(
											bottomLeft: Radius.circular(10),
											bottomRight: Radius.circular(10)),
											color: Farben.weiss,
											border: _border),
									padding: EdgeInsets.only(
											bottom: 3, top: 16, left: 11, right: 11),
									child: Align(
											alignment: Alignment.topLeft,
											child: Column(children: _selectable))))));
		});
	}

	_openMenu() {
		_overlayEntry = _overlayEntryBuilder();
		Overlay.of(context).insert(_overlayEntry);
		setState(() {
			_istAusgeklappt = !_istAusgeklappt;
		});
	}

	_closeMenu() {
		_overlayEntry.remove();
		setState(() {
			_istAusgeklappt = !_istAusgeklappt;
		});
	}
}


class Flippable extends StatelessWidget {
	final bool isFlipped;
	final Widget front;
	final Widget back;
	final Duration duration;

	Flippable(
			{this.isFlipped = false, this.front, this.back, this.duration = const Duration(
					milliseconds: 700)});

	@override
	Widget build(BuildContext context) {
		return TweenAnimationBuilder(
				duration: duration,
				curve: Curves.easeOut,
				tween: Tween(
						begin: isFlipped ? 180.0 : 0.0, end: !isFlipped ? 180.0 : 0.0),
				builder: (context, value, child) {
					var content = value >= 90 ? back : front;
					return RotationX(
							rotationX: value,
							child: content);
				});
	}
}

class RotationX extends StatelessWidget {
	static const double degrees2Radians = pi / 180;

	final Widget child;
	final double rotationX;

	const RotationX({Key key, @required this.child, this.rotationX = 0})
			: super(key: key);

	@override
	Widget build(BuildContext context) {
		return Transform(
				alignment: FractionalOffset.center,
				transform: Matrix4.identity()
					..setEntry(3, 2, 0.001)
					..rotateX(rotationX * degrees2Radians),
				child: child);
	}
}