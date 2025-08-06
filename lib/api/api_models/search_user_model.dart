class SearchUserModel {
  bool? status;
  String? message;
  List<SearchUserData>? data;

  SearchUserModel({this.status, this.message, this.data});

  SearchUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SearchUserData>[];
      json['data'].forEach((v) {
        data!.add(new SearchUserData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchUserData {
  String? sId;
  String? email;
  String? username;
  String? name;
  String? dob;
  String? gender;
  int? loginStep;
  var handicap;
  List<String>? savedClubs;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? handPreference;
  String? commonMiss;
  int? drivingDistance;
  String? shotShape;
  String? profilePhoto;
  int? fairwayPercentage;
  bool? isFollowing;

  SearchUserData(
      {this.sId,
        this.email,
        this.username,
        this.name,
        this.dob,
        this.gender,
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
        this.profilePhoto,
        this.fairwayPercentage,
        this.isFollowing,
      });

  SearchUserData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
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
    fairwayPercentage = json['fairwayPercentage'];
    isFollowing = json['isFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
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
    data['fairwayPercentage'] = this.fairwayPercentage;
    data['isFollowing'] = this.isFollowing;
    return data;
  }
}
