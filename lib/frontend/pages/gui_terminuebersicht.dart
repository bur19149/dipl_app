import 'package:dipl_app/frontend/gui_konstanten.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_rahmen.dart';
import 'package:dipl_app/backend/objects.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import '../../backend/objects.dart';
import 'package:intl/intl.dart';
import '../gui_menuleiste.dart';
import '../gui_topLeiste.dart';
import '../gui_buttons.dart';
import '../gui_text.dart';


class TerminUebersichtPage extends StatefulWidget {
  @override
  _StandardmenuState createState() => _StandardmenuState();
}

class _StandardmenuState extends State<TerminUebersichtPage> {

  //Variables
  Future<List<UserTermin>> terminListeMeineTermine = requestMeineTermine();
  Future<List<UserTermin>> terminListeAlleTermine  = requestAlleTermine();
  List<UserTermin> _searchResultMeineTermine = [];
  List<UserTermin> _searchResultAlleTermine  = [];
  bool homeMeineTermine;

  //Controller
  TextEditingController controller = new TextEditingController();

  // @formatter:off
  @override
  Widget build(BuildContext context) {
    return Menuleiste(
      //TODO Admin ist zurzeit noch statisch
        admin: true,
        textEditingController: controller,
        onChanged: onSearchTextChanged,
        scaffoldHome: Scaffold(
            body: _searchResultAlleTermine.length != 0 || controller.text.isNotEmpty ?
            ListView.builder(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                itemCount: _searchResultAlleTermine.length,
                itemBuilder: (context, index) {
                  UserTermin termin = _searchResultAlleTermine[index];
                  List<Widget> children = [];
                  if(index==0) {
                    children.add(SizedBox(height: 70));
                  }
                  children.addAll([
                    TerminRahmenTerminuebersicht(
                        name: termin.name,
                        anmeldungEnde: termin.anmeldungEnde,
                        ort: termin.ort,
                        timeVon: termin.timeVon,
                        timeBis: termin.timeBis,
                        plaetze: termin.plaetze,
                        beschreibung: termin.beschreibung),
                    SizedBox(height: 35)]);
                  if(_searchResultAlleTermine.length-1==index){
                    children.add(SizedBox(height: 70));
                  }
                  return Column(children: children);})
                : FutureBuilder(
                future: terminListeAlleTermine,
                initialData: [],
                builder: (context, projectSnap) {
                  if (projectSnap.data != null && projectSnap.data.length > 0) {
                    return ListView.builder(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                        itemCount: projectSnap.data.length,
                        itemBuilder: (context, index) {
                          UserTermin termin = projectSnap.data[index];
                          List<Widget> children = [];
                          if(index==0){
                            children.add(SizedBox(height: 70));
                          }
                          children.addAll([
                            TerminRahmenTerminuebersicht(
                                name: termin.name,
                                anmeldungEnde: termin.anmeldungEnde,
                                ort: termin.ort,
                                timeVon: termin.timeVon,
                                timeBis: termin.timeBis,
                                plaetze: termin.plaetze,
                                beschreibung: termin.beschreibung),
                            SizedBox(height: 35)]);
                          if(projectSnap.data.length-1==index){
                            children.add(SizedBox(height: 70));
                          }
                          return Column(children: children);
                        });
                  } else {
                    return Align(
                        alignment: Alignment.center,
                        child: Text(projectSnap != null ? 'Keine Termine vorhanden!' : 'Keine Internet Verbindung!',
                            style: Schrift()));
                  }})));
  } // @formatter:on
  @override
  void initState() {
    super.initState();
  }

//@formatter:off
  void onSearchTextChanged(String text) async {
    text=text.toLowerCase().trim();
    _searchResultAlleTermine.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    terminListeAlleTermine.then((terminliste) {
      for (var termin in terminliste) {
        if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)||termin.beschreibung.contains(text)) {
          _searchResultAlleTermine.add(termin);
        }
      }
    });
    setState(() {});
  }
//@foramtter:on
}

//class TerminUebersichtPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() => _TerminUebersichtPageState();
//}
//
//class _TerminUebersichtPageState extends State<TerminUebersichtPage> {
//
//  Future<List<UserTermin>> terminliste = requestAlleTermine();
//
//  // Future _getTermine() async { //TODO vielleicht unnöftiger Getter
//  //   return await requestAlleTermine();
//  // }
//
//  @override
//  Widget build(BuildContext context) {
//    return SafeArea(
//        child: Scaffold(
//            body: FutureBuilder(
//                builder: (context, projectSnap) {
//                  // if (projectSnap.data == null || projectSnap.connectionState == ConnectionState.none || projectSnap.hasData == null) {
//                  //   return Container(); //TODO remove this dead code. War zuvor mit && Verbunden.
//                  // } else
//                  if (projectSnap.data != null && projectSnap.data.length > 0) {
//                    return ListView.builder(
//                        padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//                        itemCount: projectSnap.data.length,
//                        itemBuilder: (context, index) {
//                          UserTermin termin = projectSnap.data[index];
//                          List<Widget> children = [];
//                          if (index == 0)
//                            children.addAll([Topleiste(), SizedBox(height: 40)]);
//                          children.addAll([
//                            TerminRahmenTerminuebersicht(
//                                name: termin.name,
//                                anmeldungEnde: termin.anmeldungEnde,
//                                ort: termin.ort,
//                                timeVon: termin.timeVon,
//                                timeBis: termin.timeBis,
//                                plaetze: termin.plaetze,
//                                beschreibung: termin.beschreibung),
//                            SizedBox(height: 35)]);
//                          return Column(children: children);
//                        });
//                  } else {
//                    return Stack(
//                      children: [
//                        ListView(
//                          padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//                          children: [Topleiste()]),
//                        Align(
//                          alignment: Alignment.center,
//                          child: Text(projectSnap.data!=null ? 'Keine Termine vorhanden!': 'Keine Internet Verbindung!',
//                              style: Schrift()))]);
//                  }
//                },
//                future: /*_getTermine()*/ terminliste,
//                initialData: [])));
//  }
//}

class TerminRahmenTerminuebersicht extends StatefulWidget {
  final String name, ort, beschreibung;
  final int plaetze;
  final DateTime anmeldungEnde, timeVon, timeBis;

  const TerminRahmenTerminuebersicht(
      {this.name = 'Name',
      this.anmeldungEnde,
      this.ort = 'Ort',
      this.plaetze = 0,
      this.beschreibung = 'Beschreibung',
      this.timeVon,
      this.timeBis});

  @override
  State<StatefulWidget> createState() => _TerminRahmenTerminuebersichtState();
}

class _TerminRahmenTerminuebersichtState extends State<TerminRahmenTerminuebersicht> {
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
          widget.ort == null || widget.ort.isEmpty ? Container() :
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
          widget.beschreibung != null && widget.beschreibung.isNotEmpty ? SizedBox(height: 20) : Container(),
          widget.beschreibung != null && widget.beschreibung.isNotEmpty ? Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.beschreibung, style: Schrift(), textAlign: TextAlign.justify)) : Container(),
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