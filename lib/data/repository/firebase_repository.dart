import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';
import 'package:kagemuwa_umzug_common/data/model/settings.dart' as kgmw;
import '../model/rater.dart';
import 'repository_interface.dart';

class FirebaseRepository implements RepositoryInterface {
  FirebaseRepository();

  final firestoreInstance = FirebaseFirestore.instance;

  static String CAMPAIGNS = "campaigns";
  static String CAMPAIGN = "campaign_";
  static String SETTINGS = "settings";
  static String PARADE_NUMBER = "_parade_numbers";
  static String RATER = "raters";

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

  @override
  Future<bool> addParadeNumbers(String campaignYear, List<ParadeNumber> paradeNumbers) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    for(ParadeNumber paradeNumber in paradeNumbers) {
      await paradeNumberCollection.add(paradeNumber.toJson()).then((value) => paradeNumber.id = value.id);
    }

    return true;
  }

  @override
  Future<String> addRater(Rater rater) async {
    String newID = "";
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(RATER);

    await raterCollection.add(rater.toJson()).then((value) => rater.id = value.id);

    return newID;
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
  Future<Rater> getRater(String id) async {
    Rater rater;
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(RATER);

    DocumentSnapshot docSnapshot;
    docSnapshot = await raterCollection.doc(id).get();
    if(docSnapshot.data() != null) {
      rater = Rater.fromJson(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>);
    } else {
      rater = Rater("NEW", "", false, "", "", Rater.STATUS_NOT_REGISTERED, 0);
    }

    return rater;
  }

  @override
  Future<kgmw.Settings> getSettings() async {
    CollectionReference settingsCollection;

    settingsCollection = FirebaseFirestore.instance.collection(SETTINGS);

    QuerySnapshot querySnapshot;
    querySnapshot = await settingsCollection.get();
    kgmw.Settings settings = kgmw.Settings.fromJson(querySnapshot.docs.first.id, querySnapshot.docs.first.data() as Map<String, dynamic>);
    return settings;
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
  Future<void> updateRater(Rater rater) async {
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(RATER);

    raterCollection.doc(rater.id).update(rater.toJson());

    return;
  }

  @override
  Future<void> updateSettings(kgmw.Settings settings) async {
    CollectionReference settingsCollection;

    settingsCollection = FirebaseFirestore.instance.collection(SETTINGS);

    settingsCollection.doc(settings.id).update(settings.toJson());
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