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
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: AnimatedContainer(
                    color: Colors.blue,
                    width: fieldExpanded ? 200 : 0,
                    duration: Duration(milliseconds: 500),
                    child: TextField())),
            Align(
                alignment: Alignment.centerLeft,
                child: LeistenButton(
                  onPressed: _buttonPressed,
                ))
          ],
        ));
  }
}

class LeistenTextfield extends StatefulWidget {
  final bool fieldExpanded;

  const LeistenTextfield({this.fieldExpanded = false});

  @override
  State<StatefulWidget> createState() => _LeistenTextfieldState();
}

class _LeistenTextfieldState extends State<LeistenTextfield> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        color: Colors.blue,
        width: widget.fieldExpanded ? 200 : 0,
        duration: Duration(milliseconds: 500),
        child: TextField());
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
          color: Farben.rot,
        ));
  }
}
