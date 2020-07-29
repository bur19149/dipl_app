// -------------------------------- Imports ---------------------------------

// @formatter:off
//import 'package:path_provider/path_provider.dart';
import 'converter.dart'          as converter;
import 'requests/variables.dart' as variables;
import 'package:http/http.dart'  as http;
import 'pruefungen.dart'         as pruefungen;
import 'dart:io';
// @formatter:on

/// Einfacher Benutzer
class User {
  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  int        _userID;       // einzigartige ID
  String     jugendgruppe;
  String     _nachname;
  String     _vorname;
  String     _email;
  String     _plz;
  String     _ort;
  int        parent;        // (optional) zugeordneter Elternaccount wenn Kind
  UserTyp    _typ;
  List<int>  children;      // (optional) zugeordnete Kinder wenn Elternaccount
  bool       registered;    // Zweck des Parameters wird in API-Doku nicht erklärt
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  User(int userID, String vorname, String nachname, String email, String plz, String ort,
      UserTyp typ, String jugendgruppe, int parent, List<int> children, bool registered) {
    this.userID       = userID;
    this.vorname      = vorname;
    this.nachname     = nachname;
    this.email        = email;
    this.plz          = plz;
    this.ort          = ort;
    this.typ          = typ;
    this.jugendgruppe = jugendgruppe;
    this.parent       = parent;
    this.children     = children;
    this.registered   = registered;
  } // @formatter:on

  // --------------------------------- Setter ---------------------------------

  set userID(int value) {
    _userID = pruefungen.prufeID(value);
  }

  set vorname(String value) {
    _vorname = pruefungen.prufeName(pruefungen.stringPrufung(value));
  }

  set nachname(String value) {
    _nachname = pruefungen.prufeName(pruefungen.stringPrufung(value));
  }

  set plz(String value) {
    var intplz = int.parse(pruefungen.stringPrufung(value));
    if (intplz < 1000 || intplz > 9992) throw 'Die Postleitzahl ist ungültig.';
    _plz = value;
  }

  set ort(String value) {
    _ort = pruefungen.pruefeOrt(pruefungen.stringPrufung(value));
  }

  set typ(UserTyp value) {
    if (value == null) {
      throw Exception('Null übergabe.');
    } else {
      _typ = value;
    }
  }

  set email(String value) {
    if (RegExp('[0-9A-Za-z!#\$%&+\\/=?^_`{|}~-]+(?:\.[0-9A-Za-z!#\$%&+\\/=?^_`{|}~-]+)'
        '{0,1}@[0-9A-Za-z][0-9A-Za-z-]{0,253}[0-9A-Za-z][0-9A-Za-z-]{0,253}\.[0-9A-Za-z]{2,}')
        .hasMatch(pruefungen.stringPrufung(value))) throw 'Ungültige Email-Adresse';
      _email = value;
  }

  // --------------------------------- Getter ---------------------------------

  // @formatter:off
  int        get userID   => _userID;
  String     get vorname  => _vorname;
  String     get nachname => _nachname;
  String     get plz      => _plz;
  String     get ort      => _ort;
  String     get email    => _email;
  UserTyp    get typ      => _typ;
  // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    String str =
        'Name:         $_vorname $_nachname ($_userID)\nWohnort:      $_ort ($_plz)\nE-Mail:       '
                '$_email\n' +
            (jugendgruppe != null ? 'Jugendgruppe: $jugendgruppe\n' : '') +
            'Registriert:  $registered\n${_typ.toString()}';
    if (parent != null) {
      str += 'Elternteil:   $parent';
    }
    if (children != null && children.isNotEmpty) {
      str += '\nKinder:\n---------------\n';
      for (int child in children) {
        str += '$child\n';
      }
      str += '---------------\n';
    }
    return str;
  }
}

/// Administrator-Benutzer
class Admin extends User {
  // -------------------------------- Variablen -------------------------------

  String dsgvo;
  String portal;
  String anmeldung;

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  Admin(int userID, String vorname, String nachname, String email, String plz, String ort,
      UserTyp typ, String jugendgruppe, int parent, List<int> children, bool registered,
      String dsgvo, String portal, String anmeldung) : super(userID, vorname, nachname, email,
      plz, ort, typ, jugendgruppe, parent, children, registered) {
    this.dsgvo     = dsgvo;
    this.portal    = portal;
    this.anmeldung = anmeldung;
  } // @formatter:on

  // -------------------------------- toString --------------------------------

