import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';

import '../model/rater.dart';
import '../model/rating.dart';

abstract class RepositoryInterface {
  /// ADD
  Future<String> addCampaign(Campaign newCampaign);
  Future<String> addParadeNumber(String campaignYear, ParadeNumber paradeNumber);
  Future<bool> addParadeNumbers(String campaignYear, List<ParadeNumber> paradeNumbers);
  Future<String> addRater(Rater rater);
  Future<String> addRating(Rater rater, Rating rating);

  /// COUNT
  Future<int> getParadeNumbersCount(String campaignYear);

  /// CREATE

  /// DELETE
  Future<void> deleteCampaign(String id);
  Future<void> deleteParadeNumber(String campaignYear, ParadeNumber paradeNumber);
  Future<void> deleteRaters(String campaignYear, List<Rater> raters);
  Future<void> deleteRatersInCampaign(String campaignYear);
  Future<void> deleteRatingsInCampaign(String campaignYear);
  Future<void> deleteParadeNumbersInCampaign(String campaignYear);

  /// EXISTS
//  Future<bool> checkUserExists(String uid);

  /// GET
  Future<List<Campaign>> getCampaigns();
  Future<Rater> getRater(String id, String campaignYear);
  Future<Rater> getRaterByNumber(String number, String campaignYear);
  Future<List<Rater>> getAllRaters(String campaignYear);
  Future<List<Rating>> getRatings(Rater rater);
  Future<List<Rating>> getRatingsForCampaign(String currentCampaign);
  Future<List<ParadeNumber>> getParadeNumbers(String campaignYear);

  /// UPDATE
  Future<void> updateCampaign(Campaign campaign);
  Future<void> updateRater(Rater rater, String campaignYear);
  Future<void> updateRating(Rater rater, Rating rating);
  Future<void> updateParadeNumber(String campaignYear, ParadeNumber paradeNumber);
}