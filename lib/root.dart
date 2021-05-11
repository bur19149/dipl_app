import 'frontend/gui_eingabefelder.dart';
import 'frontend/pages/gui_meineTermineUebersicht.dart';
import 'frontend/pages/gui_terminuebersicht.dart';
import 'package:flutter/material.dart';
import 'frontend/gui_menuleiste.dart';
import 'backend/objects.dart';

class Root extends StatefulWidget {
	@override
	_RootState createState() => _RootState();
}

class _RootState extends State<Root> {
	///Variables
	List<UserTermin> searchResultMeineTermine = [];
	List<UserTermin> searchResultHome = [];
	Wrapper wrapper = Wrapper();

	//Controller
	TextEditingController controller = new TextEditingController();

	// @formatter:off
	@override
	Widget build(BuildContext context) {
		return Menuleiste(
				admin: true, // TODO Admin ist zurzeit noch statisch
				textEditingController: controller,
				onChanged: 						 onSearchTextChanged,
				wrapper: 							 wrapper,
				scaffoldHome: 		TerminuebersichtPage(wrapper: wrapper, controller: controller, searchResult: searchResultHome),
				scaffoldMeineTermine: MeineTerminePage(wrapper: wrapper, controller: controller, searchResult: searchResultMeineTermine));
  } // @formatter:on

  @override
  void initState() {
    super.initState();
  }

//@formatter:off

	//Nach überlegungen ist es hier im root am besten.
	void onSearchTextChanged(String text) async {
		searchResultHome.clear();
		searchResultMeineTermine.clear();
		text = text.toLowerCase().trim();
		if (text.isEmpty) {
			setState(() {});
			return;
		}
			for(var a in wrapper.value){
				if (a.name.toLowerCase().contains(text)||a.ort.toLowerCase().contains(text)||a.beschreibung.toLowerCase().contains(text)){
					if(wrapper.home==true){
						searchResultHome.add(a);
					}else{
						searchResultMeineTermine.add(a);
					}
				}
			}
		setState(() {});
		}
//@foramtter:on
}