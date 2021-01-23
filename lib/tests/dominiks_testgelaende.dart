import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';
import 'package:dipl_app/frontend/pages/gui_termin_bearbeiten.dart';
import 'package:dipl_app/frontend/pages/gui_terminuebersicht.dart';
import 'package:dipl_app/frontend/pages/gui_user_erstellen.dart';
import 'package:dipl_app/frontend/pages/gui_einstellungen.dart';
import 'package:dipl_app/frontend/gui_eingabefelder.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_topLeiste.dart';
import 'package:dipl_app/backend/requests/debug.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_pages.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';

class DominiksTestgelaende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DominiksTestgelaendeState();
}

class _DominiksTestgelaendeState extends State<DominiksTestgelaende> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
			// @formatter:off
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteMenu())),            text: 'Menüleisten-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteWidgets())),         text: 'Widgets-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteSchriftarten())),    text: 'Schriftarten-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteTopleiste())),       text: 'Topleisten-Tests'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminUebersichtPage())), text: 'Terminübersicht-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteDropDownButton())),  text: 'Dropdown-Button-Test'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EinstellungenPage())),    text: 'Teste Einstelungen-Seite'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TerminBearbeitenPage())), text: 'Teste Termin-bearbeiten-Seite'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserErstellenPage())),    text: 'Teste User-erstellen-Seite'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TesteGruppenleiter())),    text: 'Teste Gruppenleiter')
      // @formatter:on
		]);
	}
}

class TesteDropDownButton extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _TesteDropDownButtonState();
}

class _TesteDropDownButtonState extends State<TesteDropDownButton> {
	@override
	Widget build(BuildContext context) {
		return ListViewScaffold(children: [
			Button(onPressed: () {}),
			DropdownButton(
				items: [DropdownMenuItem(child: Text('Hallo'))],
				onChanged: (value) {},
			),
			Textfeld(),
			Container(height: 50),
			CustomDropDownButton(selected: Wrapper(value: 'User'),
				header: 'Berechtigung:',
				contains: [
					'User',
					'Eltern',
					'Gruppenleiter',
					'Admin',
					'Gruppenleiter (Bewerb)'
				],),
			Container(
					height: 1000, color: Colors.white
			)
		]);
	}
}

class TesteTopleiste extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _TesteTopleisteState();
}

class _TesteTopleisteState extends State<TesteTopleiste> {
	@override
	Widget build(BuildContext context) {
		return TempSeite(children: [
			Container(
				//decoration: BoxDecoration(border: Border.all(color: Farben.schwarz)),
					child: Topleiste())
		]);
	}
}

class TesteWidgets extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _TesteWidgetsState();
}

class _TesteWidgetsState extends State<TesteWidgets> {
	bool expanded = false;
	Wrapper dateTime;

	void expand(bool offen) {
		setState(() {
			expanded = offen;
		});
	}

	@override
	void initState() {
		dateTime = Wrapper();
		super.initState();
	}

	@override
	Widget build(BuildContext context) {
		return SafeArea(
				child: Scaffold(
						body: ListView(
								padding:
								EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 50),
								children: [
									Rahmen(header: TopHeader()), Teiler(rahmenTrenner: true),
									ExpandableRahmen(
											childrenTop: [Text('Hallo')],
											childrenBottom: [Text('Hallo Welt')]),
									SizedBox(height: 50),
									Button(
											text: 'print Datum',
											onPressed: () => print('Datum: [${dateTime.value}]')),
									Rahmen(children: [
										Textfeld(dateTime: true,
												text: 'Datum/Uhrzeit von',
												value: dateTime)
									]),
									SizedBox(height: 50),
									Container(height: 100, color: Farben.blau),
									Button(
											text: 'Terminliste',
											onPressed: () async {
												print('1##################');
												var liste = requestAlleTermine();
												printListe(await liste);
												print('2##################');
											})
								])));
	}
}

class TesteMenu extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _TesteMenuState();
}

class _TesteMenuState extends State<TesteMenu> {
	bool admin = true;

	@override
	Widget build(BuildContext context) {
		return Menuleiste(
				admin: admin,
				scaffold: Scaffold(
						body: Center(
								child: RaisedButton(
										onPressed: () {
											setState(() {
												admin = !admin;
											});
										},
										child: Text('change Menu')))));
	}
}

