import '../../common/app_singleton.dart';

class UserModel {
  bool? status;
  String? message;
  UserData? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? sId;
  String? token;
  String? email;
  String? username;
  String? name;
  String? dob;
  String? gender;
  String? createdAt;
  String? updatedAt;
  int? iV;
  int? handicap;
  int? loginStep;
  String? handPreference;
  String? commonMiss;
  int? drivingDistance;
  String? shotShape;
  int? fairwayPercentage;
  List<String>? savedClubs;
  String? profilePhoto;

  UserData(
      {this.sId,
        this.token,
        this.email,
        this.username,
        this.name,
        this.dob,
        this.gender,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.handicap,
        this.loginStep,
        this.handPreference,
        this.commonMiss,
        this.drivingDistance,
        this.shotShape,
        this.fairwayPercentage,
        this.savedClubs,
        this.profilePhoto});

  UserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    token = json['token'];
    username = json['username'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    handicap = json['handicap'];
    loginStep = json['loginStep'];
    handPreference = json['handPreference'];
    commonMiss = json['commonMiss'];
    drivingDistance = json['drivingDistance'];
    shotShape = json['shotShape'];
    fairwayPercentage = json['fairwayPercentage'];
   // savedClubs = json['savedClubs'].cast<String>();
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['token'] = this.token;
    data['username'] = this.username;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['handicap'] = this.handicap;
    data['loginStep'] = this.loginStep;
    data['handPreference'] = this.handPreference;
    data['commonMiss'] = this.commonMiss;
    data['drivingDistance'] = this.drivingDistance;
    data['shotShape'] = this.shotShape;
    data['fairwayPercentage'] = this.fairwayPercentage;
    data['savedClubs'] = this.savedClubs;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}
