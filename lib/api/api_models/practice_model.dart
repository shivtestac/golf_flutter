class PracticeModel {
  bool? status;
  PracticeStats? stats;
  PracticeData? data;

  PracticeModel({this.status, this.stats, this.data});

  PracticeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    stats = json['stats'] != null ? new PracticeStats.fromJson(json['stats']) : null;
    data = json['data'] != null ? new PracticeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class PracticeStats {
  int? holeIt;
  int? within10Percent;
  int? beyond10Percent;

  PracticeStats({this.holeIt, this.within10Percent, this.beyond10Percent});

  PracticeStats.fromJson(Map<String, dynamic> json) {
    holeIt = json['holeIt'];
    within10Percent = json['within10Percent'];
    beyond10Percent = json['beyond10Percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holeIt'] = this.holeIt;
    data['within10Percent'] = this.within10Percent;
    data['beyond10Percent'] = this.beyond10Percent;
    return data;
  }
}

class PracticeData {
  String? sId;
  String? title;
  String? description;
  String? video;
  String? scoring;
  String? howToDoIt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PracticeData(
      {this.sId,
        this.title,
        this.description,
        this.video,
        this.scoring,
        this.howToDoIt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  PracticeData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    video = json['video'];
    scoring = json['scoring'];
    howToDoIt = json['howToDoIt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['video'] = this.video;
    data['scoring'] = this.scoring;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
