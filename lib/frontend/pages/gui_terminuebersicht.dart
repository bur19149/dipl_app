
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../backend/requests/user.dart';
import '../../backend/objects.dart';
import '../gui_konstanten.dart';
import '../gui_buttons.dart';
import '../gui_rahmen.dart';
import '../gui_text.dart';

class TerminuebersichtPage extends StatefulWidget {

  TerminuebersichtPage();

  @override
  _TerminuebersichtPageState createState() => _TerminuebersichtPageState();
}

class _TerminuebersichtPageState extends State<TerminuebersichtPage> {

  Future<List<UserTermin>> terminListeAlleTermine  = requestAlleTermine();
  List<UserTermin> _searchResultAlleTermine  = [];
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _searchResultAlleTermine.length != 0 || controller.text.isNotEmpty ?
        ListView.builder(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            itemCount: _searchResultAlleTermine.length,
            itemBuilder: (context, index) {
              UserTermin termin = _searchResultAlleTermine[index];
              List<Widget> children = [];
              if(index==0)
                children.add(SizedBox(height: 70));
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
              if(_searchResultAlleTermine.length-1==index)
                children.add(SizedBox(height: 70));
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
                      if(index==0)
                        children.add(SizedBox(height: 70));
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
                      if(projectSnap.data.length-1==index)
                        children.add(SizedBox(height: 70));
                      return Column(children: children);
                    });
              } else {
                return Align(
                    alignment: Alignment.center,
                    child: Text(projectSnap != null ? 'Keine Termine vorhanden!' : 'Keine Internet Verbindung!',
                        style: Schrift()));
              }}));
  }
}

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
              text: true ? 'Keine Antwort' : '', // TODO
              farbe: Buttonfarbe.blau,
              gefuellt: false,
              onPressed: () {})]);
  }
}