import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';
import '../model/rater.dart';
import '../model/rating.dart';
import 'repository_interface.dart';

class FirebaseRepository implements RepositoryInterface {
  FirebaseRepository();

  final firestoreInstance = FirebaseFirestore.instance;

  static String CAMPAIGNS = "campaigns";
  static String CAMPAIGN = "campaign_";
  static String SETTINGS = "settings";
  static String PARADE_NUMBER = "_parade_numbers";
  static String RATER = "_raters";
  static String RATINGS = "_ratings";
  static String RATER_RATINGS = "ratings";

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

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + rater.ratingCampaign + RATER);

    //await raterCollection.add(rater.toJson()).then((value) => rater.id = value.id);
    await raterCollection.doc(rater.id).set(rater.toJson());

    return newID;
  }

  @override
  Future<String> addRating(Rater rater, Rating rating) async {
    String newID = "";
    CollectionReference ratingCollection;

    ratingCollection = FirebaseFirestore.instance.collection(CAMPAIGN + rater.ratingCampaign + RATINGS);

    // add the rating to the subcollection of the rater to the current campaign
    await ratingCollection.doc(rater.ratingID).collection(RATER_RATINGS).doc(rating.paradeNumberNumber.toString()).set(rating.toJson());

    return newID;
  }

  /// COUNT
  @override
  Future<int> getParadeNumbersCount(String campaignYear) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + PARADE_NUMBER);

    AggregateQuerySnapshot query = await paradeNumberCollection.count().get();

    return query.count;
  }

  /// CREATE

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

  @override
  Future<void> deleteRaters(String campaignYear, List<Rater> raters) async {
    CollectionReference raterCollection;
    CollectionReference ratingCollection;
    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATER);
    ratingCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATINGS);

    for(Rater rater in raters) {
      await ratingCollection.doc(rater.ratingID).delete();
      await raterCollection.doc(rater.id).delete();
    }
  }

  @override
  Future<void> deleteRatersInCampaign(String campaignYear) async {
    final collection = await FirebaseFirestore.instance
        .collection(CAMPAIGN + campaignYear + RATER)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    return;
  }

  @override
  Future<void> deleteRatingsInCampaign(String campaignYear) async {
    final collection = await FirebaseFirestore.instance
        .collection(CAMPAIGN + campaignYear + RATINGS)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    return;
  }

  @override
  Future<void> deleteParadeNumbersInCampaign(String campaignYear) async {
    final collection = await FirebaseFirestore.instance
        .collection(CAMPAIGN + campaignYear + PARADE_NUMBER)
        .get();

    final batch = FirebaseFirestore.instance.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    return;
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
  Future<Rater> getRater(String id, String campaignYear) async {
    Rater rater;
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATER);

    DocumentSnapshot docSnapshot;
    docSnapshot = await raterCollection.doc(id).get();
    if(docSnapshot.data() != null) {
      rater = Rater.fromJson(docSnapshot.id, docSnapshot.data() as Map<String, dynamic>);
    } else {
      rater = Rater("NEW", "NEW", "", false, "", "", "", Rater.STATUS_NOT_REGISTERED, 0, Rater.RATING_METHOD_PICKER);
    }

    return rater;
  }

  @override
  Future<Rater> getRaterByNumber(String number, String campaignYear) async {
    Rater rater;
    rater = Rater("NEW", "NEW", "", false, "", "", "", Rater.STATUS_NOT_REGISTERED, 0, Rater.RATING_METHOD_PICKER);
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATER);

    QuerySnapshot querySnapshot;
    querySnapshot = await raterCollection.where("raterNumber", isEqualTo: number).get();
    print(querySnapshot.toString());
    if(querySnapshot.size > 0) {
      for(var doc in querySnapshot.docs) {
        rater = Rater.fromJson(doc.id, doc.data() as Map<String, dynamic>);
      }
    } else {
      rater = Rater("NEW", "NEW", "", false, "", "", "", Rater.STATUS_NOT_REGISTERED, 0, Rater.RATING_METHOD_PICKER);
    }

    return rater;
  }

  @override
  Future<List<Rater>> getAllRaters(String campaignYear) async {
    CollectionReference raterCollection;
    List<Rater> raters = [];

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATER);

    QuerySnapshot querySnapshotRater;
    querySnapshotRater = await raterCollection.get();
    for (var result in querySnapshotRater.docs) {
      Map<String, dynamic> resRater = result.data() as Map<String, dynamic>;
      Rater rater = Rater.fromJson(result.id, resRater);

      raters.add(rater);
    }

    return raters;
  }

  @override
  Future<List<Rating>> getRatings(Rater rater) async {
    List<Rating> ratings = [];
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + rater.ratingCampaign + RATINGS);

    // get the rating to the subcollection of the rater to the current campaign
    QuerySnapshot querySnapshot;
    querySnapshot = await raterCollection.doc(rater.ratingID).collection(RATER_RATINGS).get();
    for (var result in querySnapshot.docs) {
      Rating rating = Rating.fromJson(int.parse(result.id), result.data() as Map<String, dynamic>);
      ratings.add(rating);
    }

    return ratings;
  }

  @override
  Future<List<Rating>> getRatingsForCampaign(String currentCampaign) async {
    List<Rating> ratings = [];
    CollectionReference ratingsCollection;

    ratingsCollection = FirebaseFirestore.instance.collection(CAMPAIGN + currentCampaign + RATINGS);
    // get all ratings for the current campaign

    // 1) get the raters
    QuerySnapshot querySnapshotRater;
    querySnapshotRater = await ratingsCollection.get();
    for (var result in querySnapshotRater.docs) {
      // 2) get the ratings for the rater
      QuerySnapshot querySnapshot;
      querySnapshot = await ratingsCollection.doc(result.id).collection(RATER_RATINGS).get();
      for (var result1 in querySnapshot.docs) {
        Rating rating = Rating.fromJson(int.parse(result1.id), result1.data() as Map<String, dynamic>);
        ratings.add(rating);
      }
    }

    return ratings;
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
  Future<void> updateRater(Rater rater, String campaignYear) async {
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + campaignYear + RATER);

    raterCollection.doc(rater.id).update(rater.toJson());

    return;
  }

  @override
  Future<void> updateRating(Rater rater, Rating rating) async {
    CollectionReference raterCollection;

    raterCollection = FirebaseFirestore.instance.collection(CAMPAIGN + rater.ratingCampaign + RATINGS);
    raterCollection.doc(rater.ratingID).collection(RATER_RATINGS).doc(rating.paradeNumberNumber.toString()).update(rating.toJson());

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

  /// listeners for realtime changes

  /// tests
  Future<void> test() async {
    await FirebaseFirestore.instance
        .collection(RATER)
        .get()
        .then((QuerySnapshot snapShot) async {
      for (var element in snapShot.docs) {
        await FirebaseFirestore.instance
            .collection(CAMPAIGN + "2020_21_" + RATER)
            .doc(element.id)
            .set(element.data()as Map<String, dynamic>);
      }
    });
  }
/*  Future<void> test(List<ParadeNumber> paradeNumbers) async {
    CollectionReference paradeNumberCollection;

    paradeNumberCollection = FirebaseFirestore.instance.collection("TEST");
    await paradeNumberCollection.add(paradeNumbers.asMap());//(jsonEncode(paradeNumbers));
  }*/
}