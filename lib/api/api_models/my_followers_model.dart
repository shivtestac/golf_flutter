class MyFollowersModel {
  bool? status;
  String? message;
  List<Followers>? followers;

  MyFollowersModel({this.status, this.message, this.followers});

  MyFollowersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  String? sId;
  String? email;
  String? username;
  String? name;
  String? dob;
  String? gender;
  String? password;
  int? loginStep;
  int? handicap;
  List<String>? savedClubs;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? handPreference;
  String? commonMiss;
  int? drivingDistance;
  String? shotShape;
  String? profilePhoto;

  Followers(
      {this.sId,
        this.email,
        this.username,
        this.name,
        this.dob,
        this.gender,
        this.password,
        this.loginStep,
        this.handicap,
        this.savedClubs,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.handPreference,
        this.commonMiss,
        this.drivingDistance,
        this.shotShape,
        this.profilePhoto});

  Followers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    password = json['password'];
    loginStep = json['loginStep'];
    handicap = json['handicap'];
    savedClubs = json['savedClubs'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    handPreference = json['handPreference'];
    commonMiss = json['commonMiss'];
    drivingDistance = json['drivingDistance'];
    shotShape = json['shotShape'];
    profilePhoto = json['profilePhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['password'] = this.password;
    data['loginStep'] = this.loginStep;
    data['handicap'] = this.handicap;
    data['savedClubs'] = this.savedClubs;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['handPreference'] = this.handPreference;
    data['commonMiss'] = this.commonMiss;
    data['drivingDistance'] = this.drivingDistance;
    data['shotShape'] = this.shotShape;
    data['profilePhoto'] = this.profilePhoto;
    return data;
  }
}
