class GetAvatarsModel {
  bool? success;
  String? message;
  List<String>? avatarUrls;

  GetAvatarsModel({this.success, this.message, this.avatarUrls});

  GetAvatarsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    avatarUrls = json['avatarUrls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['avatarUrls'] = this.avatarUrls;
    return data;
  }
}
