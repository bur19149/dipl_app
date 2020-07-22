// -------------------------------- Imports ---------------------------------

// @formatter:off
import 'package:http/http.dart' as http;
import 'variables.dart'         as variables;
import '../objects.dart'        as objects;
import '../converter.dart'      as converter;
import 'dart:convert'           as convert;
import '../exceptions.dart';
// @formatter:on

// ------------------------------ GET-Requests ------------------------------

/// "4.7.8 Termin anzeigen
/// Endpunkt, um einen speziellen Termin anzuzeigen. Der Termin wird nur angezeigt, wenn dieser
/// öffentlich ist und noch nicht stattgefunden hat. Als Parameter \[wird\] die Terminid [...]
/// übergeben."
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
Future<objects.UserTermin> requestTermin(int eventID) async { // @formatter:off
  var _response = await http.get('${variables.url}/termin?token=${variables.token}&eventid=$eventID');
  if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode, c404: 'Termin nicht öffentlich oder noch nicht erstellt.');
  return converter.jsonToTermin(convert.jsonDecode(_response.body)['termin']);
} // @formatter:on

/// "4.7.4 Meine Termine
/// Endpunkt, um eigene Termine anzeigen zu lassen. Es werden nur Termine angezeigt, die noch nicht
/// stattgefunden haben und zu denen der User oder ein verbundener Account angemeldet ist. Die
/// Leiter Antwort ist dabei egal. [...]"
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
Future<List<objects.UserTermin>> requestMeineTermine() async { // @formatter:off
  var _response = await http.get('${variables.url}/meine-termine?token=${variables.token}');
  if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
  var terminliste = <objects.UserTermin>[];
  for (var termin in convert.jsonDecode(_response.body)['termine']) {
    terminliste.add(converter.jsonToTermin(termin));
  }
  return terminliste;
} // @formatter:on

/// "4.7.5 Alle Termine
/// Endpunkt, um alle anstehenden Termine anzeigen zu lassen. Es werden nur Termine angezeigt, die
/// noch nicht stattgefunden haben und die als sichtbar eingetragen sind. Es werden auch Termine
/// angezeigt, bei denen die Anmeldung bereits beendet ist. [...]"
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
Future<List<objects.UserTermin>> requestAlleTermine() async { // @formatter:off
  var _response = await http.get('${variables.url}/termin?token=${variables.token}');
  if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
  var terminliste = <objects.UserTermin>[];
  for (var termin in convert.jsonDecode(_response.body)['termine']) {
    terminliste.add(converter.jsonToTermin(termin));
  }
  return terminliste;
} // @formatter:on

// ----------------------------- PATCH-Requests -----------------------------

/// "4.7.10 Termin anmelden
/// Endpunkt, um einen User bei einem Termin anzumelden. Eine Anmeldung ist nur erfolgreich, wenn
/// die Termin Anmeldung aktuell offen ist. Als Parameter \[wird\] die Terminid [...]
/// übergeben. Wahlweise kann auch eine Userid von einem verknüpften Account übergeben werden.
/// Ist keine Userid gegeben wird implizit der Account vom Token genommen."
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
anmeldungTermin(int eventID, [int userID]) async { // @formatter:off
  var parameters = <String, String>{};
                     parameters['token']   = variables.token;
                     parameters['eventid'] = '$eventID';
  if(userID != null) parameters['userid']  = '$userID';

  var _response = await http.patch('${variables.url}/termin/anmelden/', body: parameters);
  if(_response.statusCode != 201 && _response.statusCode != 204) {
    throw exceptionHandler(_response.statusCode, c404: 'Termin existiert nicht / Userid unbekannt',
                                                 c423: 'Termin ist noch nicht sichtbar',
                                                 c410: 'Anmeldung geschlossen');
  }
} // @ formatter:on

/// "4.7.12 Termin abmelden
/// Endpunkt, um einen User bei einem Termin abzumelden. Eine Abmeldung ist nur erfolgreich, wenn
/// die Termin Anmeldung aktuell offen ist. Als Parameter \[wird\] die Terminid [...]
/// übergeben. Wahlweise kann auch eine Userid von einem verknüpften Account übergeben werden.
/// Ist keine Userid gegeben wird implizit der Account vom Token genommen."
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
abmeldungTermin(int eventID, [int userID]) async { // @formatter:off
  var parameters = <String, String>{};
                     parameters['token']   = variables.token;
                     parameters['eventid'] = '$eventID';
  if(userID != null) parameters['userid']  = '$userID';

  var _response = await http.patch('${variables.url}/termin/abmelden', body: parameters);
  if (_response.statusCode != 204) {
    throw exceptionHandler(_response.statusCode, c404: 'Termin existiert nicht / Userid unbekannt',
                                                 c423: 'Termin ist nicht sichtbar',
                                                 c410: 'Anmeldung geschlossen');
  }
} // @formatter:on