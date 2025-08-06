class GetSystemsModel {
  String? message;
  List<SystemsModel>? systems;

  GetSystemsModel({this.message, this.systems});

  GetSystemsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['systems'] != null) {
      systems = <SystemsModel>[];
      json['systems'].forEach((v) {
        systems!.add(new SystemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.systems != null) {
      data['systems'] = this.systems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemsModel {
  int? id;
  String? name;

  SystemsModel({this.id, this.name});

  SystemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
