class GetLessonsModel {
  bool? status;
  String? message;
  List<GetLessonsData>? data;

  GetLessonsModel({this.status, this.message, this.data});

  GetLessonsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <GetLessonsData>[];
      json['data'].forEach((v) {
        data!.add(new GetLessonsData.fromJson(v));
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

class GetLessonsData {
  String? sId;
  String? title;
  String? thumbnail;
  String? video;
  String? description;
  int? iV;

  GetLessonsData(
      {this.sId,
        this.title,
        this.thumbnail,
        this.video,
        this.description,
        this.iV});

  GetLessonsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    video = json['video'];
    description = json['description'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['video'] = this.video;
    data['description'] = this.description;
    data['__v'] = this.iV;
    return data;
  }
}
