import 'package:flutter/material.dart';
import 'package:kagemuwa_umzug_common/data/model/campaign.dart';
import 'package:kagemuwa_umzug_common/data/model/parade_number.dart';

import '../repository/firebase_repository.dart';

class ParadeProvider with ChangeNotifier {
  List<Campaign>? campaigns;
  List<ParadeNumber>? paradeNumbers;
  List<String> campaignYears = [];
  Campaign selectedCampaign = Campaign('', '', false, false);
  bool paradeNumbersSavedToDB = false;

  ParadeProvider() {
    campaigns = [];
    paradeNumbers = [];

    _loadCampaigns().then((value) => _loadParadeNumbers());
  }

  void addCampaign(String newCampaignYear) {
    Campaign newCampaign = Campaign('', newCampaignYear, true, true);

    FirebaseRepository().addCampaign(newCampaign).then((value) => () {
      newCampaign.setID(value);
      campaigns?.add(newCampaign);
      campaignYears.add(newCampaign.year);
      selectedCampaign = newCampaign;
    });

    _loadCampaigns();
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
    await FirebaseRepository().deleteCampaign(selectedCampaign.id);

    _loadCampaigns();
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
    selectedCampaign = Campaign('', '', false, false);

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
    notifyListeners();
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

    notifyListeners();
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
}