  // @formatter:off
  @override
  String toString() {
    return super.toString() +
        (dsgvo     != null && dsgvo.isNotEmpty     ? 'DSGVO:     $dsgvo\n'     : '') +
        (anmeldung != null && anmeldung.isNotEmpty ? 'Anmeldung: $anmeldung\n' : '') +
        (portal    != null && portal.isNotEmpty    ? 'Portal:    $portal'      : '');
  } // @formatter:on
}

/// Definiert welchen Typ ein Bentzer hat
/// Über den Typen werden die Berechtigungen eines Benutzers definiert
class UserTyp {
  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  int              _typID;      // ID des Typs
  String           _name;       // Bezeichnung des Usertyps z. B. Admin
  List<Permission> permissions; // Liste der Berechtigungen
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  UserTyp(int typID, String name, List<Permission> permission) {
    this.typID       = typID;
    this.name        = name;
    this.permissions = permission;
  } // @formatter:on

  // --------------------------------- Setter ---------------------------------

  set typID(int value) {
    _typID = pruefungen.prufeID(value);
  }

  set name(String value) {
    _name = pruefungen.prufeName(pruefungen.stringPrufung(value));
  }

  // --------------------------------- Getter ---------------------------------

  // @formatter:off
  int              get typID       => _typID;
  String           get name        => _name;
  // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    String str = 'User-Typ:     $_name ($_typID)\nBerechtigungen:\n---------------\n';
    if (permissions != null) {
      for (Permission p in permissions) {
        str += p.toString() + '\n---------------\n';
      }
    }
    return str;
  }
}

/// Benutzerberechtigung
class Permission {
  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  final int    permissionID; // einzigartige ID
  final String description;  // Beschreibung der Berechtigung
  final String name;
  final String code;         // Berechtigungscode z. B. termin.bearbeiten
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  /// Konstruktor
  const Permission(this.permissionID, this.description, this.name, this.code);

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return 'Berechtigung: $name ($permissionID)\nBeschreibung: $description\nCode:         $code';
  }
}

/// Termin mit allen für den einfachen Nutzer relevanten Parametern
class UserTermin {

  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  int                 _plaetze;
  int                 terminID;
  int                 veranstaltungsID;
  String              ort;
  String              name;
  String              beschreibung;
  DateTime            zyklusEnde;
  DateTime            anmeldungStart;
  DateTime            anmeldungEnde;
  DateTime            timeVon;
  DateTime            timeBis;
  Zyklus              _zyklus;
  List<AntwortTermin> teilnehmer;
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  UserTermin(int plaetze, String ort, String name, String beschreibung, DateTime timeVon,
      DateTime timeBis, Zyklus zyklus, List<AntwortTermin> teilnehmer, [DateTime anmeldungStart,
      DateTime anmeldungEnde, DateTime zyklusEnde, int terminID, int veranstaltungsID]) {
    this.plaetze           = plaetze;
    this.terminID         = terminID;
    this.veranstaltungsID = veranstaltungsID;
    this.ort              = ort;
    this.name             = name;
    this.beschreibung     = beschreibung;
    this.anmeldungStart   = anmeldungStart;
    this.anmeldungEnde    = anmeldungEnde;
    this.timeVon          = timeVon;
    this.timeBis          = timeBis;
    this.zyklus           = zyklus;
    this.teilnehmer       = teilnehmer;
    this.zyklusEnde       = zyklusEnde;
  } //formatter:on

  // --------------------------------- Setter ---------------------------------

  /// Die maximale Anzahl Plätze auf der Website ist 99.
  set plaetze(int value) {
    if (value < 1 || value > 99) throw 'Die Platzanzahl ist ungültig.';
    _plaetze = value;
  }

  set zyklus(Zyklus value) {
    if (value == null) throw 'Zyklus darf nicht null sein!';
    _zyklus = value;
  }

  // --------------------------------- Getter ---------------------------------

