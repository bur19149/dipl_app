import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/material.dart';

class Rahmen extends StatefulWidget {
  final List<Widget> children;

  Rahmen({this.children = const []});

  @override
  State<StatefulWidget> createState() => _RahmenState();
}

class _RahmenState extends State<Rahmen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Farben.schwarz,
        padding: EdgeInsets.only(bottom: 30, top: 30, left: 15, right: 15),
        child: Column(children: widget.children));
  }
}
