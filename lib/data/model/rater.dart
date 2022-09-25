import 'dart:core';

class Rater {
  static const int STATUS_START = 0;
  static const int STATUS_IN_PROGRESS = 1;
  static const int STATUS_END = 2;
  static const int STATUS_FINISHED = 3;
  static const int STATUS_ERROR_OTHER_DEVICE_ID = 98;
  static const int STATUS_ERROR = 99;

  String id;
  int userId;
  String deviceID;
  bool login;
  String name;
  int status;
  int currentParadeNumber;

  Rater(this.id, this.userId, this.deviceID, this.login, this.name, this.status, this.currentParadeNumber);

  factory Rater.fromJson(String id, Map<String, dynamic> jsonMap) {
    final int userId;
    final String deviceID;
    final bool login;
    final String name;
    final int status;
    int currentParadeNumber;

    if(jsonMap['userId'] != null) {
      userId = jsonMap['userId'] as int;
    } else {
      userId = 0;
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
      userId,
      deviceID,
      login,
      name,
      status,
      currentParadeNumber,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'deviceID' : deviceID,
    'login': login,
    'name': name,
    'status': status,
    'currentParadeNumber': currentParadeNumber,
  };

  void setID(String id) {
    this.id = id;
  }
}