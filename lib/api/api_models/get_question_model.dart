class GetQuestionModel {
  int? status;
  List<GetQuestionData>? data;
  String? message;

  GetQuestionModel({this.status, this.data, this.message});

  GetQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <GetQuestionData>[];
      json['data'].forEach((v) {
        data!.add(GetQuestionData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class GetQuestionData {
  int? id;
  String? question;
  String? dateTime;
  String? answer;
  bool? status = false;

  GetQuestionData(
      {this.id, this.question, this.dateTime, this.answer, this.status});

  GetQuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    dateTime = json['date_time'];
    answer = json['answer'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['date_time'] = dateTime;
    return data;
  }
}