class TesteSchriftarten extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => _TesteSchriftartenState();
}

class _TesteSchriftartenState extends State<TesteSchriftarten> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
				body: SafeArea(
					child: Center(
							child: ListView(
									padding:
									EdgeInsets.only(left: 15, right: 15, top: 30, bottom: 30),
									children: [
										Text('TextfeldText', style: Schrift()),
										Container(
												color: Farben.rot,
												child: Text('Uberschrift', style: Schrift.titel())),
										Text('UnterUberschrift', style: Schrift.ueberschrift()),
										Container(
												color: Farben.blau,
												child: Text('WeisseDickeUberschrift',
														style: Schrift.titelFooter())),
									])),
				));
	}
}

class TesteGruppenleiter extends StatefulWidget {
	@override
	_TesteGruppenleiterState createState() => _TesteGruppenleiterState();
}

class _TesteGruppenleiterState extends State<TesteGruppenleiter> {
	@override
	Widget build(BuildContext context) {
		return TempSeite(children: [
			Rahmen(children: [
				Align(
						alignment: Alignment.centerLeft,
						child: Text('Angemeldete Gruppenleiter',
								style: Schrift.ueberschrift())),
				Teiler(),
				Gruppenleiter()
				// TODO Rahmen durch Column mit Gruppenleitern ersetzen
			])
		]);
	}
}

/// ausklappbarer Rahmen
/// wird bei der Terminübersicht verwendet (Terminkarten)
class Gruppenleiter extends StatefulWidget {
	// ------------------------------- createState ------------------------------
	@override
	State<StatefulWidget> createState() => _GruppenleiterState();
}

class _GruppenleiterState extends State<Gruppenleiter>
		with SingleTickerProviderStateMixin {
	// ------------------------------- Variablen --------------------------------

	// @formatter:off
	bool                _isExpanded;     // Ist der Rahmen sichtbar/ausgefahren?
	AnimationController _controller;     // Controller des Widgets / der Animation, definiert die Animationszeit
	Animation<double>   _heightFactor;   // definiert die Animation (Kurve usw.)
	List<Widget>        _childrenTop;    // immer sichtbarer Teil des Rahmens
	// @ormatter:on

	// ------------------------------ Eventhandler ------------------------------

	void _handleTap() {
		setState(() {
			_isExpanded = !_isExpanded;
			if (_isExpanded) {
				_controller.forward();
			} else {
				_controller.reverse().then<void>((void value) {
					if (!mounted) return;
					setState(() {});
				});
			}
			PageStorage.of(context)?.writeState(context, _isExpanded);
		});
	}

	// -------------------------------- initState -------------------------------

	@override
	void initState() { // @formatter:off
		_controller   = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
		_heightFactor = _controller.drive(CurveTween(curve: Curves.easeIn));
		_isExpanded   = PageStorage.of(context)?.readState(context) ?? false;
		if (_isExpanded) _controller.value = 1.0;
		super.initState();
	} // @formatter:on

	// --------------------------------- Build ----------------------------------
// @formatter:off
	Widget _buildChildren(BuildContext context, Widget child) {
		_childrenTop = [Container(decoration: BoxDecoration(color: Colors.blue,
				borderRadius: BorderRadius.only(
						topLeft: 		 Radius.circular(10),
						topRight: 	 Radius.circular(10),
						bottomRight: Radius.circular(10),
						bottomLeft:  Radius.circular(10))),
				width: double.infinity, height: 50)];
		_childrenTop.addAll([
			ClipRect(child: Align(heightFactor: _heightFactor.value, child: child))]);
		return InkWell(
				splashColor: Colors.transparent,
				highlightColor: Colors.transparent,
				onTap: () => _handleTap(),
				child: Rahmen(padding: EdgeInsets.all(0),
						children: _childrenTop));
	} // @formatter:on

	@override
	Widget build(BuildContext context) {
		final bool closed = !_isExpanded && _controller.isDismissed;
// @formatter:off
		return AnimatedBuilder(
				animation: _controller.view,
				builder: _buildChildren,
				child: closed ? null : Container(
						width: double.infinity,
						child: Align(
								alignment: Alignment.centerLeft,
								child: Column(children: [Text('Bottom')]))));
	} // @formatter:on

	// -------------------------------- Dispose ---------------------------------

	@override
	void dispose() {
		_controller.dispose();
		super.dispose();
	}
}