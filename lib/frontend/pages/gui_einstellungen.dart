import 'package:dipl_app/backend/objects.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:flutter/material.dart';

import '../gui_pages.dart';
import '../gui_rahmen.dart';
import '../gui_text.dart';

class EinstellungenPage extends StatelessWidget {
  final User user;

  const EinstellungenPage({this.user});

  @override
  Widget build(BuildContext context) {
    print(user);
    return ColumnScaffold(
        top: MediaQuery.of(context).size.height / 6,
        children: [
          Rahmen(
              header: TopHeader(
                  text: 'Mein Account',
                  farbe: Farben.hellgrau,
                  textfarbe: Farben.dunkelgrau),
              children: [
                Table(columnWidths: {
                  0: FixedColumnWidth(120)
                }, children: [
                  TableRow(children: [
                    Container(
                        height: 25,
                        child:
                            Text('Vorname(n):', style: Schrift.ueberschrift())),
                    Text('${user?.vorname}', style: Schrift())
                  ]),
                  TableRow(children: [
                    Container(
                        height: 25,
                        child:
                            Text('Nachname:', style: Schrift.ueberschrift())),
                    Text('${user?.nachname}', style: Schrift())
                  ]),
                  TableRow(children: [
                    Container(
                        height: 25,
                        child: Text('E-Mail:', style: Schrift.ueberschrift())),
                    Text('${user?.email}',
                        style: Schrift(color: Farben.rot))
                  ])
                ])
              ]),
          Teiler(rahmenTrenner: true),
          Rahmen(
              header: TopHeader(
                  text: 'Zugeordnete Kinder-Accounts',
                  farbe: Farben.hellgrau,
                  textfarbe: Farben.dunkelgrau),
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('keine', style: Schrift()))
              ])
        ]);
  }
}
