import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';
import 'repository_interface.dart';

class FirebaseRepository implements RepositoryInterface {
  FirebaseRepository();

  final firestoreInstance = FirebaseFirestore.instance;

  static String CAMPAIGNS = "campaigns";
  static String CAMPAIGN = "campaign_";
  static String PARADE_NUMBER = "_parade_numbers";
  static String RATER = "_raters";

  /// ADD
  @override
  Future<String> addCampaign(Campaign newCampaign) async {
    String newID = '';
    CollectionReference campaignCollection;

    campaignCollection = FirebaseFirestore.instance.collection(CAMPAIGNS);

    campaignCollection.add(newCampaign.toJson()).then((value) => newID = value.id);

    return newID;
  }

  @override
  Future<String> addParadeNumber(String campaignYear, ParadeNumber paradeNumber) async {
    String newID = '';
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    await paradeNumberCollection.add(paradeNumber.toJson()).then((value) => paradeNumber.id = value.id);

    return newID;
  }

  Future<bool> addParadeNumbers(String campaignYear, List<ParadeNumber> paradeNumbers) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    for(ParadeNumber paradeNumber in paradeNumbers) {
      await paradeNumberCollection.add(paradeNumber.toJson()).then((value) => paradeNumber.id = value.id);
    }

//    await paradeNumberCollection.add(paradeNumbers.map((e) => e.toJson())).then((value) => () {return true;}).catchError(() {return false;});// .toJson()).then((value) => newID = value.id);

    return true;
  }

  /// DELETE
  @override
  Future<void> deleteCampaign(String id) async {
    CollectionReference campaignsCollection;

    campaignsCollection = FirebaseFirestore.instance.collection(CAMPAIGNS);

    await campaignsCollection.doc(id).delete();
  }

  @override
  Future<void> deleteParadeNumber(String campaignYear, ParadeNumber paradeNumber) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    await paradeNumberCollection.doc(paradeNumber.id).delete();//.then((value) => print("Deleted"));
  }

  /// GET
  @override
  Future<List<Campaign>> getCampaigns() async {
    List<Campaign> campaigns = [];

    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGNS);

    QuerySnapshot querySnapshot;
    querySnapshot = await paradeNumberCollection.get();
    for (var result in querySnapshot.docs) {
      Campaign campaign = Campaign.fromJson(result.id, result.data() as Map<String, dynamic>);
      campaigns.add(campaign);
    }

    return campaigns;
  }

  @override
  Future<List<ParadeNumber>> getParadeNumbers(String campaignYear) async {
    List<ParadeNumber> paradeNumbers = [];

    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    QuerySnapshot querySnapshot;
    querySnapshot = await paradeNumberCollection.get();
    for (var result in querySnapshot.docs) {
      ParadeNumber paradeNumber = ParadeNumber.fromJson(result.id, result.data() as Map<String, dynamic>);
      paradeNumbers.add(paradeNumber);
    }

    return paradeNumbers;
  }

  /// UPDATE
  @override
  Future<void> updateCampaign(Campaign campaign) async {
    CollectionReference campaignCollection;

    campaignCollection = FirebaseFirestore.instance.collection(CAMPAIGNS);

    campaignCollection.doc(campaign.id).update(campaign.toJson());

    return;
  }

  @override
  Future<void> updateParadeNumber(String campaignYear, ParadeNumber paradeNumber) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    paradeNumberCollection
        .doc(paradeNumber.id) // <-- Doc ID where data should be updated.
        .update(paradeNumber.toJson()); // <-- Updated data
        //.then((_) => print('Updated'))
        //.catchError((error) => print('Update failed: $error'));
  }
}