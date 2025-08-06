class MyQuestionAnswerModel {
  int? status;
  List<MyQuestionAnswerData>? data;
  String? message;

  MyQuestionAnswerModel({this.status, this.data, this.message});

  MyQuestionAnswerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <MyQuestionAnswerData>[];
      json['data'].forEach((v) {
        data!.add(MyQuestionAnswerData.fromJson(v));
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

class MyQuestionAnswerData {
  int? id;
  int? questionId;
  String? answer;
  String? dateTime;
  int? userId;
  String? question;

  MyQuestionAnswerData(
      {this.id,
      this.questionId,
      this.answer,
      this.dateTime,
      this.userId,
      this.question});

  MyQuestionAnswerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    answer = json['answer'];
    dateTime = json['date_time'];
    userId = json['user_id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_id'] = questionId;
    data['answer'] = answer;
    data['date_time'] = dateTime;
    data['user_id'] = userId;
    data['question'] = question;
    return data;
  }
}
