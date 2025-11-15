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

  static const int RATING_METHOD_PICKER = 2;
  static const int RATING_METHOD_SLIDER = 1;

  String id;
  String raterNumber;
  String deviceID;
  bool login;
  String name;
  String ratingCampaign;
  String ratingID; // collection ID in firebase for the current campaign for the current rater
  int status;
  int currentParadeNumber;
  int ratingMethod;

  Rater(this.id, this.raterNumber, this.deviceID, this.login, this.name, this.ratingCampaign, this.ratingID, this.status, this.currentParadeNumber, this.ratingMethod);

  factory Rater.fromJson(String id, Map<String, dynamic> jsonMap) {
    final String raterNumber;
    final String deviceID;
    final bool login;
    final String name;
    final String ratingCampaign;
    final String ratingID;
    final int status;
    int currentParadeNumber;
    int ratingMethod;

    if(jsonMap['raterNumber'] != null) {
      raterNumber = jsonMap['raterNumber'] as String;
    } else {
      raterNumber = '';
    }
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
    if(jsonMap['ratingID'] != null) {
      ratingID = jsonMap['ratingID'] as String;
    } else {
      ratingID = '';
    }
    if(jsonMap['status'] != null) {
      status = jsonMap['status'] as int;
    } else {
      status = 0;
    }
    if(jsonMap['currentParadeNumber'] != null) {
      currentParadeNumber = jsonMap['currentParadeNumber'] as int;
    } else {
      currentParadeNumber = 1;
    }
    if(jsonMap['ratingMethod'] != null) {
      ratingMethod = jsonMap['ratingMethod'] as int;
    } else {
      ratingMethod = 1;
    }

    return Rater(
      id,
      raterNumber,
      deviceID,
      login,
      name,
      ratingCampaign,
      ratingID,
      status,
      currentParadeNumber,
      ratingMethod
    );
  }

  Map<String, dynamic> toJson() => {
    'raterNumber': raterNumber,
    'deviceID' : deviceID,
    'login': login,
    'name': name,
    'ratingCampaign': ratingCampaign,
    'ratingID': ratingID,
    'status': status,
    'currentParadeNumber': currentParadeNumber,
    'ratingMethod': ratingMethod,
  };
/*
  void setID(String id) {
    this.id = id;
  }*/
}