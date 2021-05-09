import 'package:http/http.dart' as http;
import '../converter.dart'      as converter;
import 'variables.dart'         as variables;
import '../objects.dart'        as objects;
import 'dart:convert'           as convert;
import '../exceptions.dart';


// ------------------------------ GET-Requests ------------------------------

/// "4.7.15 Zyklus abfragen
/// Endpunkt, um alle Termin Wiederholzyklen zu bekommen. [...]"
///
/// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
Future<List<objects.Zyklus>> requestZyklen() async { // @formatter:off
  var _response = await http.get('${variables.url}/zyklus?token=${variables.token}');
  if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
  var zyklen = <objects.Zyklus>[];
  for (var zyklus in convert.jsonDecode(_response.body)['zyklus_list']) {
    zyklen.add(converter.jsonToZyklus(zyklus));
  }
  return zyklen;
} // @formatter:on

/// Enthält alle Admin-Requests die sich mit Usermanagement befassen.
abstract class User {
  // ------------------------------ GET-Requests ------------------------------

  /// "4.7.25 Admin User Daten
  /// Endpunkt, um die Daten über einen User zu bekommen. Es muss die Userid [...]
  /// übergeben werden."
  ///
  /// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
  static Future<objects.User> requestUser(int userID) async { // @formatter:off
    var _response = await http.get('${variables.url}/admin/user?token=${variables.token}&userid=${userID}');
    if (_response.statusCode != 200) {
      throw exceptionHandler(_response.statusCode, c404: 'Der Angefragte User existiert nicht',
                                                   c422: 'Es fehlt ein Parameter');
    }
      return converter.jsonToUser(convert.jsonDecode(_response.body)['data']['user']);
  } // @formatter:on

  /// "4.7.24 Admin Userliste
  /// Endpunkt, um eine Userliste nach ID sortiert von allen Usern zu bekommen. [...]"
  ///
  /// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
  static Future<List<objects.User>> requestUserListe() async { // @formatter:off
    var _response = await http.get('${variables.url}/admin/user?token=${variables.token}');
    if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
    var userliste = <objects.User>[];
    for (var user in convert.jsonDecode(_response.body)['data']['users']) {
      userliste.add(converter.jsonToUser(user));
    }
    return userliste;
  } // @formatter:on

  // ------------------------------ POST-Requests -----------------------------

  /// "4.7.26 Admin User erstellen
  /// Endpunkt, um einen neuen User anzulegen. Es müssen folgende Parameter übergeben werden.
  /// Vorname, Nachname, usertyp, plz, Ort, jugendgruppe (optional), elternid (optional), elternemail
  /// (optional), email (optional).
  /// Sind elternid und elternemail angegeben wird nur die elternid beachtet.
  /// Die Elternid muss genutzt werden, wenn der Eltern Account schon aktiviert ist. Ist der Eltern Account
  /// schon registriert aber noch nicht aktiviert muss die elternemail gesetzt werden."
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void erstelleUser( // @formatter:off
      String vorname, String nachname, int usertyp, String plz, String ort,
      [String jugendgruppe, int elternid, String elternemail, String email]) async {

    var _parameters = <String, String>{};
                             _parameters['token']        = variables.token;
                             _parameters['vorname']      = vorname;
                             _parameters['nachname']     = nachname;
                             _parameters['usertyp']      = '$usertyp';
                             _parameters['plz']          = plz;
                             _parameters['ort']          = ort;
    if(jugendgruppe != null) _parameters['jugendgruppe'] = jugendgruppe;
    if(elternid     != null) _parameters['elternid']     = '$elternid';
    if(elternemail  != null) _parameters['elternemail']  = elternemail;
    if(email        != null) _parameters['email']        = email;

    var _response = await http.post('${variables.url}/admin/user', body: _parameters);

    if(_response.statusCode != 201) {
      throw exceptionHandler(_response.statusCode, c422: 'Es fehlt ein Parameter',
                                                   c409: 'Wenn kein Elternaccount angegeben ist muss eine E-Mail mitgeschickt werden.',
                                                   c404: 'Der Eltern Account existiert nicht.');
    }
  } // @formatter:on

