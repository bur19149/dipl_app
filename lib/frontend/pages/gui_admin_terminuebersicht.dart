import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/backend/requests/admin.dart';
import 'package:flutter/material.dart';
import '../gui_konstanten.dart';
import '../gui_buttons.dart';
import '../gui_text.dart';

class AdminTerminUebersichtPage extends StatefulWidget {
  @override
  _AdminTerminUebersichtPageState createState() => _AdminTerminUebersichtPageState();
}

class _AdminTerminUebersichtPageState extends State<AdminTerminUebersichtPage> {

  TextEditingController controller = TextEditingController();
  // Future<List<UserTermin>> abc = Termin.requestTerminListe(false);


  @override
  Widget build(BuildContext context) {
    return Menuleiste(
      admin: true,
      scaffoldHome: Scaffold(
          body: ListView(padding: EdgeInsets.only(left: 15, right: 15, top: 80),
            children: [
              SortierMenu(),
          ],)
      ));
  }
}

class SortierMenu extends StatefulWidget {
  @override
  _SortierMenuState createState() => _SortierMenuState();
}

class _SortierMenuState extends State<SortierMenu> {
  bool _aufsteigend = false;
  bool _archiv = false;
  bool _jahr = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Text('Sortieren nach:', style: Schrift()),
        SizedBox(width: 10),
        Expanded(
            child: Button(
                text: 'Jahr',
                onPressed: () => setState(() {
                  if (_jahr)
                    _aufsteigend = !_aufsteigend;
                  else
                    _jahr = !_jahr;
                }),
                sortieren: _jahr,
                farbe: Buttonfarbe.rot,
                gefuellt: _jahr,
                active: _aufsteigend)),
        SizedBox(width: 7),
        Expanded(
            child: Button(
                text: 'Monat',
                onPressed: () => setState(() {
                  if (!_jahr)
                    _aufsteigend = !_aufsteigend;
                  else
                    _jahr = !_jahr;
                }),
                sortieren: !_jahr,
                farbe: Buttonfarbe.rot,
                gefuellt: !_jahr,
                active: _aufsteigend))]),
      SizedBox(height: 10),
      Button( onPressed: () => setState(() {
        if (_archiv) _archiv = !_archiv;
      }),
          text: 'Alle anstehenden Termine',
          farbe: Buttonfarbe.rot,
          gefuellt: !_archiv),
      Button(
          onPressed: () => setState(() {
            if (!_archiv) _archiv = !_archiv;
          }),
          text: 'Archiv',
          farbe: Buttonfarbe.rot,
          gefuellt: _archiv)]);
  }
}