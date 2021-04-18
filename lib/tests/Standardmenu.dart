import 'package:dipl_app/backend/objects.dart';
import 'package:dipl_app/backend/requests/user.dart';
import 'package:dipl_app/frontend/gui_menuleiste.dart';
import 'package:dipl_app/frontend/gui_text.dart';
import 'package:dipl_app/frontend/pages/gui_terminuebersicht.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Standardmenu extends StatefulWidget {
  @override
  _StandardmenuState createState() => _StandardmenuState();
}

class _StandardmenuState extends State<Standardmenu> {

  //Variables
  Future<List<UserTermin>> terminlisteLocal = requestAlleTermine();
  List<UserTermin> _searchResult = [];

  //Controller
  TextEditingController controller = new TextEditingController();

  //@foratter:off

  @override
  Widget build(BuildContext context) {
    return Menuleiste(
      //TODO Admin ist zurzeit noch statisch
        admin: true,
        textEditingController: controller,
        onChanged: onSearchTextChanged,
        scaffold: Scaffold(
            body: _searchResult.length != 0 || controller.text.isNotEmpty ?
            ListView.builder(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                UserTermin termin = _searchResult[index];
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
                if(_searchResult.length-1==index){
                  children.add(SizedBox(height: 70));
                }
                return Column(children: children);})
                : FutureBuilder(
                future: terminlisteLocal,
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
  }
//@foramtter:on
  @override
  void initState() {
    super.initState();
  }

//@formatter:off
  void onSearchTextChanged(String text) async {
    text.toLowerCase().trim();
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    terminlisteLocal.then((terminliste) {
      for (var termin in terminliste) {
        if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)||termin.beschreibung.contains(text)) {
          _searchResult.add(termin);
        }
      }
    });
    setState(() {});
  }

  //@foramtter:on
}



