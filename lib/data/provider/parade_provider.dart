import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';
import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';

import '../repository/firebase_repository.dart';

class ParadeProvider extends ChangeNotifier {
  bool initialized = false;
  List<Campaign>? campaigns;
  List<ParadeNumber>? paradeNumbers;
  List<String> campaignYears = [];
  Campaign selectedCampaign = Campaign('', '', false, false, Campaign.NUMBER_OF_RATERS, Campaign.WEIGHT_HUMOR, Campaign.WEIGHT_OPTIC_ORIGINALITY, Campaign.WEIGHT_DISTANCE_VOLUME);
  bool paradeNumbersSavedToDB = false;

  ParadeProvider() {
    campaigns = [];
    paradeNumbers = [];
  }

  Future<bool> load() async {
    if(initialized) return true;

    campaigns = [];
    paradeNumbers = [];

    await _loadCampaigns();
    await _loadParadeNumbers();

    listenForParadeNumberChanges();

    initialized = true;

    return true;
  }

  Future<void> listenForParadeNumberChanges() async {
    CollectionReference reference = FirebaseFirestore.instance.collection(FirebaseRepository.CAMPAIGN + selectedCampaign.year + FirebaseRepository.PARADE_NUMBER);
    reference.snapshots().listen((querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        ParadeNumber paradeNumber = ParadeNumber.fromJson(change.doc.id, change.doc.data() as Map<String, dynamic>);
        paradeNumbers!.elementAt(paradeNumber.number - 1).name = paradeNumber.name;
        paradeNumbers!.elementAt(paradeNumber.number - 1).club = paradeNumber.club;
        paradeNumbers!.elementAt(paradeNumber.number - 1).type = paradeNumber.type;
        paradeNumbers!.elementAt(paradeNumber.number - 1).evaluate = paradeNumber.evaluate;

        notifyListeners();
      }
    });
  }

  void addCampaign(String newCampaignYear) {
    Campaign newCampaign = Campaign('', newCampaignYear, false, false, Campaign.NUMBER_OF_RATERS, Campaign.WEIGHT_HUMOR, Campaign.WEIGHT_OPTIC_ORIGINALITY, Campaign.WEIGHT_DISTANCE_VOLUME);

    FirebaseRepository().addCampaign(newCampaign).then((value) => () {
      newCampaign.setID(value);
      campaigns?.add(newCampaign);
      campaignYears.add(newCampaign.year);
      //selectedCampaign = newCampaign;
    });

    _loadCampaigns();

    notifyListeners();
  }

  void saveParadeNumbersToDB() async {
    paradeNumbersSavedToDB = await FirebaseRepository().addParadeNumbers(selectedCampaign.year, paradeNumbers!);

    notifyListeners();
  }

  void addNewParadeNumber(int newParadeNumber) async {
    ParadeNumber paradeNumber = ParadeNumber("", newParadeNumber, "NEW", "NEW", "R", false);
    await FirebaseRepository().addParadeNumber(selectedCampaign.year, paradeNumber);

    for(int index = paradeNumbers!.length - 1; index >= newParadeNumber; index--) {
      paradeNumbers!.elementAt(index - 1).number += 1;

      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(index - 1));
    }

    paradeNumbers!.add(paradeNumber);

    paradeNumbers!.sort();

    notifyListeners();
  }

  void addParadeNumber(ParadeNumber paradeNumber) {
    paradeNumbers!.add(paradeNumber);

    notifyListeners();
  }

  void deleteCurrentCampaign() async {
    await FirebaseRepository().deleteRatersInCampaign(selectedCampaign.year);
    await FirebaseRepository().deleteRatingsInCampaign(selectedCampaign.year);
    await FirebaseRepository().deleteParadeNumbersInCampaign(selectedCampaign.year);
    await FirebaseRepository().deleteCampaign(selectedCampaign.id);

    paradeNumbers = [];
    _loadCampaigns();

    notifyListeners();
  }

  void deleteParadeNumber(int number) async {
    await FirebaseRepository().deleteParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(number - 1));
    paradeNumbers!.removeAt(number - 1);

    for(int i = number; i <= paradeNumbers!.length; i++) {
      paradeNumbers!.elementAt(i - 1).number -= 1;

      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(i - 1));
    }

    if(paradeNumbers!.isEmpty) paradeNumbersSavedToDB = false;

    notifyListeners();
  }

  /// returns a list with the strings describing the campaign years
  List<String> getCampaignYears() {
    return campaignYears;
  }

  ParadeNumber getParadeNumber(int index) {
    return paradeNumbers!.elementAt(index);
  }

  /// loads the campaigns from the firebase database
  Future<void> _loadCampaigns() async {
    // reset the data
    campaigns = [];
    campaignYears = [];
    selectedCampaign = Campaign('', '', false, false, Campaign.NUMBER_OF_RATERS, Campaign.WEIGHT_HUMOR, Campaign.WEIGHT_OPTIC_ORIGINALITY, Campaign.WEIGHT_DISTANCE_VOLUME);

    campaigns = await FirebaseRepository().getCampaigns();
    if(campaigns!.isNotEmpty) {
      campaigns!.sort();

      selectedCampaign = campaigns!.last;

      // fill the list of campaign year for display purposes
      for(Campaign campaign in campaigns!) {
        campaignYears.add(campaign.year);

        if(campaign.selected) selectedCampaign = campaign;
      }
    }

    if(initialized) notifyListeners();
  }

  /// loads the parade numbers for the current campaign from the firebase database
  Future<void> _loadParadeNumbers() async {
    // reset the data
    paradeNumbers = [];

    if(selectedCampaign.year != '') {
      paradeNumbers = await FirebaseRepository().getParadeNumbers(selectedCampaign.year);
      if(paradeNumbers != null && paradeNumbers!.isNotEmpty) {
        paradeNumbers!.sort();
        paradeNumbersSavedToDB = true;
      }
    }
    if(initialized) notifyListeners();
  }

  void paradeMoveUp(int paradeNumber) async {
    if(paradeNumber > 1) {
      paradeNumbers!.elementAt(paradeNumber - 2).number += 1;
      paradeNumbers!.elementAt(paradeNumber - 1).number -= 1;

      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(paradeNumber - 2));
      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(paradeNumber - 1));

      paradeNumbers!.sort();

      notifyListeners();
    }
  }

  void paradeMoveDown(int paradeNumber) async {
    if(paradeNumber < paradeNumbers!.length) {
      paradeNumbers!.elementAt(paradeNumber).number -= 1;
      paradeNumbers!.elementAt(paradeNumber - 1).number += 1;

      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(paradeNumber));
      await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumbers!.elementAt(paradeNumber - 1));

      paradeNumbers!.sort();

      notifyListeners();
    }
  }

  void setSelectedCampaign(String year) {
    if(campaigns!.isEmpty) return;

    paradeNumbersSavedToDB = false;

    selectedCampaign.selected = false;
    FirebaseRepository().updateCampaign(selectedCampaign);

    for(Campaign campaign in campaigns!) {
      if(campaign.year == year) {
        selectedCampaign = campaign;
        selectedCampaign.selected = true;
        FirebaseRepository().updateCampaign(selectedCampaign);

        _loadParadeNumbers();
      }
    }
  }

  void setSelectedCampaignAsActiveCampaign() async {
    if(campaigns!.isEmpty) return;

    for(Campaign campaign in campaigns!) {
      if(campaign.year != selectedCampaign.year) {
        if(campaign.active) {
          campaign.active = false;
          await FirebaseRepository().updateCampaign(campaign);
        }
      }
    }

    selectedCampaign.active = true;
    await FirebaseRepository().updateCampaign(selectedCampaign);

    notifyListeners();
  }

  void updateParadeNumber(ParadeNumber paradeNumber) async {
    await FirebaseRepository().updateParadeNumber(selectedCampaign.year, paradeNumber);

    notifyListeners();
  }

  void updateCurrentCampaign() async {
    await FirebaseRepository().updateCampaign(selectedCampaign);

    notifyListeners();
  }
}