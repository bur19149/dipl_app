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

  Textfeld textfeld = Textfeld(
      text: 'Token',
      headerStyle: Schrift.ueberschrift(),
      hintText: 'Token eingeben',
      maxLength: 8,
      validator: (val) =>
          RegExp('[0-9A-Za-z]{8}').hasMatch(val) ? null : 'ungüliges Passwort');

  @override
  Widget build(BuildContext context) {
    return ListViewScaffold(children: [
      LoginRahmen(children: [
        textfeld,
        SizedBox(height: 20),
        Button(text: 'Anmelden', farbe: Buttonfarbe.rot, onPressed: () {
          login(textfeld.value.value);
          if(validate()){
        //TODO load next Page
          }})])]);
  }
}
