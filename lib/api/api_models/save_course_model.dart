class SaveCourseModel {
  bool? status;
  String? message;
  List<SaveCourseData>? data;

  SaveCourseModel({this.status, this.message, this.data});

  SaveCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SaveCourseData>[];
      json['data'].forEach((v) {
        data!.add(new SaveCourseData.fromJson(v));
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

class SaveCourseData {
  String? sId;
  String? user;
  Course? course;
  String? savedAt;
  int? iV;

  SaveCourseData({this.sId, this.user, this.course, this.savedAt, this.iV});

  SaveCourseData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    savedAt = json['savedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.course != null) {
      data['course'] = this.course!.toJson();
    }
    data['savedAt'] = this.savedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Course {
  String? sId;
  String? name;
  String? address;
  String? city;
  String? state;
  double? latitude;
  double? longitude;
  String? image;
  List<String>? gallery;
  String? description;
  int? holesCount;
  List<Null>? teeDetails;
  List<String>? facilities;
  List<Null>? rating;

  Course(
      {this.sId,
        this.name,
        this.address,
        this.city,
        this.state,
        this.latitude,
        this.longitude,
        this.image,
        this.gallery,
        this.description,
        this.holesCount,
        this.teeDetails,
        this.facilities,
        this.rating});

  Course.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    gallery = json['gallery'].cast<String>();
    description = json['description'];
    holesCount = json['holesCount'];
    facilities = json['facilities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image'] = this.image;
    data['gallery'] = this.gallery;
    data['description'] = this.description;
    data['holesCount'] = this.holesCount;
    data['facilities'] = this.facilities;
    return data;
  }
}
