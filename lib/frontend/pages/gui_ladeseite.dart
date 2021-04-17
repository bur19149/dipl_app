import 'package:dipl_app/backend/requests/login.dart';
import 'package:dipl_app/frontend/pages/gui_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../gui_konstanten.dart';
import '../gui_pages.dart';
import 'gui_termin_bearbeiten.dart';

class Ladeseite extends StatefulWidget {
  @override
  _LadeseiteState createState() => _LadeseiteState();
}

class _LadeseiteState extends State<Ladeseite> {

  @override
  void initState() {
    super.initState();
    try {
      validate();
    } catch (e) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
      );
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => TerminBearbeitenPage()),
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(SVGicons.appicon,
                color: Farben.dunkelgrau, height: 180)));
  }
}

//import 'package:dipl_app/backend/requests/login.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';
//
//import '../gui_konstanten.dart';
//import '../gui_pages.dart';
//
//class Ladeseite extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
////    try {
////      throw 'Test';
////    } catch (e) {
////      CustomSnackbar.showErrSnackbar(context, text: e);
////    }
//    return Scaffold(
//        body: Align(
//            alignment: Alignment.center,
//            child: SvgPicture.asset(SVGicons.appicon,
//                color: Farben.dunkelgrau, height: 180)));
//  }
//}
