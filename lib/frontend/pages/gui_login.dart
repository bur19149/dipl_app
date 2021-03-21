import 'package:dipl_app/backend/requests/login.dart';
import 'package:dipl_app/frontend/gui_pages.dart';
import 'package:flutter/material.dart';
import '../gui_eingabefelder.dart';
import '../gui_konstanten.dart';
import '../gui_buttons.dart';
import '../gui_rahmen.dart';
import '../gui_text.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Wrapper value;

  @override
  Widget build(BuildContext context) {
    value = Wrapper('xyz');

    Textfeld textfeld = Textfeld(
        text: 'Token',
        headerStyle: Schrift.ueberschrift(),
        hintText: 'Token eingeben',
        maxLength: 8,
        pruefung: Pruefung(
            pruefung: (val) => RegExp('[0-9A-Za-z]{8}').hasMatch(val),
            errortext: 'ungüliges Passwort'));

    return ListViewScaffold(children: [
      LoginRahmen(children: [
        textfeld,
        SizedBox(height: 20),
        Button(
            text: 'Anmelden',
            farbe: Buttonfarbe.rot,
            onPressed: () {
              print('[${value.value}]');
//              try {
//                login(textfeld.val());
//                if (validate())
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) =>
//                              ColumnScaffold(children: [Text('Yay')])));
//              } catch (e) {
//                print(e);
//                CustomSnackbar.showSnackbar(context, text: e.toString());
//              }
            })
      ])
    ]);
  }
}
