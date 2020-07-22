//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'gui_konstanten.dart';
//
//class BreiterButton extends StatelessWidget{
//
//  final String text;
//  final Farbe farbe;
//
//  BreiterButton({@required this.text, @required this.farbe});
//
//
//  @override
//  Widget build(BuildContext context) {
//    return RaisedButton(child: Text(text, style: TextStyle(height: Groesse.klein,),),);
//  }
//
//}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'gui_konstanten.dart';

class CustomToggleButton extends StatefulWidget {
  /// Standardwert = true
  final bool value;

  /// Eventhandler
  final GestureTapCallback onTap;

  /// Groesse (Breite)
  final double size;

  CustomToggleButton(
      {this.size = 70, this.value = true, @required this.onTap, Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  bool _value = true;

  void _changeValue() {
    setState(() {
      _value = !_value;
      widget.onTap.call();
    });
  }

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

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
                            height: 50,
                            width: 130,
                            decoration: BoxDecoration(
                                color: Farben.grau,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(11)),
                                border: Border.all(
                                    color: Farben.hellgrau, width: 3)),
                          )),
                      AnimatedPositioned(
                          left: _value ? 70 : 0,
                          duration: Duration(milliseconds: 200),
                          child: AnimatedContainer(
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
