// import 'package:dipl_app/backend/objects.dart';
// import 'package:dipl_app/backend/requests/user.dart';
// import 'package:dipl_app/frontend/gui_menuleiste.dart';
// import 'package:dipl_app/frontend/gui_text.dart';
// import 'package:dipl_app/frontend/pages/gui_terminuebersicht.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Standardmenu extends StatefulWidget {
//   @override
//   _StandardmenuState createState() => _StandardmenuState();
// }
//
// class _StandardmenuState extends State<Standardmenu> {
//
//   //Variables
//   Future<List<UserTermin>> terminListeMeineTermine = requestMeineTermine();
//   Future<List<UserTermin>> terminListeAlleTermine  = requestAlleTermine();
//   List<UserTermin> _searchResultMeineTermine = [];
//   List<UserTermin> _searchResultAlleTermine  = [];
//   bool homeMeineTermine;
//
//   //Controller
//   TextEditingController controller = new TextEditingController();
//
//   //@formatter:off
//   @override
//   Widget build(BuildContext context) {
//     return Menuleiste(
//       //TODO Admin ist zurzeit noch statisch
//         admin: true,
//         textEditingController: controller,
//         onChanged: onSearchTextChanged,
//         scaffoldHome: Scaffold(
//             body: _searchResultAlleTermine.length != 0 || controller.text.isNotEmpty ?
//             ListView.builder(
//               padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//               itemCount: _searchResultAlleTermine.length,
//               itemBuilder: (context, index) {
//                 UserTermin termin = _searchResultAlleTermine[index];
//                 List<Widget> children = [];
//                 if(index==0) {
//                   children.add(SizedBox(height: 70));
//                 }
//                 children.addAll([
//                   TerminRahmenTerminuebersicht(
//                       name: termin.name,
//                       anmeldungEnde: termin.anmeldungEnde,
//                       ort: termin.ort,
//                       timeVon: termin.timeVon,
//                       timeBis: termin.timeBis,
//                       plaetze: termin.plaetze,
//                       beschreibung: termin.beschreibung),
//                   SizedBox(height: 35)]);
//                 if(_searchResultAlleTermine.length-1==index){
//                   children.add(SizedBox(height: 70));
//                 }
//                 return Column(children: children);})
//                 : FutureBuilder(
//                 future: terminListeAlleTermine,
//                 initialData: [],
//                 builder: (context, projectSnap) {
//                   if (projectSnap.data != null && projectSnap.data.length > 0) {
//                     return ListView.builder(
//                         padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//                         itemCount: projectSnap.data.length,
//                         itemBuilder: (context, index) {
//                           UserTermin termin = projectSnap.data[index];
//                           List<Widget> children = [];
//                           if(index==0){
//                             children.add(SizedBox(height: 70));
//                           }
//                           children.addAll([
//                             TerminRahmenTerminuebersicht(
//                                 name: termin.name,
//                                 anmeldungEnde: termin.anmeldungEnde,
//                                 ort: termin.ort,
//                                 timeVon: termin.timeVon,
//                                 timeBis: termin.timeBis,
//                                 plaetze: termin.plaetze,
//                                 beschreibung: termin.beschreibung),
//                             SizedBox(height: 35)]);
//                           if(projectSnap.data.length-1==index){
//                             children.add(SizedBox(height: 70));
//                           }
//                           return Column(children: children);
//                         });
//                   } else {
//                     return Align(
//                       alignment: Alignment.center,
//                       child: Text(projectSnap != null ? 'Keine Termine vorhanden!' : 'Keine Internet Verbindung!',
//                       style: Schrift()));
//                   }})),
//     //TODO Meine termine scaffhold
//     //   scaffoldMeineTermine: Scaffold(body: _searchResultMeineTermine.length==null || controller.text.isEmpty?
//     //     FutureBuilder(
//     //       future: terminListeMeineTermine,
//     //       initialData: [],
//     //       builder: (context2, projectSnap2) {
//     // if (projectSnap2.data != null && projectSnap2.data.length > 0) {
//     //   return ListView.builder(padding: EdgeInsets.only(left: 15, right: 15, top: 15),
//     //     itemCount: projectSnap2.data.length,
//     //     itemBuilder: (context2, index2) {
//     //       UserTermin termin = projectSnap2.data[index2];
//     //       List<Widget> children = [];
//     //       if(index2==0){
//     //         children.add(SizedBox(height: 70));
//     //       }
//     //       children.addAll([
//     //         //TODO
//     //       ]);
//     //     });
//     // }else{
//     //
//     // }
//     // },
//     //     ): ),
//     );
//   }
// //@formatter:on
//   @override
//   void initState() {
//     super.initState();
//   }
//
// //@formatter:off
//   void onSearchTextChanged(String text) async {
//     text=text.toLowerCase().trim();
//     _searchResultAlleTermine.clear();
//     if (text.isEmpty) {
//       setState(() {});
//       return;
//     }
//
//     terminListeAlleTermine.then((terminliste) {
//       for (var termin in terminliste) {
//         if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)||termin.beschreibung.contains(text)) {
//           _searchResultAlleTermine.add(termin);
//         }
//       }
//     });
//     setState(() {});
//   }
//
//   //@foramtter:on
// }
//
//
//
