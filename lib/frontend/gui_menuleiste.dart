import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:dipl_app/frontend/gui_topLeiste.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

/// Navigationsleiste
class Menuleiste extends StatefulWidget {
  // TODO scaffold ev. gegen anderes Widget austauschen
  // ------------------------------- Variablen --------------------------------

	// @formatter:off
  final Scaffold							scaffold; 						 // Scaffold unter der Menüleiste
  final bool     							admin;    						 // Ist der Nutzer ein Admin oder ein User?
	final TextEditingController textEditingController; // Controller für Suchfeld in Topleiste
  // @formatter:on

	// ------------------------------ Konstruktor -------------------------------

	Menuleiste({this.scaffold = const Scaffold(), this.admin = false, this.textEditingController});

	// ------------------------------- createState ------------------------------

	@override
	State<StatefulWidget> createState() => _MenuleisteState();
}

class _MenuleisteState extends State<Menuleiste> {
	// ------------------------------- Variablen --------------------------------

	// @formatter:off
  bool home         = true;  // Wird das Home-Menü gerade angezeigt?
  bool meineTermine = false; // Wird das Meine-Termine-Menü gerade angezeigt?
  bool adminMenu    = false; // Wird das Admin-Menü gerade angezeigt?
  PageController pageController;
  // @formatter:on

	// -------------------------------- initState -------------------------------

	@override
	void initState() {
		pageController = PageController();
		super.initState();
	}

	// ------------------------------ Eventhandler ------------------------------
// @formatter:off
  void handleHome() {
    setState(() {
      if (!home) {
        home = true;
        meineTermine = false;
        pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.linear);
      }
      adminMenu = false;
    });
  }
// @formatter:on
	void handleMeineTermine() {
		setState(() {
			if (!meineTermine) {
				home = false;
				meineTermine = true;
				pageController.animateToPage(1,
						duration: Duration(milliseconds: 200), curve: Curves.linear);
			}
			adminMenu = false;
		});
	}

	void showAdminMenu() {
		setState(() {
			adminMenu = !adminMenu;
		});
	}

	void swipeHandler(int page) {
		setState(() {
			if (page == 0) {
				home = true;
				meineTermine = false;
				adminMenu = false;
			} else if (page == 1) {
				home = false;
				meineTermine = true;
				adminMenu = false;
			}
		});
	}

	// --------------------------------- Build ----------------------------------
// @formatter:off
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
          PageView(
            controller: pageController,
            onPageChanged: (page) => swipeHandler(page),
            children: [
              widget.scaffold,
              Scaffold(
                body: Center(child: Text('Seite 2'))),
          /*Scaffold(
            body: Center(child: Text('Seite 3')),
          )*/ //TODO ka
        ]),
          Align(alignment: Alignment.topCenter,
                child: Container(height: 60,
                    child: Material(color: Colors.transparent,
                        child: Topleiste(controller: widget.textEditingController)), margin: EdgeInsets.all(10))),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(255, 255, 255, 100),
                          Color.fromRGBO(255, 255, 255, 0),
                        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)))),
          // TODO Farbe ändern
          widget.admin ? AnimatedPositioned(
              right: adminMenu ? 11 : -220,
              bottom: adminMenu ? 85 : -510,
              curve: Curves.easeOutExpo,
              duration: Duration(milliseconds: 500),
              child: AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOutCirc,
                  opacity: adminMenu ? 1 : 0,
                  child: _AdminMenu())) : Container(),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 90,
                  padding: EdgeInsets.only(left: 11, right: 11),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: _LeistenButton(
                            text: 'Home',
                            onPressed: handleHome,
                            svg: SVGicons.haus,
                            admin: widget.admin,
                            active: home)),
                      SizedBox(width: 10),
                      Expanded(
                          child: _LeistenButton(
                            text: 'Meine Termine',
                            onPressed: handleMeineTermine,
                            svg: SVGicons.kalender,
                            admin: widget.admin,
                            active: meineTermine)),
                      SizedBox(width: 10),
                      widget.admin ? Expanded(
                          child: _LeistenButton(
                            text: 'Admin Bereich',
                            onPressed: showAdminMenu,
                            svg: SVGicons.administrator,
                            admin: widget.admin,
                            active: adminMenu,)) : Container()])))]));
  } // @formatter:on
}

/// In der Navigationsleiste enthaltener Button
class _LeistenButton extends StatefulWidget {
	// ------------------------------- Variablen --------------------------------

