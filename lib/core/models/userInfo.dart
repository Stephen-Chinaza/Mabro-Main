class UserInfo {
  bool status;
  String message;
  Data data;

  UserInfo({this.status, this.message, this.data});

  UserInfo.fromJson(Map<String, dynamic> json) {
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
  Bvns bvns;
  var account;
  var settings;

  Data({this.bvns, this.account, this.settings});

  Data.fromJson(Map<String, dynamic> json) {
    bvns = json['bvns'] != null ? new Bvns.fromJson(json['bvns']) : null;
    account =
        json['account'] != null ? new Account.fromJson(json['account']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bvns != null) {
      data['bvns'] = this.bvns.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    return data;
  }
}

class Bvns {
  String user;
  String bvn;
  String firstName;
  String surname;
  String id;
  String createdAt;
  String updatedAt;

  Bvns(
      {this.user,
      this.bvn,
      this.firstName,
      this.surname,
      this.id,
      this.createdAt,
      this.updatedAt});

  Bvns.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    bvn = json['bvn'];
    firstName = json['first_name'];
    surname = json['surname'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['bvn'] = this.bvn;
    data['first_name'] = this.firstName;
    data['surname'] = this.surname;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Account {
  String user;
  String accountName;
  String accountNumber;
  String bankName;
  String bankCode;
  String id;
  String createdAt;
  String updatedAt;

  Account(
      {this.user,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bankCode,
      this.id,
      this.createdAt,
      this.updatedAt});

  Account.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Settings {
  String user;
  int smsNotification;
  int emailTransactionNotification;
  int twoFactorAuthentication;
  int fingerPrintLogin;
  int newsletter;
  String id;
  String createdAt;
  String updatedAt;

  Settings(
      {this.user,
      this.smsNotification,
      this.emailTransactionNotification,
      this.twoFactorAuthentication,
      this.fingerPrintLogin,
      this.newsletter,
      this.id,
      this.createdAt,
      this.updatedAt});

  Settings.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    smsNotification = json['sms_notification'];
    emailTransactionNotification = json['email_transaction_notification'];
    twoFactorAuthentication = json['two_factor_authentication'];
    fingerPrintLogin = json['finger_print_login'];
    newsletter = json['newsletter'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['sms_notification'] = this.smsNotification;
    data['email_transaction_notification'] = this.emailTransactionNotification;
    data['two_factor_authentication'] = this.twoFactorAuthentication;
    data['finger_print_login'] = this.fingerPrintLogin;
    data['newsletter'] = this.newsletter;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
