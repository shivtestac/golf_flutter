class AddQuestionModel {
  int? status;
  AddQuestionData? data;
  String? message;

  AddQuestionModel({this.status, this.data, this.message});

  AddQuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? AddQuestionData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class AddQuestionData {
  int? id;
  String? userName;
  String? address;
  String? email;
  String? emailVerifiedAt;
  String? password;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? mobile;
  String? mobileCountryCode;
  String? image;
  String? deletedAt;
  String? otp;
  String? questionAnswerStatus;

  AddQuestionData(
      {this.id,
      this.userName,
      this.address,
      this.email,
      this.emailVerifiedAt,
      this.password,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.mobile,
      this.mobileCountryCode,
      this.image,
      this.deletedAt,
      this.otp,
      this.questionAnswerStatus});

  AddQuestionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    address = json['address'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    rememberToken = json['remember_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mobile = json['mobile'];
    mobileCountryCode = json['mobile_country_code'];
    image = json['image'];
    deletedAt = json['deleted_at'];
    otp = json['otp'];
    questionAnswerStatus = json['question_answer_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['address'] = address;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['password'] = password;
    data['remember_token'] = rememberToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mobile'] = mobile;
    data['mobile_country_code'] = mobileCountryCode;
    data['image'] = image;
    data['deleted_at'] = deletedAt;
    data['otp'] = otp;
    data['question_answer_status'] = questionAnswerStatus;
    return data;
  }
}
