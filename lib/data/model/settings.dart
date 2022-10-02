class Settings {
  static const int WEIGHT_HUMOR = 2;
  static const int WEIGHT_OPTIC_ORIGINALITY = 2;
  static const int WEIGHT_DISTANCE_VOLUME = 1;

  String id;
  int weightHumor;
  int weightOpticOriginality;
  int weightDistanceVolume;

  Settings(this.id, this.weightHumor, this.weightOpticOriginality, this.weightDistanceVolume);

  factory Settings.fromJson(String id, Map<String, dynamic> jsonMap) {
    int weightHumor;
    int weightOpticOriginality;
    int weightDistanceVolume;

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

    return Settings(id, weightHumor, weightOpticOriginality, weightDistanceVolume);
  }

  Map<String, dynamic> toJson() => {
    'weightHumor': weightHumor,
    'weightOpticOriginality' : weightOpticOriginality,
    'weightDistanceVolume': weightDistanceVolume,
  };
}