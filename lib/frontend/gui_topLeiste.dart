import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'gui_konstanten.dart';

class Topleiste extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TopleisteState();
}

class _TopleisteState extends State<Topleiste> {
  bool fieldExpanded = false;
  Duration duration;

  void _buttonPressed() {
    setState(() {
      fieldExpanded = !fieldExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    duration = Duration(milliseconds: 80);
    return Stack(children: [
      Row(children: [
        AnimatedContainer(
            duration: duration,
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
                          curve: Curves.easeInQuart,
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
                                top: BorderSide(width: 1, color: Farben.grau),
                                bottom: BorderSide(width: 1, color: Farben.grau),
                              )),
                          width: fieldExpanded
                              ? MediaQuery.of(context).size.width
                              : 0,
                          duration: !fieldExpanded
                              ? Duration(milliseconds: 50)
                              : duration,
                          child: LeistenTextfield()))
                ]))),
        AnimatedContainer(
            duration: duration,
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
        LeistenButton(
            onPressed: _buttonPressed,
            fieldExpanded: fieldExpanded,
            left: true,
            duration: duration,
            svg: svgIcons['einstellungen']),
        Expanded(child: Container()),
        LeistenButton(
            onPressed: _buttonPressed,
            fieldExpanded: fieldExpanded,
            left: false,
            duration: duration,
            svg: svgIcons['lupe'])
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
  final bool fieldExpanded;
  final bool left;
  final Duration duration;
  final String svg;

  LeistenButton(
      {this.onPressed,
      this.fieldExpanded = false,
      this.left = true,
      this.duration,
      @required this.svg});

  @override
  State<StatefulWidget> createState() => _LeistenButtonState();
}

class _LeistenButtonState extends State<LeistenButton> {
  BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    borderRadius = BorderRadius.only(
        bottomLeft:
            Radius.circular(!widget.left && widget.fieldExpanded ? 0 : 10),
        topLeft: Radius.circular(!widget.left && widget.fieldExpanded ? 0 : 10),
        bottomRight:
            Radius.circular(widget.left && widget.fieldExpanded ? 0 : 10),
        topRight:
            Radius.circular(widget.left && widget.fieldExpanded ? 0 : 10));

    return AnimatedContainer(
      child: Material(
          color: Colors.transparent,
          borderRadius: borderRadius,
          child: InkWell(
              borderRadius: borderRadius,
              onTap: widget.onPressed,
              child: Stack(children: [
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(widget.svg,
                        color: Farben.blaugrau, height: 23))
              ]))),
      duration: widget.duration,
      curve: Curves.easeOutExpo,
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Farben.weiss,
        border: Border.all(width: 1, color: Farben.blaugrau),
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
              blurRadius: 7,
              spreadRadius: 0.03,
              color: Color.fromRGBO(0, 0, 0, 0.18),
              offset: Offset(3, 3))
        ],
      ),
    );
  }
}
