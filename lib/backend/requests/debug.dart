// -------------------------------- Imports ---------------------------------

// @formatter:off
import 'package:http/http.dart' as http;
import '../objects.dart'        as objects;
// @formatter:on

/// Nur zu Debuggingzwecken
/// Wird verwendet um die Reaktion des Servers in der Konsole zu dokumentieren.
void output(http.Response response) {
  print('Response status: ${response.statusCode}\nResponse body:   ${response.body}');
}

/// Nur zu Debuggingzwecken
/// Wird verwendet um Userlisten in der Konsole auszugeben.
void printListe(var liste) {
  for(var item in liste){
  print('$item\n\n###########################################################################\n\n');
  }
}