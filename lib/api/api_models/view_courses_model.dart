class ViewCoursesModel {
  List<Courses>? courses;

  ViewCoursesModel({this.courses});

  ViewCoursesModel.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? sId;
  String? name;
  String? address;
  int? followersCount;
  String? distance;
  int? avgRating;
  String? city;
  String? state;
  double? latitude;
  double? longitude;
  String? image;
  List<String>? gallery;
  String? description;
  int? holesCount;
  List<TeeDetails>? teeDetails;
  List<String>? facilities;
  List<Null>? rating;
  int? iV;
  bool? isSaved;
  Contact? contact;

  Courses(
      {this.sId,
        this.name,
        this.address,
        this.followersCount,
        this.distance,
        this.avgRating,
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
        this.rating,
        this.iV,
        this.isSaved,
        this.contact});

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    followersCount = json['followersCount'];
    avgRating = json['avgRating'];
    distance = json['distance'];
    city = json['city'];
    state = json['state'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    gallery = json['gallery'].cast<String>();
    description = json['description'];
    holesCount = json['holesCount'];
    if (json['teeDetails'] != null) {
      teeDetails = <TeeDetails>[];
      json['teeDetails'].forEach((v) {
        teeDetails!.add(new TeeDetails.fromJson(v));
      });
    }
    facilities = json['facilities'].cast<String>();

    iV = json['__v'];
    isSaved = json['isSaved'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
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
    if (this.teeDetails != null) {
      data['teeDetails'] = this.teeDetails!.map((v) => v.toJson()).toList();
    }
    data['facilities'] = this.facilities;

    data['__v'] = this.iV;
    data['isSaved'] = this.isSaved;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    return data;
  }
}

class TeeDetails {
  String? color;
  String? colorCode;
  int? distanceInYards;
  int? manScore;
  int? womanScore;
  String? sId;
  String? image;
  int? par;

  TeeDetails(
      {this.color,this.colorCode,
        this.distanceInYards,
        this.manScore,
        this.womanScore,
        this.sId,
        this.image,
        this.par});

  TeeDetails.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    colorCode = json['colorCode'] ?? '#2817e6';
    distanceInYards = json['distanceInYards'];
    manScore = json['manScore'];
    womanScore = json['womanScore'];
    sId = json['_id'];
    image = json['image'];
    par = json['par'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['colorCode'] = this.colorCode;
    data['distanceInYards'] = this.distanceInYards;
    data['manScore'] = this.manScore;
    data['womanScore'] = this.womanScore;
    data['_id'] = this.sId;
    data['image'] = this.image;
    data['par'] = this.par;
    return data;
  }
}

class Contact {
  String? phone;
  String? email;
  String? website;

  Contact({this.phone, this.email, this.website});

  Contact.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['website'] = this.website;
    return data;
  }
}
