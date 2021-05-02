import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'frontend/pages/gui_meineTermineUebersicht.dart';
import 'frontend/pages/gui_terminuebersicht.dart';
import 'frontend/gui_menuleiste.dart';
import 'backend/requests/user.dart';
import 'backend/objects.dart';

class Root extends StatefulWidget {
	@override
	_RootState createState() => _RootState();
}

class _RootState extends State<Root> {
	//Variables
	Future<List<UserTermin>> terminListeMeineTermine = requestMeineTermine();
	Future<List<UserTermin>> terminListeAlleTermine  = requestAlleTermine();
	List<UserTermin> _searchResultMeineTermine = [];
	List<UserTermin> _searchResultAlleTermine  = [];

	//Controller
	TextEditingController controller = new TextEditingController();

	// @formatter:off
	@override
	Widget build(BuildContext context) {
		return Menuleiste(
				admin: true, // TODO Admin ist zurzeit noch statisch
				textEditingController: controller,
				onChanged: onSearchTextChanged,
				scaffoldHome: TerminuebersichtPage(),
				scaffoldMeineTermine: MeineTerminePage());
	} // @formatter:on
	@override
	void initState() {
		super.initState();
	}

//das ist Bullshit

//@formatter:off
	void onSearchTextChanged(String text) async {
		bool isHome = true; //das ist bullshit
		text=text.toLowerCase().trim();
		_searchResultAlleTermine.clear();
		_searchResultMeineTermine.clear();
		if (text.isEmpty) {
			setState(() {});
			return;
		}
		if(isHome){
			terminListeAlleTermine.then((terminliste) {
				for (var termin in terminliste)
					if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)||termin.beschreibung.contains(text))
						_searchResultAlleTermine.add(termin);
			}
			);
		}else{
			terminListeMeineTermine.then((terminliste){
				for(var termin in terminliste){
					if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)){
						_searchResultMeineTermine.add(termin);
					}
				}
			});
		}
		setState(() {});
	}
//@foramtter:on
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'frontend/pages/gui_meineTermineUebersicht.dart';
// import 'frontend/pages/gui_terminuebersicht.dart';
// import 'frontend/gui_menuleiste.dart';
// import 'backend/requests/user.dart';
// import 'backend/objects.dart';
//
// class Root extends StatefulWidget {
// 	@override
// 	_RootState createState() => _RootState();
// }
//
// class _RootState extends State<Root> {
// 	//Variables
// 	Future<List<UserTermin>> terminListeMeineTermine = requestMeineTermine();
// 	Future<List<UserTermin>> terminListeAlleTermine = requestAlleTermine();
// 	List<UserTermin> _searchResultMeineTermine = [];
// 	List<UserTermin> _searchResultAlleTermine = [];
// 	bool homeMeineTermine;
//
// 	//Controller
// 	TextEditingController controller = new TextEditingController();
//
// 	// @formatter:off
// 	@override
// 	Widget build(BuildContext context) {
// 		return Menuleiste(
// 				admin: true, // TODO Admin ist zurzeit noch statisch
// 				textEditingController: controller,
// 				onChanged: onSearchTextChanged,
// 				scaffoldHome: TerminuebersichtPage(),
// 				scaffoldMeineTermine: MeineTerminePage());
// 	} // @formatter:on
// 	@override
// 	void initState() {
// 		super.initState();
// 	}
//
// 	bool hometest= true; //das ist Bullshit
//
// //@formatter:off
// 	void onSearchTextChanged(String text, bool isHome) async {
// 		text=text.toLowerCase().trim();
// 		_searchResultAlleTermine.clear();
// 		_searchResultMeineTermine.clear();
// 		if (text.isEmpty) {
// 			setState(() {});
// 			return;
// 		}
// 		if(isHome){
// 		terminListeAlleTermine.then((terminliste) {
// 			for (var termin in terminliste)
// 				if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)||termin.beschreibung.contains(text))
// 					_searchResultAlleTermine.add(termin);
// 			}
// 		);
// 		}else{
// 			terminListeMeineTermine.then((terminliste){
// 				for(var termin in terminliste){
// 					if (termin.name.toLowerCase().contains(text)||termin.ort.toLowerCase().contains(text)){
// 						_searchResultMeineTermine.add(termin);
// 					}
// 				}
// 			});
// 		}
// 		// setState(() {});
// 	}
// //@foramtter:on
// }