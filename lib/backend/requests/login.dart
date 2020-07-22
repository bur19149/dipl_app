// -------------------------------- Imports ---------------------------------
// @formatter:off
import 'package:device_info/device_info.dart';
import '../pruefungen.dart'     as pruefungen;
import 'package:http/http.dart' as http;
import '../converter.dart'      as converter;
import 'variables.dart'         as variables;
import '../objects.dart'        as objects;
import 'dart:convert'           as convert;
import '../exceptions.dart';
import 'dart:io';
// @formatter:on

// ------------------------------ GET-Requests ------------------------------

/// "4.7.3 User Daten
/// Endpunkt, um die User Daten zu dem API Token zu erfragen. Als Parameter wird der Token
/// übergeben. Die Rückgabe enthält alle Daten zu dem User nach Berechtigung. Admin Notizen und
/// hinzugefügte Dateien werden nur mit Berechtigung ausgegeben. Besitzt der Account weitere
/// verbundene Accounts, so werden diese auch mit ausgegeben."
///
/// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
Future<objects.User> requestUser() async { // @formatter:off
  var _response = await http.get('${variables.url}/user?token=${variables.token}');
  if (_response.statusCode != 200) throw exceptionHandler(_response.statusCode);
  return converter.jsonToUser(convert.jsonDecode(_response.body)['data']['user']);
} // @formatter:on

// ------------------------------ POST-Requests -----------------------------

// TODO Parameter Name und Model implemetieren
/// "4.7.1 Pairing
/// Dieser Endpunkt dient zum Verbinden eines Accounts mit einer App. Es wird der lesbare User
/// Schlüssel als Parameter angenommen und ein neu generierter API Token zurückgegeben. Dieser
/// Token wird in der Datenbank mit dem User Account verknüpft. [...]"
///
/// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
Future<String> link(String userkey) async { // @formatter:off
  var _response = await http.post('${variables.url}/link', body: {
    'userkey': '$userkey',
    'name':    getName(),
    'model':   getModel(),
    'version': variables.appVersion
  });
  if(_response.statusCode != 200) {
    exceptionHandler(_response.statusCode, c404: 'Ein solcher Schlüssel existiert nicht in der Datenbank',
                                           c400: 'Der Schlüssel ist abgelaufen oder wurde bereits erfolgreich benutzt.',
                                           c422: 'Es fehlen ein oder mehr Parameter');
  }
  return RegExp('.*"(.*)"}}').allMatches(_response.body).toList()[0].group(1);
} // @formatter:on

/// "4.7.2 Validate Token
/// Endpunkt, um die Gültigkeit eines Tokens zu erfragen. Als Parameter wird der Token übergeben."
///
/// Dokumentation der API-Doku v2.6 v. Tobias Möller entnommen
validate() async { // @formatter:off
  var _response = await http.get('${variables.url}/validate?token=${variables.token}');
  if(_response.statusCode != 200) {
    throw exceptionHandler(_response.statusCode, c401: 'Ein solcher Token existiert nicht in der Datenbank.',
                                                 c403: 'Der Token ist abgelaufen bzw. wurde vom User entfernt.');
  }
} // @formatter:on

// --------------------------------- Andere ---------------------------------

/// Übergibt den Schlüssel [link], welches daraus einen Token generiert, der dann in ein Text-File gespeichert wird.
login(String value) async { // @formatter:off
  if (!RegExp('[0-9A-Za-z]{8}').hasMatch(pruefungen.stringPrufung(value))) throw 'Ungültiger UserToken.';
    await variables.FileHandler.writeFile(await link(value));
} // @formatter:on

Future<String> getModel() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo a = await deviceInfo.androidInfo;
    return 'Manufacturer: ${a.manufacturer}, Brand: ${a.brand}, Model: ${a.model}, AndrodID: '
        '${a.androidId}, isPhysicalDevice: ${a.isPhysicalDevice} Fingerprint: ${a.fingerprint}';
  } else if (Platform.isIOS) {
    IosDeviceInfo i = await deviceInfo.iosInfo;
    return 'Model: ${i.model}, Name: ${i.name}, SystemVersion: ${i.systemVersion}, '
        'IsPhysicalDevice: ${i.isPhysicalDevice}';
  } else
    throw 'Platform nicht erkannt.';
}

Future<String> getName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo a = await deviceInfo.androidInfo;
    return 'Name: ${a.host}';
  } else if (Platform.isIOS) {
    IosDeviceInfo i = await deviceInfo.iosInfo;
    return 'Name: ${i.name}, SystemName: ${i.systemName}';
  } else throw 'Platform nicht erkannt.';
}