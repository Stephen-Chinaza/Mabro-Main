class LoginUser {
  String message;
  bool status;
  Data data;

  LoginUser({this.message, this.status, this.data});

  LoginUser.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String surname;
  String emailAddress;
  String phoneNumber;
  String lockCode;
  String password;
  String blocked;
  String verifiedEmail;
  String verifiedPhone;
  String id;
  String createdAt;
  String updatedAt;
  String nariaBalance;
  String bitcoinBalance;
  String usdBalance;
  String bitcoinAddress;

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
      this.nariaBalance,
      this.bitcoinBalance,
      this.usdBalance,
      this.bitcoinAddress});

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
    nariaBalance = json['naria_balance'];
    bitcoinBalance = json['bitcoin_balance'];
    usdBalance = json['usd_balance'];
    bitcoinAddress = json['bitcoin_address'];
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
    data['naria_balance'] = this.nariaBalance;
    data['bitcoin_balance'] = this.bitcoinBalance;
    data['usd_balance'] = this.usdBalance;
    data['bitcoin_address'] = this.bitcoinAddress;
    return data;
  }
}
