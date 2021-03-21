
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../gui_konstanten.dart';

class Ladeseite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // TODO gui_ladeseite.dart eventuell loeschen

    return Scaffold(
        body: Align(alignment: Alignment.center,
            child:
                SvgPicture.asset(SVGicons.appicon, color: Farben.dunkelgrau, height: 180)));
  }
}
