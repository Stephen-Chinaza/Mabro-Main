class RegisterUser {
  bool status;
  String message;
  Causes causes;
  Data data;

  RegisterUser({this.status, this.message, this.causes, this.data});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    causes =
    json['causes'] != null ? new Causes.fromJson(json['causes']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.causes != null) {
      data['causes'] = this.causes.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

}

class Data {
  String oTP;
  String userId;

  Data({this.oTP, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    oTP = json['OTP'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OTP'] = this.oTP;
    data['userId'] = this.userId;
    return data;
  }
}

class Causes {
  String emailAddress;

  Causes({this.emailAddress});

  Causes.fromJson(Map<String, dynamic> json) {
    emailAddress = json['email_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_address'] = this.emailAddress;
    return data;
  }
}
