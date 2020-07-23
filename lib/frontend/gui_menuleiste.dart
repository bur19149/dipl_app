import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Leiste extends StatefulWidget {
  final VoidCallback home, meineTermine, adminBereich;
  final bool admin;

  Leiste({this.home, this.meineTermine, this.adminBereich, this.admin = false});

  @override
  State<StatefulWidget> createState() => _LeisteState();
}

class _LeisteState extends State<Leiste> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: 90,
            padding: EdgeInsets.only(left: 11, right: 11),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: LeistenButton(
                  text: 'Home',
                  onPressed: widget.home,
                  svg: svgIcons['haus'],
                  admin: widget.admin,
                )),
                SizedBox(width: 10),
                Expanded(
                    child: LeistenButton(
                  text: 'Meine Termine',
                  onPressed: widget.meineTermine,
                  svg: svgIcons['kalender'],
                  admin: widget.admin,
                )),
                SizedBox(width: 10),
                widget.admin ?
                Expanded(
                    child: LeistenButton(
                  text: 'Admin Bereich',
                  onPressed: widget.adminBereich,
                  svg: svgIcons['administrator'],
                  admin: widget.admin,
                )) : Container(),
              ],
            )));
  }
}

class LeistenButton extends StatefulWidget {
  final String text, svg;
  final VoidCallback onPressed;
  final bool active, admin;

  LeistenButton(
      {@required this.text,
      this.onPressed,
      this.active,
      @required this.svg,
      this.admin = false});

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<LeistenButton> {
  bool _active;

  @override
  void initState() {
    _active = widget.active;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        child: RaisedButton(
            onPressed: widget.onPressed,
            child: LeistenButtonChild(
              text: widget.text,
              admin: widget.admin,
              svg: widget.svg,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              /*side: BorderSide(color: Colors.red)*/
            )));
  }
}

class LeistenButtonChild extends StatefulWidget {
  final bool admin;
  final String text, svg;

  LeistenButtonChild(
      {this.admin = false, @required this.text, @required this.svg});

  @override
  State<StatefulWidget> createState() => _LeistenButtonChildState();
}

class _LeistenButtonChildState extends State<LeistenButtonChild> {
  @override
  Widget build(BuildContext context) {
    return widget.admin
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(widget.svg, height: 17, color: Farben.schwarz),
            SizedBox(height: 5),
            Text(
              widget.text,
              style: TextStyle(fontSize: 9),
            )
          ])
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(widget.svg, height: 17, color: Farben.schwarz),
            SizedBox(width: 5),
            Text(
              widget.text,
              style: TextStyle(fontSize: 9),
            )
          ]);
  }
}

class AdminMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MenuBox(),
      SizedBox(
        height: 10,
      ),
      MenuBox()
    ]);
  }
}

class MenuBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MenuBoxState();
}

class _MenuBoxState extends State<MenuBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
            color: Farben.weiss,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))
            ],
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.grau, width: 1)));
  }
}
