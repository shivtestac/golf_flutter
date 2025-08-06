class ReportApproachModel {
  List<ApproachData>? approachData;
  BiasRL? biasRL;
  BiasLongShort? biasLongShort;
  String? greensInReg;
  AvgMiss? avgMiss;
  StrokesGained? strokesGained;
  YardagePercentages? yardagePercentages;

  ReportApproachModel(
      {this.approachData,
        this.biasRL,
        this.biasLongShort,
        this.greensInReg,
        this.avgMiss,
        this.strokesGained,
        this.yardagePercentages});

  ReportApproachModel.fromJson(Map<String, dynamic> json) {
    if (json['approachData'] != null) {
      approachData = <ApproachData>[];
      json['approachData'].forEach((v) {
        approachData!.add(new ApproachData.fromJson(v));
      });
    }
    biasRL =
    json['biasRL'] != null ? new BiasRL.fromJson(json['biasRL']) : null;
    biasLongShort = json['biasLongShort'] != null
        ? new BiasLongShort.fromJson(json['biasLongShort'])
        : null;
    greensInReg = json['greensInReg'];
    avgMiss != null ? new BiasRL.fromJson(json['avgMiss']) : null;;
    strokesGained != null ? new StrokesGained.fromJson(json['strokesGained']) : null;;
    yardagePercentages = json['yardagePercentages'] != null
        ? new YardagePercentages.fromJson(json['yardagePercentages'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approachData != null) {
      data['approachData'] = this.approachData!.map((v) => v.toJson()).toList();
    }
    if (this.biasRL != null) {
      data['biasRL'] = this.biasRL!.toJson();
    }
    if (this.biasLongShort != null) {
      data['biasLongShort'] = this.biasLongShort!.toJson();
    }
    data['greensInReg'] = this.greensInReg;
    if (this.avgMiss != null) {
      data['avgMiss'] = this.avgMiss!.toJson();
    }
    if (this.strokesGained != null) {
      data['strokesGained'] = this.strokesGained!.toJson();
    }
    if (this.yardagePercentages != null) {
      data['yardagePercentages'] = this.yardagePercentages!.toJson();
    }
    return data;
  }
}

class ApproachData {
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

  ApproachData(
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

  ApproachData.fromJson(Map<String, dynamic> json) {
    clubId = json['club_id'];
    clubName = json['club_name'];
    distanceYard = "${json['distance_yard']??'0'}";
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

class BiasRL {
  int? left;
  int? right;

  BiasRL({this.left, this.right});

  BiasRL.fromJson(Map<String, dynamic> json) {
    left = json['left'];
    right = json['right'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['left'] = this.left;
    data['right'] = this.right;
    return data;
  }
}

class AvgMiss {
  int? total;
  int? average;

  AvgMiss({this.total, this.average});

  AvgMiss.fromJson(Map<String, dynamic> json) {
    total = json['left'];
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['left'] = this.total;
    data['average'] = this.average;
    return data;
  }
}
class StrokesGained {
  int? total;
  int? average;

  StrokesGained({this.total, this.average});

  StrokesGained.fromJson(Map<String, dynamic> json) {
    total = json['left'];
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['left'] = this.total;
    data['average'] = this.average;
    return data;
  }
}

class BiasLongShort {
  int? long;
  int? short;

  BiasLongShort({this.long, this.short});

  BiasLongShort.fromJson(Map<String, dynamic> json) {
    long = json['long'];
    short = json['short'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long'] = this.long;
    data['short'] = this.short;
    return data;
  }
}

class YardagePercentages {
  String? s050;
  String? s5075;
  String? s75100;
  String? s100250;
  String? s250;

  YardagePercentages(
      {this.s050, this.s5075, this.s75100, this.s100250, this.s250});

  YardagePercentages.fromJson(Map<String, dynamic> json) {
    s050 = json['0-50'];
    s5075 = json['50-75'];
    s75100 = json['75-100'];
    s100250 = json['100-250'];
    s250 = json['250+'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0-50'] = this.s050;
    data['50-75'] = this.s5075;
    data['75-100'] = this.s75100;
    data['100-250'] = this.s100250;
    data['250+'] = this.s250;
    return data;
  }
}
