import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Standardmenu extends StatefulWidget {
  @override
  _StandardmenuState createState() => _StandardmenuState();
}

class _StandardmenuState extends State<Standardmenu> {
  @override
  Widget build(BuildContext context) {
    return Menuleiste(scaffold: Scaffold());
  }
}
