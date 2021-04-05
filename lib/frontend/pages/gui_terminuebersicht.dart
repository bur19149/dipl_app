import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/backend/objects.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../backend/objects.dart';
import 'package:intl/intl.dart';
import '../../backend/objects.dart';
import '../gui_topLeiste.dart';
import '../gui_buttons.dart';
import '../gui_text.dart';

class TerminUebersichtPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TerminUebersichtPageState();
}

class _TerminUebersichtPageState extends State<TerminUebersichtPage> {

  Future<List<UserTermin>> terminliste = requestAlleTermine();

  // Future _getTermine() async { //TODO vielleicht unnöftiger Getter
  //   return await requestAlleTermine();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                builder: (context, projectSnap) {
                  // if (projectSnap.data == null || projectSnap.connectionState == ConnectionState.none || projectSnap.hasData == null) {
                  //   return Container(); //TODO remove this dead code. War zuvor mit && Verbunden.
                  // } else
                  if (projectSnap.data != null && projectSnap.data.length > 0) {
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
                                timeVon: termin.timeVon,
                                timeBis: termin.timeBis,
                                plaetze: termin.plaetze,
                                beschreibung: termin.beschreibung),
                            SizedBox(height: 35)]);
                          return Column(children: children);
                        });
                  } else {
                    return Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                          children: [Topleiste()]),
                        Align(
                          alignment: Alignment.center,
                          child: Text(projectSnap.data!=null ? 'Keine Termine vorhanden!': 'Keine Internet Verbindung!',
                              style: Schrift()))]);
                  }
                },
                future: /*_getTermine()*/ terminliste,
                initialData: [])));
  }
}

class _TerminRahmen extends StatefulWidget {
  final String name, ort, beschreibung;
  final int plaetze;
  final DateTime anmeldungEnde, timeVon, timeBis;

  const _TerminRahmen(
      {this.name = 'Name',
      this.anmeldungEnde,
      this.ort = 'Ort',
      this.plaetze = 0,
      this.beschreibung = 'Beschreibung',
      this.timeVon,
      this.timeBis});

  @override
  State<StatefulWidget> createState() => _TerminRahmenState();
}

class _TerminRahmenState extends State<_TerminRahmen> {
  DateTime anmeldungEnde;
  bool _sameDate;

  @override
  void initState() {
    _sameDate = _checkSameDate(start: widget.timeVon, end: widget.timeBis);
    anmeldungEnde = widget.anmeldungEnde ?? DateTime(0);
    super.initState();
  }

  bool _checkSameDate({@required DateTime start,@required DateTime end}) { // @formatter:off
    bool day   = start.day   == end.day,
         month = start.month == end.month,
         year  = start.year  == end.year;
    return day && month && year;
  } // @formatter:on

  @override
  Widget build(BuildContext context) {
    return ExpandableRahmen(
        header: widget.name,
        bottomHeader: 'Anmeldung offen bis ${DateFormat('dd.MM.yyyy kk:mm').format(anmeldungEnde)}',
        childrenTop: [
          Row(children: [
            Container(
                height: _sameDate ? 20 : 45,
                child: Align(
                    alignment:
                        _sameDate ? Alignment.centerLeft : Alignment.topLeft,
                    child: SvgPicture.asset(SVGicons.uhr,
                        width: 20, color: Farben.dunkelgrau))),
            SizedBox(width: 10),
            Wrap(children: [ // @formatter:off
            Text('${DateFormat('dd.MM.yyyy - kk:mm').format(widget.timeVon)} Uhr bis${_sameDate ? ' ' : '\n'}'
                 '${DateFormat('${!_sameDate ? 'dd.MM.yyyy - ' : ''}kk:mm').format(widget.timeBis)} Uhr',
                  style: Schrift()) // @formatter:on
            ])]),
          SizedBox(height: 5),
          Row(children: [
            SizedBox(
                width: 20,
                child: SvgPicture.asset(SVGicons.standort,
                    height: 25, color: Farben.dunkelgrau)),
            SizedBox(width: 10),
            Wrap(children: [Text(widget.ort, style: Schrift())])]),
          SizedBox(height: 5),
          Row(children: [
            SvgPicture.asset(SVGicons.mehrereBenutzer,
                width: 20, color: Farben.dunkelgrau),
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
                ]))])],
        childrenBottom: [
          SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.beschreibung, style: Schrift())),
          SizedBox(height: 20),
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Zum Termin anmelden', style: Schrift())),
          SizedBox(height: 10),
          Button(
              text: true ? 'Keine Antwort' : '',
              farbe: Buttonfarbe.blau,
              gefuellt: false,
              onPressed: () {})]);
  }
}

///Trash 2 be deleted when finished (old code without the "Keine Termine vorhanden" fix where the page is Empty

