class SaveGameModel {
  String? message;
  GameData? gameData;

  SaveGameModel({this.message, this.gameData});

  SaveGameModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    gameData = json['gameData'] != null
        ? new GameData.fromJson(json['gameData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.gameData != null) {
      data['gameData'] = this.gameData!.toJson();
    }
    return data;
  }
}

class GameData {
  String? userId;
  String? courseId;
  String? teeId;
  List<HitLocations>? hitLocations;
  String? timestamp;
  String? sId;
  int? iV;

  GameData(
      {this.userId,
        this.courseId,
        this.teeId,
        this.hitLocations,
        this.timestamp,
        this.sId,
        this.iV});

  GameData.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    courseId = json['courseId'];
    teeId = json['teeId'];
    if (json['hitLocations'] != null) {
      hitLocations = <HitLocations>[];
      json['hitLocations'].forEach((v) {
        hitLocations!.add(new HitLocations.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['courseId'] = this.courseId;
    data['teeId'] = this.teeId;
    if (this.hitLocations != null) {
      data['hitLocations'] = this.hitLocations!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}

class HitLocations {
  String? clubId;
  String? clubName;
  String? distanceYard;
  String? endingLie;
  String? dispersion;
  String? lie;
  int? windSpeed;
  String? windDirection;
  String? inBetween;
  int? par;
  String? sId;

  HitLocations(
      {this.clubId,
        this.clubName,
        this.distanceYard,
        this.endingLie,
        this.dispersion,
        this.lie,
        this.windSpeed,
        this.windDirection,
        this.inBetween,
        this.par,
        this.sId});

  HitLocations.fromJson(Map<String, dynamic> json) {
    clubId = json['club_id'];
    clubName = json['club_name'];
    distanceYard = '${json['distance_yard']}';
    endingLie = json['ending_lie'];
    dispersion = json['dispersion'];
    lie = json['lie'];
    windSpeed = json['wind_speed'];
    windDirection = json['wind_direction'];
    inBetween = json['in_between'];
    par = json['par'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['club_id'] = this.clubId;
    data['club_name'] = this.clubName;
    data['distance_yard'] = this.distanceYard;
    data['ending_lie'] = this.endingLie;
    data['dispersion'] = this.dispersion;
    data['lie'] = this.lie;
    data['wind_speed'] = this.windSpeed;
    data['wind_direction'] = this.windDirection;
    data['in_between'] = this.inBetween;
    data['par'] = this.par;
    data['_id'] = this.sId;
    return data;
  }
}
