class StepModel {
  String? message;
  User? user;

  StepModel({this.message, this.user});

  StepModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  List<Null>? savedClubs;
  String? sId;
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

  User(
      {this.savedClubs,
        this.sId,
        this.email,
        this.username,
        this.name,
        this.dob,
        this.gender,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.handicap,
        this.loginStep});

  User.fromJson(Map<String, dynamic> json) {
    if (json['savedClubs'] != null) {
      savedClubs = <Null>[];

    }
    sId = json['_id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    dob = json['dob'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    handicap = json['handicap'];
    loginStep = json['loginStep'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['handicap'] = this.handicap;
    data['loginStep'] = this.loginStep;
    return data;
  }
}
