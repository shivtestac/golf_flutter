class AboutUsModel {
  int? status;
  AboutUsData? data;

  AboutUsModel({this.status, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AboutUsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutUsData {
  int? contentId;
  String? contentTitle;
  String? contentDescription;

  AboutUsData({this.contentId, this.contentTitle, this.contentDescription});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentTitle = json['content_title'];
    contentDescription = json['content_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['content_title'] = contentTitle;
    data['content_description'] = contentDescription;
    return data;
  }
}
