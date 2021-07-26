class UpdateBankDetails {
  String message;
  bool status;
  Data data;

  UpdateBankDetails({this.message, this.status, this.data});

  UpdateBankDetails.fromJson(Map<String, dynamic> json) {
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
  String user;
  String accountName;
  String accountNumber;
  String bankName;
  String bvn;
  String bankCode;
  String id;

  Data(
      {this.user,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bvn,
      this.bankCode,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bvn = json['bvn'];
    bankCode = json['bank_code'];
    id = json['id'];
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
    return data;
  }
}
