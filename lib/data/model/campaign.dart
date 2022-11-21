class Campaign implements Comparable<Campaign> {
  static const int WEIGHT_HUMOR = 2;
  static const int WEIGHT_OPTIC_ORIGINALITY = 2;
  static const int WEIGHT_DISTANCE_VOLUME = 1;
  static const int NUMBER_OF_RATERS = 20;

  String id;
  String year;
  bool active;
  bool selected;
  int numberOfRaters;
  int weightHumor;
  int weightOpticOriginality;
  int weightDistanceVolume;

  Campaign(this.id, this.year, this.active, this.selected, this.numberOfRaters, this.weightHumor, this.weightOpticOriginality, this.weightDistanceVolume);

  factory Campaign.fromJson(String id, Map<String, dynamic> jsonMap) {
    final String year;
    final bool active;
    final bool selected;
    int weightHumor;
    int weightOpticOriginality;
    int weightDistanceVolume;
    int numberOfRaters;

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
    if(jsonMap['numberOfRaters'] != null) {
      numberOfRaters = jsonMap['numberOfRaters'] as int;
    } else {
      numberOfRaters = NUMBER_OF_RATERS;
    }
    if(jsonMap['weightHumor'] != null) {
      weightHumor = jsonMap['weightHumor'] as int;
    } else {
      weightHumor = WEIGHT_HUMOR;
    }
    if(jsonMap['weightOpticOriginality'] != null) {
      weightOpticOriginality = jsonMap['weightOpticOriginality'] as int;
    } else {
      weightOpticOriginality = WEIGHT_OPTIC_ORIGINALITY;
    }
    if(jsonMap['weightDistanceVolume'] != null) {
      weightDistanceVolume = jsonMap['weightDistanceVolume'] as int;
    } else {
      weightDistanceVolume = WEIGHT_DISTANCE_VOLUME;
    }


    return Campaign(id, year, active, selected, numberOfRaters, weightHumor, weightOpticOriginality, weightDistanceVolume);
  }

  Map<String, dynamic> toJson() => {
    'year': year,
    'active': active,
    'selected': selected,
    'numberOfRaters': numberOfRaters,
    'weightHumor': weightHumor,
    'weightOpticOriginality' : weightOpticOriginality,
    'weightDistanceVolume': weightDistanceVolume,
  };

  void setID(String id) {
    this.id = id;
  }

  @override
  int compareTo(other) {
    return year.compareTo(other.year);
  }
}