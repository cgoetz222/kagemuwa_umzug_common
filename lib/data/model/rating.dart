class Rating implements Comparable<Rating> {
  String id;
  int ratingOpticOriginality;
  int ratingHumor;
  int ratingDistanceVolume;
  int paradeNumberNumber;

  Rating(this.id, this.paradeNumberNumber, this.ratingOpticOriginality, this.ratingHumor, this.ratingDistanceVolume);

  factory Rating.fromJson(String id, Map<String, dynamic> jsonMap) {
    final int ratingOpticOriginality;
    final int ratingHumor;
    final int ratingDistanceVolume;
    final int paradeNumberNumber;

    if(jsonMap['ratingOpticOriginality'] != null) {
      ratingOpticOriginality = jsonMap['ratingOpticOriginality'] as int;
    } else {
      ratingOpticOriginality = 1;
    }
    if(jsonMap['ratingHumor'] != null) {
      ratingHumor = jsonMap['ratingHumor'] as int;
    } else {
      ratingHumor = 1;
    }
    if(jsonMap['ratingDistanceVolume'] != null) {
      ratingDistanceVolume = jsonMap['ratingDistanceVolume'] as int;
    } else {
      ratingDistanceVolume = 1;
    }
    if(jsonMap['paradeNumberNumber'] != null) {
      paradeNumberNumber = jsonMap['paradeNumberNumber'] as int;
    } else {
      paradeNumberNumber = 0;
    }

    return Rating(
      id,
      paradeNumberNumber,
      ratingOpticOriginality,
      ratingHumor,
      ratingDistanceVolume,
    );
  }

  Map<String, dynamic> toJson() => {
    'paradeNumberNumber': paradeNumberNumber,
    'ratingOpticOriginality': ratingOpticOriginality,
    'ratingHumor' : ratingHumor,
    'ratingDistanceVolume': ratingDistanceVolume,
  };

  @override
  int compareTo(Rating other) {
    return paradeNumberNumber.compareTo(other.paradeNumberNumber);
  }
}