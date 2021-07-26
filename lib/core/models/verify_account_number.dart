class AccountVerification {
  String message;
  bool status;
  Data data;

  AccountVerification({this.message, this.status, this.data});

  AccountVerification.fromJson(Map<String, dynamic> json) {
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
  var user;
  var accountName;
  String accountNumber;
  String bankName;
  var bvn;
  var bankCode;
  var id;
  var createdAt;
  var updatedAt;

  Data(
      {this.user,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bvn,
      this.bankCode,
      this.id,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bvn = json['bvn'];
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
    data['bvn'] = this.bvn;
    data['bank_code'] = this.bankCode;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