  // ----------------------------- PATCH-Requests -----------------------------

  // TODO for GUI PGM'er pfuefung ob mindestens ein optionaler Parameter dabei sind
  // TODO fehlerhaft Code 500
  // @formatter:off
  /// "4.7.27 Admin User bearbeiten
  /// Endpunkt, um einen User zu bearbeiten. Es muss [...] die Userid übergeben werden.
  /// Optional können folgende Parameter übergeben werden. Vorname, Nachname, Email, plz, Ort,
  /// Jugendgruppe, usertyp, elternid, elternemail"
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void bearbeiteUser(int userID, [String vorname, String nachname, String email, String plz,
      String ort, String jugendgruppe, int usertyp, int elternID, String elternemail]) async {

    var parameter = <String, String>{};
                              parameter['token']        = variables.token;
                              parameter['userid']       = '$userID';
    if (vorname      != null) parameter['vorname']      = vorname;
    if (nachname     != null) parameter['nachname']     = nachname;
    if (email        != null) parameter['email']        = email;
    if (plz          != null) parameter['plz']          = plz;
    if (ort          != null) parameter['ort']          = ort;
    if (jugendgruppe != null) parameter['jugendgruppe'] = jugendgruppe;
    if (usertyp      != null) parameter['usertyp']      = '$usertyp';
    if (elternID     != null) parameter['elternID']     = '$elternID';
    if (elternemail  != null) parameter['elternemail']  = elternemail;

    var _response = await http.patch('${variables.url}/admin/user/', body: parameter);

    if (_response.statusCode != 204) {
      throw exceptionHandler(_response.statusCode, c404: 'Der Angefragte User existiert nicht',
                                                   c422: 'Es fehlt ein Parameter');
    }
  } // @formatter:on

  // ----------------------------- DELETE-Requests ----------------------------

  /// "4.7.28 Admin User löschen
  /// Endpunkt, um einen User zu löschen. Es muss die Userid [...] übergeben werden"
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void loescheUser(int id) async { // @formatter:off
    var _response = await http.delete('${variables.url}/admin/user?token=${variables.token}&userid=$id');
    if (_response.statusCode != 204) {
      throw exceptionHandler(_response.statusCode, c404: 'Der Angefragte User existiert nicht',
                                                   c422: 'Es fehlt ein Parameter');
    }
  } // @formatter:on
}

/// Enthält alle Admin-Requests die sich mit Terminmanagement befassen.
abstract class Termin {
  // ------------------------------ GET-Requests ------------------------------

  /// "4.7.17 Admin Termin anzeigen
  /// Endpunkt, um den Termin, alle Anmeldungen, und alle Abmeldungen anzuzeigen. Als Parameter
  /// \[wird\] die Terminid [...] übergeben."
  ///
  /// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
  static Future<objects.AdminTermin> requestTermin(int eventID) async { // @formatter:off
    var _response = await http.get('${variables.url}/admin/termin?token=${variables.token}&eventid=$eventID');
    if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
    return converter.jsonToTermin(convert.jsonDecode(_response.body)['termin']);
  } // @formatter:on

  /// "4.7.16 Admin Terminliste
  /// Endpunkt, um alle Termine anzufragen. Es werden alle Termine, auch noch nicht veröffentlichte,
  /// sortiert nach ID ausgegeben. Wenn der Parameter archive auf true gesetzt ist werden alle Termine
  /// bis zum aktuellen Zeitpunkt ausgegeben. Ist archive false werden alle anstehenden, Termin Start in
  /// der Zukunft, ausgegeben. Parameter \[ist\] archive [...]"
  ///
  /// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
  // @formatter:off
  static Future<List<objects.UserTermin>> requestTerminListe(bool archive) async {
    var _response = await http.get('${variables.url}/admin/termin?token=${variables.token}&archive=$archive');
    if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
    var terminliste = <objects.UserTermin>[];
    for (var termin in convert.jsonDecode(_response.body)['termine']) {
      terminliste.add(converter.jsonToTermin(termin));
    }
    return terminliste;
  } // @formatter:on

