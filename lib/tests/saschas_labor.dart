import 'package:dipl_app/frontend/pages/gui_admin_terminuebersicht.dart';
import 'package:dipl_app/backend/objects.dart' as objects;
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dipl_app/Root.dart';
import 'package:dipl_app/main.dart';

import '../frontend/pages/gui_admin_registrierte_user.dart';


class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}
// @formatter:off
class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TempButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => testeRegistrierteUser())), text: 'testeRegistrierteUser'),
      TempButton(onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => testeSortierMenu())), text: 'testeSortierButton'),
      TempButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context)=> Root())), text: 'Standardmenü-Test'),
      TempButton(onPressed:() => Navigator.push(context, MaterialPageRoute(builder: (context)=> AdminTerminUebersichtPage())), text: 'AdminTerminÜbersichtPage'),]);
  }
// @formatter:on

  Widget testeSortierMenu() {
    return TempSeite(children: [SortierMenu()]);
  }

  Widget testeRegistrierteUser() {
    return TempSeite(children: [
      UserRahmen(objects.User(
          01,
          'Jon',
          'Doe',
          'JonDoe@gmail.com',
          '1210',
          'New York',
          objects.UserTyp(1259, 'User', null),
          'Die Coolen Spritzen',
          null,
          null,
          true))]);
  }
}