	// @formatter:off
  final String       text;      // Textinhalt des Buttons
  final String       svg;       // Icon des Buttons
  final bool         active;    // Befindet sich der Nutzer aktuell in dem Menütab des Buttons?
  final bool         admin;     // Ist der Nutzer ein Admin oder ein User?
  final VoidCallback onPressed; // Eventhandler
  // @formatter:on

	// ------------------------------ Konstruktor -------------------------------

	_LeistenButton({@required this.text,
		this.onPressed,
		this.active,
		@required this.svg,
		this.admin = false});

	// ------------------------------- createState ------------------------------

	@override
	State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<_LeistenButton> {
	// --------------------------------- Build ----------------------------------
// @formatter:off
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: RaisedButton(
            onPressed: widget.onPressed,
            child: _LeistenButtonChild(
              text: widget.text,
              admin: widget.admin,
              svg: widget.svg,
              active: widget.active),
            color: Farben.weiss,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: widget.active ? Farben.rot : Farben.blaugrau,
                    width: 1))));
  } // @formatter:off
}

/// Buttoninhalt der Navigationsleiste
/// Enthält einen Text und ein Icon im SVG-Format
class _LeistenButtonChild extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  // @formatter:off
  final bool   active; // Befindet sich der Nutzer aktuell in dem Menütab des Buttons?
  final bool   admin;  // Ist der Nutzer ein Admin oder ein User?
  final String text;   // Textinhalt des Buttons
  final String svg;    // Icon des Buttons
  // @formatter:on

	// ------------------------------ Konstruktor -------------------------------

	_LeistenButtonChild(
			{this.admin = false, @required this.text, @required this.svg, this.active = false});

	// ------------------------------- createState ------------------------------

	@override
	State<StatefulWidget> createState() => _LeistenButtonChildState();
}

class _LeistenButtonChildState extends State<_LeistenButtonChild> {
	// --------------------------------- Build ----------------------------------
// @formatter:off
  @override
  Widget build(BuildContext context) {
    Color color = widget.active ? Farben.rot : Farben.blaugrau;
    return widget.admin ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SvgPicture.asset(widget.svg, height: 17, color: color),
      SizedBox(height: 5),
      Text(widget.text,
        style: Schrift(
            fontSize: Groesse.klein,
            fontWeight: FontWeight.w500,
            color: color))]) : Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(widget.svg, height: 17, color: color),
              SizedBox(width: 7),
              Text(widget.text,
                style: Schrift(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: color))]);
  } // @formatter:off
}

/// Admin-Bereich Untermenü
class _AdminMenu extends StatefulWidget {
  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<_AdminMenu> {
  // --------------------------------- Build ----------------------------------
//@foramtter:off
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: Column(children: [
      _MenuBox(children: [
        _AdminMenuText('Vollständige Termin Liste'),
        _AdminMenuText('Neuen Termin anlegen')]),
      SizedBox(height: 10),
      _MenuBox(children: [
        _AdminMenuText('User Einstellungen'),
        _AdminMenuText('Registrierte User'),
        _AdminMenuText('Neuen User anlegen')
      ])]));
  } //@foramtter:on
}

/// Text innerhalb des Admin-Menüs
class _AdminMenuText extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final String text;

  // ------------------------------ Konstruktor -------------------------------

  const _AdminMenuText(this.text);

  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _AdminMenuTextState();
}

class _AdminMenuTextState extends State<_AdminMenuText> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            padding: EdgeInsets.only(right: 10, top: 11, bottom: 11),
            child: Text(
                widget.text,
                style: Schrift(fontSize: 18, fontWeight: FontWeight.w600
                ))));
  }
}


/// Box des Admin-Bereich Untermenüs der Menüleiste
class _MenuBox extends StatefulWidget {
  // ------------------------------- Variablen --------------------------------

  final List<Widget> children;

  // ------------------------------ Konstruktor -------------------------------

  const _MenuBox({this.children});


  // ------------------------------- createState ------------------------------

  @override
  State<StatefulWidget> createState() => _MenuBoxState();
}

class _MenuBoxState extends State<_MenuBox> {
  // --------------------------------- Build ----------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),
        width: 250,
        decoration: BoxDecoration(
            color: Farben.weiss,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.blaugrau, width: 1)),
        child: Column(children: widget.children));
  }
}
