class Rating {
  int ratingOpticOriginality = 1;
  int ratingHumor = 1;
  int ratingDistanceVolume = 1;

  Map<String, dynamic> toJson() => {
    'ratingOpticOriginality': ratingOpticOriginality,
    'ratingHumor' : ratingHumor,
    'ratingDistanceVolume': ratingDistanceVolume,
  };
}