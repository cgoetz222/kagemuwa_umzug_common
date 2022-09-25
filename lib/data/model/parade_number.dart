import 'dart:core';

class ParadeNumber implements Comparable<ParadeNumber> {
  static const String ZUGNUMMER_WAGEN = "W";
  static const String ZUGNUMMER_GROSSGRUPPE = "G";
  static const String ZUGNUMMER_KLEINGRUPPE = "K";
  static const String ZUGNUMMER_RESERVE = "R";
  static const String ZUGNUMMER_MUSIK = "M";
  static const String ZUGNUMMER_KAGEMUWA = "KG";

  String id;
  int number;
  String name;
  String club;
  String type;
  bool evaluate;

  ParadeNumber(this.id, this.number, this.name, this.club, this.type, this.evaluate);

  factory ParadeNumber.fromJson(String id, Map<String, dynamic> jsonMap) {
    final int number;
    final String name;
    final String club;
    final String type;
    final bool evaluate;

    if(jsonMap['number'] != null) {
      number = jsonMap['number'] as int;
    } else {
      number = 0;
    }
    if(jsonMap['name'] != null) {
      name = jsonMap['name'] as String;
    } else {
      name = '';
    }
    if(jsonMap['club'] != null) {
      club = jsonMap['club'] as String;
    } else {
      club = '';
    }
    if(jsonMap['type'] != null) {
      type = jsonMap['type'] as String;
    } else {
      type = '';
    }
    if(jsonMap['evaluate'] != null) {
      evaluate = jsonMap['evaluate'] as bool;
    } else {
      evaluate = false;
    }

    return ParadeNumber(
        id,
        number,
        name,
        club,
        type,
        evaluate,
    );
  }

  Map<String, dynamic> toJson() => {
    'number': number,
    'name' : name,
    'club': club,
    'type': type,
    'evaluate': evaluate,
  };

  String getNumberAsString() {
    return number.toString();
  }

  String getParadeTypeDescription() {
    switch(type) {
      case "W": return "Wagen";
      case "G": return "Großgruppe";
      case "K": return "Kleingruppe";
      case "R": return "Reserve";
      case "M": return "Musikverein";
      case "KG": return "KaGeMuWa";
      default: return "";
    }
  }

  @override
  int compareTo(ParadeNumber other) {
    return number.compareTo(other.number);
  }
}