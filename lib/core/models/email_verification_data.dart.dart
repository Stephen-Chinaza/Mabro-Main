class EmailVerificationData {
  String message;
  bool status;
  Data data;

  EmailVerificationData({this.message, this.status, this.data});

  EmailVerificationData.fromJson(Map<String, dynamic> json) {
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
  var nariaBalance;
  var bitcoinBalance;
  var bitcoinAddress;
  Settings settings;

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
      this.nariaBalance,
      this.bitcoinBalance,
      this.bitcoinAddress,
      this.settings});

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
    nariaBalance = json['naria_balance'];
    bitcoinBalance = json['bitcoin_balance'];
    bitcoinAddress = json['bitcoin_address'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
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
    data['naria_balance'] = this.nariaBalance;
    data['bitcoin_balance'] = this.bitcoinBalance;
    data['bitcoin_address'] = this.bitcoinAddress;
    if (this.settings != null) {
      data['settings'] = this.settings.toJson();
    }
    return data;
  }
}

class Settings {
  var user;
  var defaultAccount;
  var addFundPhoneAlert;
  var withdrawFundPhoneAlert;
  var addFundEmailAlert;
  var withdrawFundEmailAlert;
  var buyAssetPhoneAlert;
  var sellAssetPhoneAlert;
  var buyAssetEmailAlert;
  var sellAssetEmailAlert;
  var loginEmailAlert;
  var newsletterPhoneAlert;
  var newsletterEmailAlert;
  var smsAlert;
  var twoFactorAuth;
  var id;

  Settings(
      {this.user,
      this.defaultAccount,
      this.addFundPhoneAlert,
      this.withdrawFundPhoneAlert,
      this.addFundEmailAlert,
      this.withdrawFundEmailAlert,
      this.buyAssetPhoneAlert,
      this.sellAssetPhoneAlert,
      this.buyAssetEmailAlert,
      this.sellAssetEmailAlert,
      this.loginEmailAlert,
      this.newsletterPhoneAlert,
      this.newsletterEmailAlert,
      this.smsAlert,
      this.twoFactorAuth,
      this.id});

  Settings.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    defaultAccount = json['default_account'];
    addFundPhoneAlert = json['add_fund_phone_alert'];
    withdrawFundPhoneAlert = json['withdraw_fund_phone_alert'];
    addFundEmailAlert = json['add_fund_email_alert'];
    withdrawFundEmailAlert = json['withdraw_fund_email_alert'];
    buyAssetPhoneAlert = json['buy_asset_phone_alert'];
    sellAssetPhoneAlert = json['sell_asset_phone_alert'];
    buyAssetEmailAlert = json['buy_asset_email_alert'];
    sellAssetEmailAlert = json['sell_asset_email_alert'];
    loginEmailAlert = json['login_email_alert'];
    newsletterPhoneAlert = json['newsletter_phone_alert'];
    newsletterEmailAlert = json['newsletter_email_alert'];
    smsAlert = json['sms_alert'];
    twoFactorAuth = json['two_factor_auth'];
    id = json['id'];
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
    data['buy_asset_email_alert'] = this.buyAssetEmailAlert;
    data['sell_asset_email_alert'] = this.sellAssetEmailAlert;
    data['login_email_alert'] = this.loginEmailAlert;
    data['newsletter_phone_alert'] = this.newsletterPhoneAlert;
    data['newsletter_email_alert'] = this.newsletterEmailAlert;
    data['sms_alert'] = this.smsAlert;
    data['two_factor_auth'] = this.twoFactorAuth;
    data['id'] = this.id;
    return data;
  }
}
