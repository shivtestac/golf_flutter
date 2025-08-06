class AddGameScoreModel {
  bool? success;
  String? message;
  NewRecord? newRecord;

  AddGameScoreModel({this.success, this.message, this.newRecord});

  AddGameScoreModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    newRecord = json['newRecord'] != null
        ? new NewRecord.fromJson(json['newRecord'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.newRecord != null) {
      data['newRecord'] = this.newRecord!.toJson();
    }
    return data;
  }
}

class NewRecord {
  String? player;
  int? totalCoins;
  InningCoins? inningCoins;
  InningCoins? outcomeCoins;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NewRecord(
      {this.player,
        this.totalCoins,
        this.inningCoins,
        this.outcomeCoins,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NewRecord.fromJson(Map<String, dynamic> json) {
    player = json['player'];
    totalCoins = json['totalCoins'];
    inningCoins = json['inningCoins'] != null
        ? new InningCoins.fromJson(json['inningCoins'])
        : null;
    outcomeCoins = json['outcomeCoins'] != null
        ? new InningCoins.fromJson(json['outcomeCoins'])
        : null;
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['player'] = this.player;
    data['totalCoins'] = this.totalCoins;
    if (this.inningCoins != null) {
      data['inningCoins'] = this.inningCoins!.toJson();
    }
    if (this.outcomeCoins != null) {
      data['outcomeCoins'] = this.outcomeCoins!.toJson();
    }
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class InningCoins {
  int? matchBonus;
  int? mainBet;
  int? pockerBonus;

  InningCoins({this.matchBonus, this.mainBet, this.pockerBonus});

  InningCoins.fromJson(Map<String, dynamic> json) {
    matchBonus = json['matchBonus'];
    mainBet = json['mainBet'];
    pockerBonus = json['pockerBonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matchBonus'] = this.matchBonus;
    data['mainBet'] = this.mainBet;
    data['pockerBonus'] = this.pockerBonus;
    return data;
  }
}
