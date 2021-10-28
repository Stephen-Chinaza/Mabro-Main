class UpdateBankDetails {
  bool status;
  String message;
  Data data;

  UpdateBankDetails({this.status, this.message, this.data});

  UpdateBankDetails.fromJson(Map<String, dynamic> json) {
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
  String user;
  String accountName;
  String accountNumber;
  String bankName;
  String bankCode;
  String id;

  Data(
      {this.user,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bankCode,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankCode = json['bank_code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_code'] = this.bankCode;
    data['id'] = this.id;
    return data;
  }
}
