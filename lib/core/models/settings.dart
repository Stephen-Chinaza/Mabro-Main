class SettingsData {
  String message;
  bool status;
  Data data;

  SettingsData({this.message, this.status, this.data});

  SettingsData.fromJson(Map<String, dynamic> json) {
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
  User user;
  Settings settings;
  bool bank;

  Data({this.user, this.settings, this.bank});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    bank = json['bank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    data['bank'] = this.bank;
    return data;
  }
}

class User {
  String firstName;
  String surname;
  String emailAddress;
  String phoneNumber;
  String password;
  int blocked;
  int verifiedEmail;
  int verifiedPhone;
  int id;
  String createdAt;
  String updatedAt;

  User(
      {this.firstName,
      this.surname,
      this.emailAddress,
      this.phoneNumber,
      this.password,
      this.blocked,
      this.verifiedEmail,
      this.verifiedPhone,
      this.id,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    surname = json['surname'];
    emailAddress = json['email_address'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    blocked = json['blocked'];
    verifiedEmail = json['verified_email'];
    verifiedPhone = json['verified_phone'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['surname'] = this.surname;
    data['email_address'] = this.emailAddress;
    data['phone_number'] = this.phoneNumber;
    data['password'] = this.password;
    data['blocked'] = this.blocked;
    data['verified_email'] = this.verifiedEmail;
    data['verified_phone'] = this.verifiedPhone;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Settings {
  int user;
  int defaultAccount;
  int addFundPhoneAlert;
  int withdrawFundPhoneAlert;
  int addFundEmailAlert;
  int withdrawFundEmailAlert;
  int buyAssetPhoneAlert;
  int sellAssetPhoneAlert;
  int buyAccessEmailAlert;
  int sellAssetEmailAlert;
  int loginEmailAlert;
  int newsletterPhoneAlert;
  int newsletterEmailAlert;
  int twoFactorAuth;
  int id;
  String createdAt;
  String updatedAt;

  Settings(
      {this.user,
      this.defaultAccount,
      this.addFundPhoneAlert,
      this.withdrawFundPhoneAlert,
      this.addFundEmailAlert,
      this.withdrawFundEmailAlert,
      this.buyAssetPhoneAlert,
      this.sellAssetPhoneAlert,
      this.buyAccessEmailAlert,
      this.sellAssetEmailAlert,
      this.loginEmailAlert,
      this.newsletterPhoneAlert,
      this.newsletterEmailAlert,
      this.twoFactorAuth,
      this.id,
      this.createdAt,
      this.updatedAt});

  Settings.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    defaultAccount = json['default_account'];
    addFundPhoneAlert = json['add_fund_phone_alert'];
    withdrawFundPhoneAlert = json['withdraw_fund_phone_alert'];
    addFundEmailAlert = json['add_fund_email_alert'];
    withdrawFundEmailAlert = json['withdraw_fund_email_alert'];
    buyAssetPhoneAlert = json['buy_asset_phone_alert'];
    sellAssetPhoneAlert = json['sell_asset_phone_alert'];
    buyAccessEmailAlert = json['buy_access_email_alert'];
    sellAssetEmailAlert = json['sell_asset_email_alert'];
    loginEmailAlert = json['login_email_alert'];
    newsletterPhoneAlert = json['newsletter_phone_alert'];
    newsletterEmailAlert = json['newsletter_email_alert'];
    twoFactorAuth = json['two_factor_auth'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['default_account'] = this.defaultAccount;
    data['add_fund_phone_alert'] = this.addFundPhoneAlert;
    data['withdraw_fund_phone_alert'] = this.withdrawFundPhoneAlert;
    data['add_fund_email_alert'] = this.addFundEmailAlert;
    data['withdraw_fund_email_alert'] = this.withdrawFundEmailAlert;
    data['buy_asset_phone_alert'] = this.buyAssetPhoneAlert;
    data['sell_asset_phone_alert'] = this.sellAssetPhoneAlert;
    data['buy_access_email_alert'] = this.buyAccessEmailAlert;
    data['sell_asset_email_alert'] = this.sellAssetEmailAlert;
    data['login_email_alert'] = this.loginEmailAlert;
    data['newsletter_phone_alert'] = this.newsletterPhoneAlert;
    data['newsletter_email_alert'] = this.newsletterEmailAlert;
    data['two_factor_auth'] = this.twoFactorAuth;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
