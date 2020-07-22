// -------------------------------- Imports ---------------------------------

// @formatter:off
import 'dart:collection';
import 'package:intl/intl.dart' as intl;
import 'objects.dart'           as objects;
// @formatter:on

// --------------------------- DateTime zu String ---------------------------

// @formatter:off
// Werden verwendet um DateTimes in für den Server verwertbare Strings umzuwandeln.

/// Konvertiert ein DateTime in einen String nach dem Schema dd.MM.yyyy
dateFormat(DateTime date) => intl.DateFormat('dd.MM.yyyy').format(date);

/// Konvertiert ein DateTime in einen String nach dem Schema dd.MM.yyyy HH:mm
dateTimeFormat(DateTime dateTime) => intl.DateFormat('dd.MM.yyyy HH:mm').format(dateTime);
//@formatter:on

// ------------------------------ JSON zu User ------------------------------

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein User-, oder Admin-Objekt.
objects.User jsonToUser(LinkedHashMap jsonAsList) { // @formatter:off
  var _children = <int>[];
  if (jsonAsList['children'] != null && jsonAsList['children'].isNotEmpty) {
    for (var id in jsonAsList['children']) {
      _children.add(id is int ? id : jsonToUser(id).userID);
    }
  }
  if (jsonAsList['dsgvo'] != null && jsonAsList['anmeldung'] != null && jsonAsList['portal'] != null) {
    return objects.Admin(
        jsonAsList['userid'],
        jsonAsList['vorname'],
        jsonAsList['nachname'],
        jsonAsList['email'],
        jsonAsList['plz'],
        jsonAsList['ort'],
        jsonToUserTyp(jsonAsList['typ']),
        jsonAsList['jugendgruppe'],
        jsonAsList['parent'] is int || jsonAsList['parent'] == null ? jsonAsList['parent'] : jsonToUser(jsonAsList['parent']).userID,
        _children.isNotEmpty ? _children : null,
        jsonAsList['registered'],
        jsonAsList['dsgvo'],
        jsonAsList['anmeldung'],
        jsonAsList['portal']);
  }
  return objects.User(
      jsonAsList['userid'],
      jsonAsList['vorname'],
      jsonAsList['nachname'],
      jsonAsList['email'],
      jsonAsList['plz'],
      jsonAsList['ort'],
      jsonToUserTyp(jsonAsList['typ']),
      jsonAsList['jugendgruppe'],
      jsonAsList['parent'] is int || jsonAsList['parent'] == null ? jsonAsList['parent'] : jsonToUser(jsonAsList['parent']).userID,
      _children.isNotEmpty ? _children : null,
      jsonAsList['registered']);
} // @formatter:on

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein UserTyp-Objekt.
objects.UserTyp jsonToUserTyp(LinkedHashMap jsonAsList) { // @formatter:off
  return objects.UserTyp(
      jsonAsList['typid'],
      jsonAsList['name'],
      jsonAsList['permissions'] != null ? jsonToPermission(jsonAsList['permissions']) : null);
} // @formatter:on

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in eine Liste mit Permission-Objekten.
List<objects.Permission> jsonToPermission(var jsonAsList) { // @formatter:off
  var permissions = <objects.Permission>[];
  for (var p in jsonAsList) {
    permissions.add(objects.Permission(p['permissionid'], p['name'], p['description'], p['code']));
  }
  return permissions;
} // @formatter:on

// ----------------------------- JSON zu Termin -----------------------------

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein User-, oder AdminTermin-Objekt.
objects.UserTermin jsonToTermin(LinkedHashMap jsonAsList) {
  var teilnehmer = <objects.AntwortTermin>[];
  for (var antwortTermin in jsonAsList['users']) {
    teilnehmer.add(jsonToAntwortTermin(antwortTermin));
  }
  if (jsonAsList['freigeschaltet'] != null) {
    return objects.AdminTermin(
        jsonAsList['plaetze'],
        jsonAsList['ort'],
        jsonAsList['name'],
        jsonAsList['beschreibung'],
        DateTime.parse(jsonAsList['time']['start']),
        DateTime.parse(jsonAsList['time']['ende']),
        jsonToZyklus(jsonAsList['zyklus']),
        teilnehmer,
        jsonAsList['freigeschaltet'],
        DateTime.parse(jsonAsList['anmeldung']['start']),
        DateTime.parse(jsonAsList['anmeldung']['ende']),
        jsonAsList['zyklus_Ende'] != null ? DateTime.parse(jsonAsList['zyklus_Ende']) : null,
        jsonAsList['terminid'],
        jsonAsList['veranstaltungid']);
  }
  return objects.UserTermin(
      jsonAsList['plaetze'],
      jsonAsList['ort'],
      jsonAsList['name'],
      jsonAsList['beschreibung'],
      DateTime.parse(jsonAsList['time']['start']),
      DateTime.parse(jsonAsList['time']['ende']),
      jsonToZyklus(jsonAsList['zyklus']),
      teilnehmer,
      DateTime.parse(jsonAsList['anmeldung']['start']),
      DateTime.parse(jsonAsList['anmeldung']['ende']),
      jsonAsList['zyklus_Ende'] != null ? DateTime.parse(jsonAsList['zyklus_Ende']) : null,
      jsonAsList['terminid'],
      jsonAsList['veranstaltungid']);
}

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein AntwortTermin-Objekt.
objects.AntwortTermin jsonToAntwortTermin(LinkedHashMap jsonAsList) {
  return objects.AntwortTermin(
      jsonToUser(jsonAsList['user']),
      jsonToAntwort(jsonAsList['antwort']['user']),
      jsonToAntwort(jsonAsList['antwort']['leiter']),
      jsonAsList['kommentar']);
}

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein Antwort-Objekt.
objects.Antwort jsonToAntwort(LinkedHashMap jsonAsList) {
  return objects.Antwort(jsonAsList['id'], jsonAsList['name']);
}

/// Konvertiert ein, mittels jsonDecode aus der dart:convert Library in eine LinkedHashMap konvertiertes, json-File
/// in ein Zyklus-Objekt.
objects.Zyklus jsonToZyklus(LinkedHashMap jsonAsList) { // @formatter:off
  return objects.Zyklus(jsonAsList['zyklusid'] ?? jsonAsList['id'], jsonAsList['name']);
} // @formatter:on