  // ------------------------------ POST-Requests -----------------------------

  // @formatter:off
  /// "4.7.18 Admin Termin anlegen
  /// Endpunkt, um einen neuen Termin anzulegen. Es werden folgende Parameter übergeben. [...]
  /// Name, Beschreibung, Ort, Start Datum, End Datum, Zyklusid, Zyklus End-Datum, Plätze, Öffentlich
  /// (nicht erforderlich), sichtbar ab (nicht erforderlich), Anmeldung bis (nicht erforderlich)"
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void erstelleTermin(String name, String beschreibung, String ort, DateTime timeVon, DateTime timeBis,
      int zyklusID, DateTime zyklusEnde, int plaetze, [bool freigeschaltet, DateTime anmeldungStart, DateTime anmeldungEnde]) async {
    var _parameters = <String, String>{};
                                _parameters['token']        = variables.token;
                                _parameters['name']         = name;
                                _parameters['beschreibung'] = beschreibung;
                                _parameters['ort']          = ort;
                                _parameters['start_datum']  = '${converter.dateTimeFormat(timeVon)}';
                                _parameters['end_datum']    = '${converter.dateTimeFormat(timeBis)}';
                                _parameters['zyklusid']     = '$zyklusID';
                                _parameters['zyklus_ende']  = '${converter.dateFormat(zyklusEnde)}';
                                _parameters['plaetze']      = '$plaetze';
    if (freigeschaltet != null) _parameters['oeffentlich']  = '$freigeschaltet';
    if (anmeldungStart != null) _parameters['sichtbar_ab']  = '${converter.dateTimeFormat(anmeldungStart)}';
    if (anmeldungEnde  != null) _parameters['sichtbar_bis'] = '${converter.dateTimeFormat(anmeldungEnde)}';

    var _response = await http.post('${variables.url}/admin/termin', body: _parameters);
    if (_response.statusCode != 201) {
      throw exceptionHandler(_response.statusCode, c400: 'Termin konnte nicht erstellt werden.',
                                                   c422: 'Es fehlen benötigte Parameter.');
    }
  } // @formatter:on

  /// "4.7.23 Admin User zu Termin hinzufügen
  /// Endpunkt, um einen User nachträglich hinzuzufügen. Es \[muss\] die Userid [...] übergeben
  /// werden. Optional kann ein Kommentar hinzugefügt werden. Optional kann der Termin als bestätigt
  /// angegeben werden."
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void addUserZuTermin(int eventID, int userID, [String kommentar, bool bestaetigt]) async { // @formatter:off
    var parameters = <String, String>{};
                            parameters['token']      = variables.token;
                            parameters['eventid']    = '$eventID';
                            parameters['userid']     = '$userID';
    if (kommentar  != null) parameters['kommentar']  = kommentar;
    if (bestaetigt != null) parameters['bestaetigt'] = '$bestaetigt';

    var _response = await http.post('${variables.url}/admin/termin/user', body:parameters);
    if (_response.statusCode != 201) {
      throw exceptionHandler(_response.statusCode, c404: 'Userid existiert nicht / Termin nicht gefunden',
                                                   c400: 'User hat dem Termin bereits geantwortet');
    }
  } // @foramtter:on

  // ----------------------------- PATCH-Requests -----------------------------

