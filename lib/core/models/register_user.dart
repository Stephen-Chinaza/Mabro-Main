class RegisterUser {
  String message;
  bool status;
  Data data;

  RegisterUser({this.message, this.status, this.data});

  RegisterUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null) ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String firstName;
  String surName;
  String emailAddress;
  String phoneNumber;
  String password;
  var blocked;
  var verifiedEmail;
  var verifiedPhone;
  var id;
  String code;

  Data(
      {
        this.firstName,
        this.surName,
        this.phoneNumber,
        this.emailAddress,
        this.id,this.code});

  Data.fromJson(Map<String, dynamic> json) {
    
    firstName = json['first_name'];
    surName = json['surname'];
    emailAddress = json['email_address'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    blocked = json['blocked'];
    verifiedEmail = json['verified_email'];  
    verifiedPhone = json['verified_phone'];  
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   
    data['first_name'] = this.firstName;
     data['surname'] = this.surName;
    data['email_address'] = this.emailAddress;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['blocked'] = this.blocked;
    data['verified_email'] = this.verifiedEmail;
    data['verified_phone'] = this.verifiedPhone;
    data['id'] = this.id;
    data['code'] = this.code;
    return data;
  }
}
