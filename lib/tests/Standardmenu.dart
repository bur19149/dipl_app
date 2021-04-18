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

  @override
  Widget build(BuildContext context) {
    print('########################## [${_searchResult.length}] || [${controller.text}] = [${_searchResult.length != 0 || controller.text.isNotEmpty}] #######################');
    return Menuleiste(
        admin: true,
        textEditingController: controller,
        scaffold: Scaffold(
            body: _searchResult.length != 0 || controller.text.isNotEmpty ?
            ListView.builder(
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                UserTermin termin = _searchResult[index];
                List<Widget> children = [];
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
                          return Column(children: children);

                        });
                  } else {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(projectSnap != null ? 'Keine Termine vorhanden!' : 'Keine Internet Verbindung!',
                      style: Schrift()));
                  }
                })));
  }

  @override
  void initState() {
    super.initState();
  }

void onSearchTextChanged(String text) async {
  text.toLowerCase().trim();
  _searchResult.clear();
  if (text.isEmpty) {
    print('###################### setState() ################# 1');
    setState(() {});
    return;
  }

  terminlisteLocal.then((terminliste) {
    for (var termin in terminliste) {
      if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)) {
        _searchResult.add(termin);
      }
    }
    ///Debug
    _searchResult.forEach((element) {print(element.name);});
  });
  print('###################### setState() ################# 2');
  setState(() {});
}}



