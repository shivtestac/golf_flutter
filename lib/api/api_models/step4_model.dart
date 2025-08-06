class Step4Model {
  bool? status;
  String? message;
  List<String>? savedClubs;

  Step4Model({this.status, this.message, this.savedClubs});

  Step4Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    savedClubs = json['savedClubs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['savedClubs'] = this.savedClubs;
    return data;
  }
}
