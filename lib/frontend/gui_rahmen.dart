import 'package:dipl_app/backend/requests/admin.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/material.dart';

class Rahmen extends StatefulWidget {
  final List<Widget> children;
  final Widget header;

  Rahmen({this.children = const [], this.header});

  @override
  State<StatefulWidget> createState() => _RahmenState();
}

class _RahmenState extends State<Rahmen> {
  @override
  Widget build(BuildContext context) {
    Widget topWidget = Container(), bottomWidget = Container();

    if (widget.header is LoginHeader || widget.header is TopHeader)
      topWidget = widget.header;
    if (widget.header is BottomHeader) bottomWidget = widget.header;

    List<Widget> children = [];
    children.addAll([
      topWidget,
      Padding(
          padding: EdgeInsets.only(bottom: 25, top: 20, left: 15, right: 15),
          child: Column(children: widget.children)),
      bottomWidget
    ]);

    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 0.03,
                  color: Color.fromRGBO(0, 0, 0, 0.18),
                  offset: Offset(3, 3))
            ],
            color: Farben.weiss,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Farben.rahmenFarbe, width: 1)),
        child: Column(children: children));
  }
}

class TerminRahmen extends StatefulWidget {
  final List<Widget> children;

  TerminRahmen({this.children = const []});

  @override
  State<StatefulWidget> createState() => _TerminRahmenState();
}

class _TerminRahmenState extends State<TerminRahmen> {
  bool _offen = false;

  void _oeffnen() {
    setState(() {
      _offen = !_offen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _oeffnen,
        child: Stack(children: [
          Rahmen(children: widget.children, header: BottomHeader()),
          Positioned(
              right: 15,
              top: 15,
              child: Kreuz(
                offen: _offen,
                groesse: 0.6,
              ))
        ]));
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 90, // TODO
        decoration: BoxDecoration(
            color: Farben.rot,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.5),
                topRight: Radius.circular(9.5))));
  }
}

class BottomHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        decoration: BoxDecoration(
            color: Farben.gruen, // TODO variabel
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9.5),
                bottomRight: Radius.circular(9.5))));
  }
}

class TopHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        decoration: BoxDecoration(
            color: Farben.gruen, // TODO variabel
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(9.5),
                topRight: Radius.circular(9.5))));
  }
}

class Kreuz extends StatefulWidget {
  final bool offen;
  final Duration duration = Duration(milliseconds: 250);
  final double groesse;

  Kreuz({this.offen = false, this.groesse = 1});

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
  void didUpdateWidget(Kreuz oldWidget) {
    if (widget.offen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60 * widget.groesse,
        width: 60 * widget.groesse,
        child: Align(
            alignment: Alignment.center,
            child: Stack(children: [
              RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          color: Farben.rot,
                          height: widget.offen ? 0 : 50 * widget.groesse,
                          width: 11.5 * widget.groesse,
                          duration: widget.duration,
                        )),
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Farben.rot,
                          height: 11.5 * widget.groesse,
                          width: 50 * widget.groesse,
                        ))
                  ]))
            ])));
  }
}
