class LoginUser {
  bool status;
  String message;
  Data data;

  LoginUser({this.status, this.message, this.data});

  LoginUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  var firstName;
  var surname;
  var emailAddress;
  var phoneNumber;
  var lockCode;
  var password;
  var blocked;
  var verifiedEmail;
  var verifiedPhone;
  var id;
  var createdAt;
  var updatedAt;
  var userId;
  var nairaBalance;

  Data(
      {this.firstName,
        this.surname,
        this.emailAddress,
        this.phoneNumber,
        this.lockCode,
        this.password,
        this.blocked,
        this.verifiedEmail,
        this.verifiedPhone,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.nairaBalance});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    surname = json['surname'];
    emailAddress = json['email_address'];
    phoneNumber = json['phone_number'];
    lockCode = json['lock_code'];
    password = json['password'];
    blocked = json['blocked'];
    verifiedEmail = json['verified_email'];
    verifiedPhone = json['verified_phone'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['userId'];
    nairaBalance = json['nairaBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['surname'] = this.surname;
    data['email_address'] = this.emailAddress;
    data['phone_number'] = this.phoneNumber;
    data['lock_code'] = this.lockCode;
    data['password'] = this.password;
    data['blocked'] = this.blocked;
    data['verified_email'] = this.verifiedEmail;
    data['verified_phone'] = this.verifiedPhone;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['userId'] = this.userId;
    data['nairaBalance'] = this.nairaBalance;
    return data;
  }
}
