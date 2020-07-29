import 'package:dipl_app/backend/objects.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../gui_buttons.dart';
import '../gui_text.dart';
import '../gui_topLeiste.dart';

class TerminUebersichtPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminUebersichtPageState();
}

class _TerminUebersichtPageState extends State<TerminUebersichtPage> {
  List<UserTermin> termine;

  Future _getTermine() async {
    return await requestAlleTermine();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none &&
                      projectSnap.hasData == null) {
                    return Container();
                  }
                  return ListView.builder(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        UserTermin termin = projectSnap.data[index];
                        List<Widget> children = [];
                        if (index == 0)
                          children.addAll([Topleiste(), SizedBox(height: 40)]);
                        children.addAll([
                          _TerminRahmen(
                              name: termin.name,
                              anmeldungEnde: termin.anmeldungEnde,
                              ort: termin.ort,
                              plaetze: termin.plaetze,
                              beschreibung: termin.beschreibung),
                          SizedBox(height: 35)
                        ]);
                        return Column(children: children);
                      });
                },
                future: _getTermine(),
                initialData: [])));
  }
}

class _TerminRahmen extends StatefulWidget {
  final String name, ort, beschreibung;
  final int plaetze;
  final DateTime anmeldungEnde;

  const _TerminRahmen(
      {this.name = 'Name',
      this.anmeldungEnde,
      this.ort = 'Ort',
      this.plaetze = 0,
      this.beschreibung = 'Beschreibung'});

  @override
  State<StatefulWidget> createState() => _TerminRahmenState();
}

class _TerminRahmenState extends State<_TerminRahmen> {
  DateTime anmeldungEnde;

  @override
  void initState() {
    anmeldungEnde = widget.anmeldungEnde ?? DateTime(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableRahmen(
      header: widget.name,
      bottomHeader:
          'Anmeldung offen bis ${DateFormat('dd.MM.yyyy kk:mm').format(anmeldungEnde)}',
      childrenTop: [
        Row(children: [
          Placeholder(fallbackHeight: 20, fallbackWidth: 20),
          SizedBox(width: 10),
          Wrap(children: [
            Text('01.11.2019 - 20:20 Uhr bis 23:20 Uhr',
                style: Schrift())
          ])
        ]),
        SizedBox(height: 5),
        Row(children: [
          Placeholder(fallbackHeight: 20, fallbackWidth: 20),
          SizedBox(width: 10),
          Wrap(children: [
            Text(widget.ort, style: Schrift())
          ])
        ]),
        SizedBox(height: 5),
        Row(children: [
          Placeholder(fallbackHeight: 20, fallbackWidth: 20),
          SizedBox(width: 10),
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      fontSize: Groesse.normal,
                      color: Farben.blaugrau,
                      fontFamily: appFont,
                      fontWeight: FontWeight.w300),
                  children: [
                TextSpan(text: 'Es gibt noch '),
                TextSpan(
                    text: '${widget.plaetze}',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                TextSpan(text: ' freie Plätze.')
              ])),
        ]),
      ],
      childrenBottom: [
        SizedBox(height: 20),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(widget.beschreibung,
                style: Schrift())),
        SizedBox(height: 20),
        Align(
            alignment: Alignment.centerLeft,
            child: Text('Zum Termin anmelden',
                style: Schrift())),
        SizedBox(height: 10),
        Button(
            text: true ? 'Keine Antwort' : '',
            farbe: Buttonfarbe.blau,
            gefuellt: false,
            onPressed: () {})
      ],
    );
  }
}
