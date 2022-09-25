import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';

abstract class RepositoryInterface {
  /// ADD
  Future<String> addCampaign(Campaign newCampaign);
  Future<String> addParadeNumber(String campaignYear, ParadeNumber paradeNumber);
  Future<bool> addParadeNumbers(String campaignYear, List<ParadeNumber> paradeNumbers);
//  Future<String> addUser(User user);

  /// COUNT
//  Future<List<int>> getExerciseCounts();

  /// CREATE
//  Future<void> createUser();

  /// DELETE
  Future<void> deleteCampaign(String id);
  Future<void> deleteParadeNumber(String campaignYear, ParadeNumber paradeNumber);

  /// EXISTS
//  Future<bool> checkUserExists(String uid);

  /// GET
  Future<List<Campaign>> getCampaigns();
  Future<List<ParadeNumber>> getParadeNumbers(String campaignYear);

  /// UPDATE
  Future<void> updateCampaign(Campaign campaign);
  Future<void> updateParadeNumber(String campaignYear, ParadeNumber paradeNumber);
}