import 'package:dipl_app/backend/objects.dart' as objects;
import 'package:dipl_app/backend/requests/admin.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/frontend/pages/gui_admin_terminuebersicht.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dipl_app/main.dart';

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => testeSortierMenu())), text: 'testeSortierButton'),
      TempButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => testeRegistrierteUser())), text: 'testeRegistrierteUser')]);
  }

  Widget testeSortierMenu() {
    return TempSeite(children: [SortierMenu()]);
  }

  Widget testeRegistrierteUser() {
    return Container();
  }
}




















