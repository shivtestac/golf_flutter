class ReportPuttingModel {
  bool? status;
  List<PuttingStats>? puttingStats;
  List<Games>? games;

  ReportPuttingModel({this.status, this.puttingStats, this.games});

  ReportPuttingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['puttingStats'] != null) {
      puttingStats = <PuttingStats>[];
      json['puttingStats'].forEach((v) {
        puttingStats!.add(new PuttingStats.fromJson(v));
      });
    }
    if (json['games'] != null) {
      games = <Games>[];
      json['games'].forEach((v) {
        games!.add(new Games.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.puttingStats != null) {
      data['puttingStats'] = this.puttingStats!.map((v) => v.toJson()).toList();
    }
    if (this.games != null) {
      data['games'] = this.games!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PuttingStats {
  String? range;
  String? successRate;
  String? attempts;
  List<int>? strokesGained;

  PuttingStats(
      {this.range, this.successRate, this.attempts, this.strokesGained});

  PuttingStats.fromJson(Map<String, dynamic> json) {
    range = json['range'];
    successRate = json['successRate'];
    attempts = json['attempts'];
    strokesGained = json['strokesGained'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['range'] = this.range;
    data['successRate'] = this.successRate;
    data['attempts'] = this.attempts;
    data['strokesGained'] = this.strokesGained;
    return data;
  }
}

class Games {
  String? sId;
  String? userId;
  String? courseId;
  String? teeId;
  List<HitLocations>? hitLocations;
  String? timestamp;
  int? iV;

  Games(
      {this.sId,
        this.userId,
        this.courseId,
        this.teeId,
        this.hitLocations,
        this.timestamp,
        this.iV});

  Games.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
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
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['courseId'] = this.courseId;
    data['teeId'] = this.teeId;
    if (this.hitLocations != null) {
      data['hitLocations'] = this.hitLocations!.map((v) => v.toJson()).toList();
    }
    data['timestamp'] = this.timestamp;
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
    distanceYard = "${json['distance_yard'] ?? '0'}";
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
