import 'package:kagemuwa_umzug_common/data/model/rating_sync_state.dart';

class Rating implements Comparable<Rating> {
//  static const int RATING_SAVED = 1;
//  static const int RATING_NOT_SAVED = 0;

  int ratingOpticOriginality;
  int ratingHumor;
  int ratingDistanceVolume;
  int paradeNumberNumber;
//  int statusSaved;
  RatingSyncState syncState = RatingSyncState.idle;

//  Rating(this.paradeNumberNumber, this.ratingOpticOriginality, this.ratingHumor, this.ratingDistanceVolume, this.statusSaved);
  Rating(this.paradeNumberNumber, this.ratingOpticOriginality, this.ratingHumor, this.ratingDistanceVolume, this.syncState);

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
      RatingSyncState.synced
      //RATING_SAVED
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

/*  void setRatingUpdateFailed() {
    statusSaved = RATING_NOT_SAVED;
  }*/

  void setRatingUpdatePending() {
    syncState = RatingSyncState.localPending;
  }

  void setRatingUpdateCommitted() {
    syncState = RatingSyncState.synced;
  }

  void setRatingUpdateFailed() {
    syncState = RatingSyncState.failed;
  }
}