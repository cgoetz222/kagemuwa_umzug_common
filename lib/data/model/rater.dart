import 'dart:core';

class Rater {
  static const int STATUS_START = 0;
  static const int STATUS_IN_PROGRESS = 1;
  static const int STATUS_END = 2;
  static const int STATUS_FINISHED = 3;
  static const int STATUS_REGISTERED = 11;
  static const int STATUS_NOT_REGISTERED = 12;
  static const int STATUS_ERROR_OTHER_DEVICE_ID = 98;
  static const int STATUS_ERROR = 99;

  String id;
  String deviceID;
  bool login;
  String name;
  String ratingCampaign;
  int status;
  int currentParadeNumber;

  Rater(this.id, this.deviceID, this.login, this.name, this.ratingCampaign, this.status, this.currentParadeNumber);

  factory Rater.fromJson(String id, Map<String, dynamic> jsonMap) {
    final String deviceID;
    final bool login;
    final String name;
    final String ratingCampaign;
    final int status;
    int currentParadeNumber;

    if(jsonMap['deviceID'] != null) {
      deviceID = jsonMap['deviceID'] as String;
    } else {
      deviceID = '';
    }
    if(jsonMap['login'] != null) {
      login = jsonMap['login'] as bool;
    } else {
      login = false;
    }
    if(jsonMap['name'] != null) {
      name = jsonMap['name'] as String;
    } else {
      name = '';
    }
    if(jsonMap['ratingCampaign'] != null) {
      ratingCampaign = jsonMap['ratingCampaign'] as String;
    } else {
      ratingCampaign = '';
    }
    if(jsonMap['status'] != null) {
      status = jsonMap['status'] as int;
    } else {
      status = 0;
    }
    if(jsonMap['currentParadeNumber'] != null) {
      currentParadeNumber = jsonMap['currentParadeNumber'] as int;
    } else {
      currentParadeNumber = 0;
    }

    return Rater(
      id,
      deviceID,
      login,
      name,
      ratingCampaign,
      status,
      currentParadeNumber,
    );
  }

  Map<String, dynamic> toJson() => {
    'deviceID' : deviceID,
    'login': login,
    'name': name,
    'ratingCampaign': ratingCampaign,
    'status': status,
    'currentParadeNumber': currentParadeNumber,
  };

  void setID(String id) {
    this.id = id;
  }
}