import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Leiste extends StatefulWidget {

  final VoidCallback home, meineTermine, adminBereich;

  Leiste({this.home, this.meineTermine, this.adminBereich});

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
            color: Farben.blau,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: LeistenButton(text: 'Test1', onPressed: widget.home,)),
                //Container(height: 50, color: Farben.rot)),
                SizedBox(width: 10),
                Expanded(child: LeistenButton(text: 'Test2', onPressed: widget.meineTermine,)),
                //Container(height: 50, color: Farben.rot)),
                SizedBox(width: 10),
                Expanded(child: LeistenButton(text: 'Test3', onPressed: widget.adminBereich,)),
                //Container(height: 50, color: Farben.rot)),
              ],
            )));
  }
}

class LeistenButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  LeistenButton({@required this.text, this.onPressed});

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<LeistenButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        child: RaisedButton(onPressed: widget.onPressed, child: Text(widget.text),shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    /*side: BorderSide(color: Colors.red)*/)));
  }
}


class AdminMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [MenuBox(), SizedBox(height: 10,), MenuBox()]);
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
