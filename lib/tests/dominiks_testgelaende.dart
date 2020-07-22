import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter/material.dart';

class DominiksTestgelaende extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DominiksTestgelaendeState();
}

class _DominiksTestgelaendeState extends State<DominiksTestgelaende> {
  bool offen = true;

  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      CustomToggleButton(onTap: () {
        setState(() {
          offen = !offen;
        });
      }),
      SizedBox(height: 150),
      //Rahmen(children: [Container(height: 100, width: double.infinity, color: Farben.gruen,)],)
      Kreuz(offen: offen)
    ]);
  }
}

class Kreuz extends StatefulWidget {
  final bool offen;
  final Duration duration = Duration(milliseconds: 1000);

  Kreuz({this.offen = false});

  @override
  State<StatefulWidget> createState() => _KreuzState();
}

class _KreuzState extends State<Kreuz> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {

    if(widget.offen) _controller.forward(); else _controller.reset();

    return Container(
        height: 60,
        width: 60,
        child: Align(
            alignment: Alignment.center,
            child: Stack(children: [
              RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          color: Farben.rot,
                          height: widget.offen ? 0 : 50,
                          width: 11.5,
                          duration: widget.duration,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Farben.rot,
                          height: 11.5,
                          width: 50,
                        ))
                  ]))
            ])));
  }
}