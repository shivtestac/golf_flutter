class GetClubsModel {
  bool? status;
  String? message;
  List<GetClubsData>? data;

  GetClubsModel({this.status, this.message, this.data});

  GetClubsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetClubsData>[];
      json['data'].forEach((v) {
        data!.add(new GetClubsData.fromJson(v));
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

class GetClubsData {
  String? sId;
  String? code;
  String? name;
  String? type;
  String? brand;
  String? loft;
  String? description;
  String? createdAt;
  int? iV;

  GetClubsData(
      {this.sId,
        this.code,
        this.name,
        this.type,
        this.brand,
        this.loft,
        this.description,
        this.createdAt,
        this.iV});

  GetClubsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    code = json['code'];
    name = json['name'];
    type = json['type'];
    brand = json['brand'];
    loft = json['loft'].toString();
    description = json['description'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['code'] = this.code;
    data['name'] = this.name;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['loft'] = this.loft;
    data['description'] = this.description;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
