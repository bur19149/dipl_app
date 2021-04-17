// @formatter:off
/// Der Exceptionhandler liest den Statuscode aus und gibt die dazugehörige Exception zurück.
/// Optional können für die jeweiligen Fehlercodes auch benutzderdefinierte Fehlermeldungen
/// definiert werden.
Exception exceptionHandler(int statusCode, {String c400, String c401, String c403,
                                            String c404, String c405, String c409,
                                            String c410, String c422, String c423,
                                            String c429, String c500, String c501, String c503}) {
  Exception exception;
  switch (statusCode) {
    case 400: exception = _Exception400(c400); break;
    case 401: exception = _Exception401(c401); break;
    case 403: exception = _Exception403(c403); break;
    case 404: exception = _Exception404(c404); break;
    case 405: exception = _Exception405(c405); break;
    case 409: exception = _Exception409(c409); break;
    case 410: exception = _Exception410(c410); break;
    case 422: exception = _Exception422(c422); break;
    case 423: exception = _Exception423(c423); break;
    case 429: exception = _Exception429(c429); break;
    case 500: exception = _Exception500(c500); break;
    case 501: exception = _Exception501(c501); break;
    case 503: exception = _Exception503(c503); break;
    default: exception = Exception('Unerwarteter Fehler: $statusCode');
  }
  return exception;
} // @formatter:on

// ------------------------------- Exceptions -------------------------------

// @formatter:off
class _Exception400 extends _HttpException { _Exception400([String message]) : super(400, 'Bad Request / Allgemeiner Fehler in der Anfrage',    message); }
class _Exception401 extends _HttpException { _Exception401([String message]) : super(401, 'Kein Token mitgeschickt oder Token existiert nicht', message); }
class _Exception403 extends _HttpException { _Exception403([String message]) : super(403, 'Keine Berechtigung',                                 message); }
class _Exception404 extends _HttpException { _Exception404([String message]) : super(404, 'Anfrage existiert nicht',                            message); }
class _Exception405 extends _HttpException { _Exception405([String message]) : super(405, 'Falsche Request Methode verwendet',                  message); }
class _Exception409 extends _HttpException { _Exception409([String message]) : super(409, 'Die Anfrage wurde unter falschen Annahmen gestellt', message); }
class _Exception410 extends _HttpException { _Exception410([String message]) : super(410, 'Die Ressource wurde entfernt',                       message); }
class _Exception422 extends _HttpException { _Exception422([String message]) : super(422, 'Semantisch falsche Anfrage',                         message); }
class _Exception423 extends _HttpException { _Exception423([String message]) : super(423, 'Die Ressource ist noch nicht zugänglich',            message); }
class _Exception429 extends _HttpException { _Exception429([String message]) : super(429, 'Es wurden zu viele Anfragen gestellt',               message); }
class _Exception500 extends _HttpException { _Exception500([String message]) : super(500, 'Allgemeiner Server Fehler',                          message); }
class _Exception501 extends _HttpException { _Exception501([String message]) : super(501, 'Anfrage wurde noch nicht implementiert',             message); }
class _Exception503 extends _HttpException { _Exception503([String message]) : super(503, 'API ist im Wartungsmodus',                           message); }
// @formatter:on

// ------------------------------- Sonstiges --------------------------------

/// Pruefung ob Exception eine _HttpException ist
bool _isHttpException(var e) => e is _HttpException;

/// Extrahiert Exception-String
String getExceptionString(var e) => _isHttpException(e) ? (e as _HttpException).toStringGUI() : e;

/// Exception, von der alle, bei HTTP-Requests eventuell auftretenden, Exceptions ableiten.
class _HttpException implements Exception { // @formatter:off

  // -------------------------------- Variablen -------------------------------

  final int    code;            // Fehlercode
  final String standardMessage; // Nachricht wenn keine benutzderdefinierte Fehlermeldung definiert wurde
  final String message;         // benutzerdefinierte Fehlermeldung

  // ----------------------------- Konstruktoren ------------------------------

  _HttpException(this.code, this.standardMessage, [this.message]);

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return 'Exception ($code): ${message ?? standardMessage}';
  }

  String toStringGUI() {
    return '${message ?? standardMessage}';
  }
} // @formatter:on