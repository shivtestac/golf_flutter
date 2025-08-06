class NotificationModel {
  bool? status;
  List<NotificationData>? data;

  NotificationModel({this.status, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <NotificationData>[];
      json['data'].forEach((v) {
        data!.add(new NotificationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationData {
  String? sId;
  String? recipient;
  Sender? sender;
  String? type;
  bool? read;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationData(
      {this.sId,
        this.recipient,
        this.sender,
        this.type,
        this.read,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    recipient = json['recipient'];
    sender =
    json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    type = json['type'];
    read = json['read'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['recipient'] = recipient;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    data['type'] = type;
    data['read'] = read;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Sender {
  String? sId;
  String? username;
  String? name;
  String? image;

  Sender({this.sId, this.username, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['username'] = username;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
