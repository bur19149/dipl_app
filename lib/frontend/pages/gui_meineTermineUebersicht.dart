import '../../backend/requests/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../backend/objects.dart';
import 'package:intl/intl.dart';
import '../gui_konstanten.dart';
import '../gui_buttons.dart';
import '../gui_rahmen.dart';
import '../gui_text.dart';

class MeineTerminePage extends StatefulWidget {
  @override
  _MeineTerminePageState createState() => _MeineTerminePageState();
}

class _MeineTerminePageState extends State<MeineTerminePage> {
  //Variables
  TextEditingController controller = new TextEditingController();
  Future<List<UserTermin>> alleMeineTermine = requestMeineTermine();
  List<UserTermin> _searchResultMeineTermine = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _searchResultMeineTermine.length != 0 ||
                controller.text.isNotEmpty
            ? ListView.builder(
                padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                itemCount: _searchResultMeineTermine.length,
                itemBuilder: (context, index) {
                  UserTermin termin = _searchResultMeineTermine[index];
                  List<Widget> children = [];
                  if (index == 0) {
                    children.add(SizedBox(height: 70));
                  }
                  children.addAll([
                    _TerminRahmenMeineTermine(
                      name: termin.name,
                      anmeldungEnde: termin.anmeldungEnde,
                      ort: termin.ort,
                      plaetze: termin.plaetze,
                      timeVon: termin.timeVon,
                      timeBis: termin.timeBis,
                      belegtePlaetze: termin.teilnehmer.length,
                    ),
                    SizedBox(height: 35)
                  ]);
                  if (_searchResultMeineTermine.length - 1 == index) {
                    children.add(SizedBox(height: 70));
                  }
                  return Column(children: children);
                })
            : FutureBuilder(
                future: alleMeineTermine,
                initialData: [],
                builder: (context, projectSnap) {
                  if (projectSnap.data != null && projectSnap.data.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      itemCount: projectSnap.data.length,
                      itemBuilder: (context, index) {
                        UserTermin termin = projectSnap.data[index];
                        List<Widget> children = [];
                        if (index == 0) {
                          children.add(SizedBox(height: 70));
                        }
                        children.addAll([
                          _TerminRahmenMeineTermine(
                            ort: termin.ort,
                            name: termin.name,
                            anmeldungEnde: termin.anmeldungEnde,
                            plaetze: termin.plaetze,
                            timeVon: termin.timeVon,
                            timeBis: termin.timeBis,
                            belegtePlaetze: termin.teilnehmer.length,
                          ),
                          SizedBox(height: 35)
                        ]);
                        if (projectSnap.data.length - 1 == index) {
                          children.add(SizedBox(height: 70));
                        }
                        return Column(children: children);
                      },
                    );
                  } else {
                    return Align(
                        alignment: Alignment.center,
                        child: Text(
                            projectSnap != null ? 'Keine Termine vorhanden!' : 'Keine Internet Verbindung!',
                            style: Schrift()));
                  }
                }));
  }
}

class _TerminRahmenMeineTermine extends StatefulWidget {
  final String name, ort;
  final int plaetze;
  final int belegtePlaetze;
  final DateTime anmeldungEnde, timeVon, timeBis;

  const _TerminRahmenMeineTermine(
      {this.name = 'Name',
      this.ort = 'Ort',
      this.plaetze = 0,
      this.belegtePlaetze = 0,
      this.anmeldungEnde,
      this.timeVon,
      this.timeBis});

  @override
  _TerminRahmenMeineTermineState createState() =>
      _TerminRahmenMeineTermineState();
}

class _TerminRahmenMeineTermineState extends State<_TerminRahmenMeineTermine>
    with SingleTickerProviderStateMixin {
  DateTime anmeldungEnde;
  bool _sameDate;
  bool isExpanded; // Ist der Rahmen sichtbar/ausgefahren?
  AnimationController controller; // Controller des Widgets / der Animation, definiert die Animationszeit
  Animation<double> heightFactor; // definiert die Animation (Kurve usw.)

  void handleTap() {
    setState(() {
      isExpanded = !isExpanded;
      if (isExpanded) {
        controller.forward();
      } else {
        controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }
      PageStorage.of(context)?.writeState(context, isExpanded);
    });
  }

  @override
  void initState() {
    controller = AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    heightFactor = controller.drive(CurveTween(curve: Curves.easeIn));
    isExpanded = PageStorage.of(context)?.readState(context) ?? true;
    if (isExpanded) controller.value = 1.0;

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
    bool closed = !isExpanded && controller.isDismissed;
    print('###### Closed: [$closed], isExpanded: [$isExpanded]');
    return ExpandableRahmen(
      header: widget.name,
      bottomHeader:
          'Anmeldung offen bis ${DateFormat('dd.MM.yyyy kk:mm').format(anmeldungEnde)}',
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
          ])
        ]),
        SizedBox(height: 5),
        widget.ort == null || widget.ort.isEmpty
            ? Container()
            : Row(children: [
                SizedBox(
                    width: 20,
                    child: SvgPicture.asset(SVGicons.standort,
                        height: 25, color: Farben.dunkelgrau)),
                SizedBox(width: 10),
                Wrap(children: [Text(widget.ort, style: Schrift())])
              ]),
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
                TextSpan(text: '${widget.belegtePlaetze}/${widget.plaetze}'),
                TextSpan(text: ' Plätze belegt.')
              ]))
        ])
      ],
      childrenBottom: [
        Button(
          text: 'Bearbeiten',
          farbe: Buttonfarbe.rot,
          gefuellt: false,
          onPressed: () {},
        ),
        AnimatedBuilder(
            animation: controller.view,
            builder: (BuildContext context, Widget child) => ClipRect(
                child: Align(heightFactor: heightFactor.value, child: child)),
            child: closed
                ? null
                : Container(
                    width: double.infinity,
                    child: Button(
                      text: 'Antwort bearbeiten',
                      svg: SVGicons.bearbeiten,
                      gefuellt: true,
                      farbe: Buttonfarbe.blaugrau,
                      onPressed: () => handleTap(),
                    ))),
        AnimatedBuilder(
            animation: controller.view,
            builder: (BuildContext context, Widget child) => ClipRect(
                child: Align(heightFactor: heightFactor.value, child: child)),
            child: !closed
                ? null
                : Container(width: double.infinity, child: Text('Teste'))),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