  /// "4.7.21 Admin Termin User zusagen
  /// Endpunkt, um einen Termin zu bestätigen. Es werden die Terminid \[und\] die Userid [...]
  /// übergeben. Es kann optional ein Kommentar übergeben werden."
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void zusageUserTermin(int eventID,int userID, [String kommentar]) async { // @formatter:off
    var parameters = <String, String>{};
                           parameters['token']     = variables.token;
                           parameters['eventid']   = '$eventID';
                           parameters['userid']    = '$userID';
    if (kommentar != null) parameters['kommentar'] = kommentar;

    var _response = await http.patch('${variables.url}/admin/termin/zusagen', body: parameters);
    if (_response.statusCode != 204) throw exceptionHandler(_response.statusCode, c404: 'Termin existiert nicht / Userid unbekannt');
  } // @formatter:on

  /// "4.7.22 Admin Termin User absagen
  /// Endpunkt, um einen Termin abzusagen. Es werden die Terminid \[und\] die Userid[...]
  /// übergeben. Es kann optional ein Kommentar übergeben werden."
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void absageUserTermin(int eventID, int userID, [String kommentar]) async { // @formatter:off
    var parameters = <String, String>{};
    parameters['token']     = variables.token;
    parameters['eventid']   = '$eventID';
    parameters['userid']    = '$userID';
    if (kommentar != null) parameters['kommentar'] = kommentar;

    var _response = await http.patch('${variables.url}/admin/termin/absagen', body: parameters);
    if (_response.statusCode != 204) throw exceptionHandler(_response.statusCode, c404: 'Termin existiert nicht / Userid unbekannt');
  } // @formatter:on

  // @formatter:off
  /// "4.7.19 Admin Termin bearbeiten
  /// Endpunkt, um einen Termin zu bearbeiten. Es \[muss\] die Terminid [...] übergeben
  /// werden. Optional können folgende Parameter übergeben werden. Name, Beschreibung, Ort, Plätze,
  /// Start Datum, End Datum, Öffentlich, sichtbar ab, Anmeldung bis."
  ///
  /// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
  static void bearbeiteTermin(int eventID, [String name, String beschreibung, String ort, DateTime startDatum,
        DateTime endDatum, int plaetze, bool oeffentlich, DateTime sichtbarAb, DateTime anmeldungBis]) async {
    var parameters = <String, String>{};
    parameters['token']        = variables.token;
    parameters['eventid']      = '$eventID';
    if (name         != null) parameters['name']          = name;
    if (beschreibung != null) parameters['beschreibung']  = beschreibung;
    if (ort          != null) parameters['ort']           = ort;
    if (startDatum   != null) parameters['start_datum']   = '${converter.dateTimeFormat(startDatum)}';
    if (endDatum     != null) parameters['end_datum']     = '${converter.dateTimeFormat(endDatum)}';
    if (plaetze      != null) parameters['plaetze']       = '$plaetze';
    if (oeffentlich  != null) parameters['oeffentlich']   = '$oeffentlich';
    if (sichtbarAb   != null) parameters['sichtbar_ab']   = '${converter.dateTimeFormat(sichtbarAb)}';
    if (anmeldungBis != null) parameters['anmeldung_bis'] = '${converter.dateTimeFormat(anmeldungBis)}';

    var _response = await http.patch('${variables.url}/admin/termin', body: parameters);
    if (_response.statusCode != 204) throw exceptionHandler(_response.statusCode);
  } // @formatter:on

  // ----------------------------- DELETE-Requests ----------------------------

  /// "4.7.20 Admin Termin löschen
  /// Endpunkt, um einen Termin zu löschen. Es \[wird\] die Terminid [...] übergeben."
  ///
  /// Dokumentation der API-Doku v2.5 v. Tobias Möller entnommen
  static void terminLoeschen(int id) async { // @formatter:off
    var _response = await http.delete('${variables.url}/admin/termin?token=${variables.token}&eventid=$id');
    if (_response.statusCode != 204) throw exceptionHandler(_response.statusCode);
  } // @formatter:on
}