  // @formatter:off
  int      get plaetze          => _plaetze;
  Zyklus   get zyklus           => _zyklus;
  // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    String str = 'Termin:            $name' + (terminID != null ? ' ($terminID)' : '') + '\nAnzahl Plätze:     '
        '$_plaetze\nOrt:               $ort\nBeschreibung:      $beschreibung' + (veranstaltungsID != null ? '\nVeranstaltungs-ID: $veranstaltungsID' : '') +
        (anmeldungStart != null ? '\nAnmeldestart:      ${converter.dateTimeFormat(anmeldungStart)}' : '') +
        (anmeldungEnde != null ? '\nAnmeldeschluss:    ${converter.dateTimeFormat(anmeldungEnde)}' : '') + (timeVon != null && timeBis != null ? '\nZeitraum:          '
        '${converter.dateTimeFormat(timeVon)} - ${converter.dateTimeFormat(timeBis)}' : '') +
        '\n$_zyklus' + (zyklusEnde != null ? '\nZyklus-Ende:       ${converter.dateFormat(zyklusEnde)}' : '');
    if (teilnehmer != null && teilnehmer.isNotEmpty) {
      str += '\nTeilnehmer:\n---------------';
      for (AntwortTermin antwortTermin in teilnehmer) {
        str += '\n$antwortTermin\n---------------';
      }
    }
    return str;
  }
}

/// Termin mit allen Parametern (wird für die Terminverwaltung benötigt)
class AdminTermin extends UserTermin {

  // -------------------------------- Variablen -------------------------------

  bool freigeschaltet;

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  AdminTermin(int platze, String ort, String name,
      String beschreibung, DateTime timeVon, DateTime timeBis, Zyklus zyklus, [List<AntwortTermin> teilnehmer, bool freigeschaltet,
      DateTime anmeldungStart, DateTime anmeldungEnde, DateTime zyklusEnde, int terminid, int veranstaltungsid])
      : super(platze, ort, name, beschreibung, timeVon, timeBis, zyklus, teilnehmer, anmeldungStart, anmeldungEnde, zyklusEnde, terminid, veranstaltungsid) {
    this.freigeschaltet = freigeschaltet;
  } // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return super.toString() + (freigeschaltet != null ? '\nfreigeschaltet:    $freigeschaltet' : '');
  }
}

/// Wird verwendet um die Zeitabstände, in denen regelmäßige Termine stattfinden, zu definieren.
class Zyklus {

  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  int   _zyklusID;
  String name;
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  Zyklus(int zyklusID, String name) {
    this.zyklusID = zyklusID;
    this.name     = name;
  } // @formatter:on

  // --------------------------------- Setter ---------------------------------

  set zyklusID(int value) {
    _zyklusID = pruefungen.prufeID(value);
  }

  // --------------------------------- Getter ---------------------------------

  int get zyklusID => _zyklusID;

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return 'Zyklus:            $name ($_zyklusID)';
  }
}

/// Reaktion des Users, oder Gruppenleits auf einen Termin
class Antwort {

  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  int    _id;
  String _name;
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  Antwort(int id, String name){
    this.id = id;
    this.name = name;
  } // @formatter:on

  // --------------------------------- Setter ---------------------------------

  set id(int id) {
    _id = id;
  }

  set name(String name) {
    _name = name;
  }

  // --------------------------------- Getter ---------------------------------

  // @formatter:off
  int    get id   => _id;
  String get name => _name;
  // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return 'Antwort:      $_name ($_id)';
  }
}

/// Antwort auf einen Termin z.B. Zusage, oder Absage
class AntwortTermin {

  // -------------------------------- Variablen -------------------------------

  // @formatter:off
  User    _user;
  Antwort _antwortUser;
  Antwort _antwortLeiter;
  String  kommentar;
  // @formatter:on

  // ----------------------------- Konstruktoren ------------------------------

  // @formatter:off
  /// Konstruktor
  AntwortTermin(User user, Antwort antwortUser, Antwort antwortLeiter, String kommentar) {
    this.user          = user;
    this.antwortUser   = antwortUser;
    this.antwortLeiter = antwortLeiter;
    this.kommentar     = kommentar;
  } // @formatter:on

  // --------------------------------- Setter ---------------------------------

  set user(User user) {
    _user = user;
  }

  set antwortUser(Antwort antwortUser) {
    _antwortUser = antwortUser;
  }

  set antwortLeiter(Antwort antwortLeiter) {
    _antwortLeiter = antwortLeiter;
  }

  // --------------------------------- Getter ---------------------------------

  // @formatter:off
  User    get user          => _user;
  Antwort get antwortUser   => _antwortUser;
  Antwort get antwortLeiter => _antwortLeiter;
  // @formatter:on

  // -------------------------------- toString --------------------------------

  @override
  String toString() {
    return 'Antwort-Termin:    ${_user.vorname} ${_user.nachname} (${_user
        .userID})\n' +
        (kommentar != null ? 'Kommentar:         $kommentar\n' : '') +
        'User-${_antwortUser}\nLeit-${_antwortLeiter}';
  }
}