class ReportDrivingModel {
  List<DrivingData>? drivingData;
  String? totalDistance;
  String? averageDistance;
  String? fairwayCount;
  String? fairwayPercentage;
  String? stdDeviation;
  String? missBias;
  List<int>? strokesGained;

  ReportDrivingModel(
      {this.drivingData,
      this.totalDistance,
      this.averageDistance,
      this.fairwayCount,
      this.fairwayPercentage,
      this.stdDeviation,
      this.missBias,
      this.strokesGained});

  ReportDrivingModel.fromJson(Map<String, dynamic> json) {
    if (json['drivingData'] != null) {
      drivingData = <DrivingData>[];
      json['drivingData'].forEach((v) {
        drivingData!.add(new DrivingData.fromJson(v));
      });
    }
    totalDistance = "${json['totalDistance'] ?? '0'}";
    averageDistance = "${json['averageDistance'] ?? '0'}";
    fairwayCount = "${json['fairwayCount'] ?? '0'}";
    fairwayPercentage = "${json['fairwayPercentage'] ?? '0'}";
    stdDeviation = "${json['stdDeviation'] ?? '0'}";
    missBias = "${json['missBias'] ?? '0'}";
    strokesGained = json['strokesGained'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.drivingData != null) {
      data['drivingData'] = this.drivingData!.map((v) => v.toJson()).toList();
    }
    data['totalDistance'] = this.totalDistance;
    data['averageDistance'] = this.averageDistance;
    data['fairwayCount'] = this.fairwayCount;
    data['fairwayPercentage'] = this.fairwayPercentage;
    data['stdDeviation'] = this.stdDeviation;
    data['missBias'] = this.missBias;
    data['strokesGained'] = this.strokesGained;
    return data;
  }
}

class DrivingData {
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

  DrivingData(
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

  DrivingData.fromJson(Map<String, dynamic> json) {
    clubId = json['club_id'];
    clubName = json['club_name'];
    distanceYard = "${json['distance_yard'] ?? ''}";
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
