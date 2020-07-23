import 'package:flutter/material.dart';

import 'gui_konstanten.dart';

class Topleiste extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopleisteState();
}

class _TopleisteState extends State<Topleiste> {
  bool fieldExpanded = false;

  void _buttonPressed() {
    setState(() {
      fieldExpanded = !fieldExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(children: [
        AnimatedContainer(
            duration: Duration(milliseconds: 80),
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 0.03,
                      color: Color.fromRGBO(0, 0, 0, fieldExpanded ? 0.18 : 0),
                      offset: Offset(3, 3))
                ]))),
        Expanded(
            child: SizedBox(
                height: 50,
                child: Stack(children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedContainer(
                          decoration: BoxDecoration(
                              color: Farben.weiss,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 7,
                                    spreadRadius: 0.03,
                                    color: Color.fromRGBO(0, 0, 0, 0.18),
                                    offset: Offset(3, 3))
                              ],
                              border: Border(
                                top: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              )),
                          width: fieldExpanded
                              ? MediaQuery.of(context).size.width
                              : 0,
                          duration: Duration(milliseconds: 80),
                          child: LeistenTextfield()))
                ]))),
        AnimatedContainer(
            duration: Duration(milliseconds: 80),
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 7,
                      spreadRadius: 0.03,
                      color: Color.fromRGBO(0, 0, 0, fieldExpanded ? 0.18 : 0),
                      offset: Offset(3, 3))
                ])))
      ]),
      Row(children: [
        LeistenButton(onPressed: _buttonPressed),
        Expanded(child: Container()),
        LeistenButton(onPressed: _buttonPressed)
      ])
    ]);
  }
}

class LeistenTextfield extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeistenTextfieldState();
}

class _LeistenTextfieldState extends State<LeistenTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}

class LeistenButton extends StatefulWidget {
  final GestureTapCallback onPressed;

  const LeistenButton({this.onPressed});

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<LeistenButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: Farben.weiss,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))
            ],
          ),
        ));
  }
}
