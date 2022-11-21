class Rating implements Comparable<Rating> {
  int ratingOpticOriginality;
  int ratingHumor;
  int ratingDistanceVolume;
  int paradeNumberNumber;

  Rating(this.paradeNumberNumber, this.ratingOpticOriginality, this.ratingHumor, this.ratingDistanceVolume);

  factory Rating.fromJson(int id, Map<String, dynamic> jsonMap) {
    final int ratingOpticOriginality;
    final int ratingHumor;
    final int ratingDistanceVolume;

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

    return Rating(
      id,
      ratingOpticOriginality,
      ratingHumor,
      ratingDistanceVolume,
    );
  }

  Map<String, dynamic> toJson() => {
    'ratingOpticOriginality': ratingOpticOriginality,
    'ratingHumor' : ratingHumor,
    'ratingDistanceVolume': ratingDistanceVolume,
  };

  @override
  int compareTo(Rating other) {
    return paradeNumberNumber.compareTo(other.paradeNumberNumber);
  }
}