// import 'package:dipl_app/frontend/gui_konstanten.dart';
// import 'package:dipl_app/backend/requests/user.dart';
// import 'package:dipl_app/frontend/gui_rahmen.dart';
// import 'package:dipl_app/backend/objects.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../gui_topLeiste.dart';
// import '../gui_buttons.dart';
// import '../gui_text.dart';
//
// class TerminUebersichtPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _TerminUebersichtPageState();
// }
//
// class _TerminUebersichtPageState extends State<TerminUebersichtPage> {
//   List<UserTermin> termine;
//
//   Future _getTermine() async {
//     return await requestAlleTermine();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             body: FutureBuilder(
//                 builder: (context, projectSnap) {
//                   if (projectSnap.connectionState == ConnectionState.none &&
//                       projectSnap.hasData == null) {
//                     return Container();
//                   }
//                   return ListView.builder(
//                       padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//                       itemCount: projectSnap.data.length,
//                       itemBuilder: (context, index) {
//                         UserTermin termin = projectSnap.data[index];
//                         List<Widget> children = [];
//                         if (index == 0)
//                           children.addAll([Topleiste(), SizedBox(height: 40)]);
//                         children.addAll([
//                           _TerminRahmen(
//                               name: termin.name,
//                               anmeldungEnde: termin.anmeldungEnde,
//                               ort: termin.ort,
//                               timeVon: termin.timeVon,
//                               timeBis: termin.timeBis,
//                               plaetze: termin.plaetze,
//                               beschreibung: termin.beschreibung),
//                           SizedBox(height: 35)
//                         ]);
//                         return Column(children: children);
//                       });
//                 },
//                 future: _getTermine(),
//                 initialData: [])));
//   }
// }
//
// class _TerminRahmen extends StatefulWidget {
//   final String name, ort, beschreibung;
//   final int plaetze;
//   final DateTime anmeldungEnde, timeVon, timeBis;
//
//   const _TerminRahmen(
//       {this.name = 'Name',
//       this.anmeldungEnde,
//       this.ort = 'Ort',
//       this.plaetze = 0,
//       this.beschreibung = 'Beschreibung',
//       this.timeVon,
//       this.timeBis});
//
//   @override
//   State<StatefulWidget> createState() => _TerminRahmenState();
// }
//
// class _TerminRahmenState extends State<_TerminRahmen> {
//   DateTime anmeldungEnde;
//   bool _sameDate;
//
//   @override
//   void initState() {
//     _sameDate = _checkSameDate(start: widget.timeVon, end: widget.timeBis);
//     anmeldungEnde = widget.anmeldungEnde ?? DateTime(0);
//     super.initState();
//   }
//
//   bool _checkSameDate({@required DateTime start,@required DateTime end}) { // @formatter:off
//     bool day   = start.day   == end.day,
//          month = start.month == end.month,
//          year  = start.year  == end.year;
//     return day && month && year;
//   } // @formatter:on
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableRahmen(
//       header: widget.name,
//       bottomHeader:
//       'Anmeldung offen bis ${DateFormat('dd.MM.yyyy kk:mm').format(
//           anmeldungEnde)}',
//       childrenTop: [
//         Row(children: [
//           Container(height: _sameDate ? 20 : 45,
//               child: Align(
//                   alignment: _sameDate ? Alignment.centerLeft : Alignment
//                       .topLeft,
//                   child: SvgPicture.asset(
//                       SVGicons.uhr, width: 20, color: Farben.dunkelgrau))),
//           SizedBox(width: 10),
//           Wrap(children: [ // @formatter:off
//             Text('${DateFormat('dd.MM.yyyy - kk:mm').format(widget.timeVon)} Uhr bis${_sameDate ? ' ' : '\n'}'
//                  '${DateFormat('${!_sameDate ? 'dd.MM.yyyy - ' : ''}kk:mm').format(widget.timeBis)} Uhr',
//                 style: Schrift()) // @formatter:on
//           ])
//         ]),
//         SizedBox(height: 5),
//         Row(children: [
//           SizedBox(width: 20,
//               child: SvgPicture.asset(
//                   SVGicons.standort, height: 25, color: Farben.dunkelgrau)),
//           SizedBox(width: 10),
//           Wrap(children: [Text(widget.ort, style: Schrift())])
//         ]),
//         SizedBox(height: 5),
//         Row(children: [
//           SvgPicture.asset(
//               SVGicons.mehrereBenutzer, width: 20, color: Farben.dunkelgrau),
//           SizedBox(width: 10),
//           RichText(
//               text: TextSpan(
//                   style: TextStyle(
//                       fontSize: Groesse.normal,
//                       color: Farben.blaugrau,
//                       fontFamily: appFont,
//                       fontWeight: FontWeight.w300),
//                   children: [
//                     TextSpan(text: 'Es gibt noch '),
//                     TextSpan(
//                         text: '${widget.plaetze}',
//                         style: TextStyle(fontWeight: FontWeight.w500)),
//                     TextSpan(text: ' freie Plätze.')
//                   ])),
//         ]),
//       ],
//       childrenBottom: [
//         SizedBox(height: 20),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Text(widget.beschreibung, style: Schrift())),
//         SizedBox(height: 20),
//         Align(
//             alignment: Alignment.centerLeft,
//             child: Text('Zum Termin anmelden', style: Schrift())),
//         SizedBox(height: 10),
//         Button(
//             text: true ? 'Keine Antwort' : '',
//             farbe: Buttonfarbe.blau,
//             gefuellt: false,
//             onPressed: () {})
//       ],
//     );
//   }
// }
