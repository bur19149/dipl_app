/// Prüft auf NULL, leeren String und liefert den String ohne
/// nachfolgende und führende leerzeichen zurück.
String stringPrufung(String value) {
  if (value == null) {
    throw 'Dieses feld darf nicht null sein';
  } else {
    value = value.trim();
    if (value.isEmpty) {
      throw 'Dieses Feld darf nicht leer sein';
    } else {
      return value;
    }
  }
}

/// Wird mit einer Regular Expression getestet. Wird in set Vorname und set Nachname verwendet
String prufeName(String value) {
  var a = RegExp(r'^[A-Za-z0-9öÖäÄüÜßàéëïáêèíîôóúûŠšŽžÅÕõÇÊÎŞÛçşĂÂŢăâţĳÆØæøåÔŴŶÁÉÍÏŵŷÓÚẂÝÀÈÌÒÙẀỲËẄŸẃýì'
      r'òùẁỳẅÿĈĜĤĴŜŬĉĝĥĵŝŭĞİğıÐÞðþŐŰőűŒœãÑñÃẼĨŨỸẽĩũỹĄĘĮŁŃąęįłńǪāēīōǫǭūŲųżćśźůŻČĆĐĎĚŇŘŤŮď'
      r'ěňřťĽĹŔľĺŕĀĒĢĪĶĻŅŌŖŪģķļņŗĖėẢẠẰẲẴẮẶẦẨẪẤẬẺẸỀỂỄẾỆỈỊỎỌỒỔỖỐỘƠỜỞỠỚỢỦỤƯỪỬỮỨỰỶỴđảạằẳẵắặầ'
      r'ẩẫấậẻẹềểễếệỉịỏọồổỗốơờởỡớợủụưừửữứựỷỵꞗĕŏ᷄() ]+$');
  if (a.hasMatch(value)) {
    return value;
  } else {
    throw ('Ungültiger Name.');
  }
}

/// 9007199254740992 ist der grosste Integer in Javascript (API in JS) *throws up*
int prufeID(int value) {
  if (value < 0 || value > 9007199254740992) {
    throw Exception('Die ID ist ungültig $value.');
  } else {
    return value;
  }
}

/// Prüft ob der Ortsname ein gültiger String ist
String pruefeOrt(String value) {
  RegExp a = RegExp(r'^[ A-zöÖäÄüÜ]+$');
  if (a.hasMatch(value)) {
    return value;
  } else {
    throw ('Ungüliger Ort.');
  }
}