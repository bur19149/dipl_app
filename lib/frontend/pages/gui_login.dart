import 'package:dipl_app/frontend/gui_pages.dart';
import 'package:flutter/material.dart';

import '../gui_buttons.dart';
import '../gui_eingabefelder.dart';
import '../gui_konstanten.dart';
import '../gui_rahmen.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(
      children: [
        LoginRahmen(children: [
          Textfeld(
            text: 'Token',
            hintText: 'Token eingeben',
            maxLength: 8,
          ),
          SizedBox(height: 20),
          Button(text: 'Anmelden', onPressed: () {}, farbe: Buttonfarbe.rot)
        ])
      ],
    );
  }
}
