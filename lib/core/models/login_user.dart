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
  String firstName;
  String surname;
  String emailAddress;
  String phoneNumber;
  String lockCode;
  String password;
  var blocked;
  int verifiedEmail;
  int verifiedPhone;
  String id;
  String createdAt;
  String updatedAt;
  String userId;
  var nairaBalance;
  NairaWallet nairaWallet;
  Bitcoin bitcoin;
  Litecoin litecoin;
  Dogecoin dogecoin;

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
      this.nairaBalance,
      this.nairaWallet,
      this.bitcoin,
      this.litecoin,
      this.dogecoin});

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
    nairaWallet = json['nairaWallet'] != null
        ? new NairaWallet.fromJson(json['nairaWallet'])
        : null;
    bitcoin =
        json['bitcoin'] != null ? new Bitcoin.fromJson(json['bitcoin']) : null;
    litecoin = json['litecoin'] != null
        ? new Litecoin.fromJson(json['litecoin'])
        : null;
    dogecoin = json['dogecoin'] != null
        ? new Dogecoin.fromJson(json['dogecoin'])
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['userId'] = this.userId;
    data['nairaBalance'] = this.nairaBalance;
    if (this.nairaWallet != null) {
      data['nairaWallet'] = this.nairaWallet.toJson();
    }
    if (this.bitcoin != null) {
      data['bitcoin'] = this.bitcoin.toJson();
    }
    if (this.litecoin != null) {
      data['litecoin'] = this.litecoin.toJson();
    }
    if (this.dogecoin != null) {
      data['dogecoin'] = this.dogecoin.toJson();
    }
    return data;
  }
}

class NairaWallet {
  String user;
  double balance;
  String accountName;
  String accountNumber;
  String accountId;
  String accountCode;
  String bank;
  String bvn;
  String id;
  String createdAt;
  String updatedAt;

  NairaWallet(
      {this.user,
      this.balance,
      this.accountName,
      this.accountNumber,
      this.accountId,
      this.accountCode,
      this.bank,
      this.bvn,
      this.id,
      this.createdAt,
      this.updatedAt});

  NairaWallet.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    balance = json['balance'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    accountId = json['account_id'];
    accountCode = json['account_code'];
    bank = json['bank'];
    bvn = json['bvn'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['balance'] = this.balance;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['account_id'] = this.accountId;
    data['account_code'] = this.accountCode;
    data['bank'] = this.bank;
    data['bvn'] = this.bvn;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Bitcoin {
  String user;
  double balance;
  String label;
  String address;
  String addressId;
  String id;
  String createdAt;
  String updatedAt;

  Bitcoin(
      {this.user,
      this.balance,
      this.label,
      this.address,
      this.addressId,
      this.id,
      this.createdAt,
      this.updatedAt});

  Bitcoin.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    balance = json['balance'];
    label = json['label'];
    address = json['address'];
    addressId = json['address_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['balance'] = this.balance;
    data['label'] = this.label;
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Litecoin {
  String user;
  int balance;
  String label;
  String address;
  String addressId;
  String id;
  String createdAt;
  String updatedAt;

  Litecoin(
      {this.user,
      this.balance,
      this.label,
      this.address,
      this.addressId,
      this.id,
      this.createdAt,
      this.updatedAt});

  Litecoin.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    balance = json['balance'];
    label = json['label'];
    address = json['address'];
    addressId = json['address_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['balance'] = this.balance;
    data['label'] = this.label;
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Dogecoin {
  String user;
  int balance;
  String label;
  String address;
  String addressId;
  String id;
  String createdAt;
  String updatedAt;

  Dogecoin(
      {this.user,
      this.balance,
      this.label,
      this.address,
      this.addressId,
      this.id,
      this.createdAt,
      this.updatedAt});

  Dogecoin.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    balance = json['balance'];
    label = json['label'];
    address = json['address'];
    addressId = json['address_id'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['balance'] = this.balance;
    data['label'] = this.label;
    data['address'] = this.address;
    data['address_id'] = this.addressId;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
