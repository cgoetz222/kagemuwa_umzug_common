class Campaign implements Comparable<Campaign> {
  String id;
  String year;
  bool active;
  bool selected;

  Campaign(this.id, this.year, this.active, this.selected);

  factory Campaign.fromJson(String id, Map<String, dynamic> jsonMap) {
    final String year;
    final bool active;
    final bool selected;

    if(jsonMap['year'] != null) {
      year = jsonMap['year'];
    } else {
      year = "";
    }
    if(jsonMap['active'] != null) {
      active = jsonMap['active'] as bool;
    } else {
      active = false;
    }
    if(jsonMap['selected'] != null) {
      selected = jsonMap['selected'] as bool;
    } else {
      selected = false;
    }

    return Campaign(id, year, active, selected);
  }

  Map<String, dynamic> toJson() => {
    'year': year,
    'active': active,
    'selected': selected,
  };

  void setID(String id) {
    this.id = id;
  }

  @override
  int compareTo(other) {
    return year.compareTo(other.year);
  }
}