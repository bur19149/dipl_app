import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// TODO gui_ladeseite.dart loeschen

class Ladeseite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Align(alignment: Alignment.center,
            child:
                SvgPicture.asset(SVGicons.appicon, color: Farben.dunkelgrau, height: 180)));
  }
}
