import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:flutter/material.dart';
import 'package:dipl_app/main.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dipl_app/frontend/gui_buttons.dart';

class SaschasLabor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SaschasLaborState();
}

class _SaschasLaborState extends State<SaschasLabor> {
  @override
  Widget build(BuildContext context) {
    return TempSeite(children: [SortierMenu()]);
  }
}

class SortierMenu extends StatefulWidget {
  @override
  _SortierMenuState createState() => _SortierMenuState();
}

class _SortierMenuState extends State<SortierMenu> {
  bool _archiv = false;
  bool _aufsteigend = false;
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
                active: _aufsteigend)),
      ]),
      SizedBox(height: 10),
      Button(
          onPressed: () => setState(() {
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
          gefuellt: _archiv),
      Text('$_archiv, $_aufsteigend, $_jahr')
    ]);
  }
}
