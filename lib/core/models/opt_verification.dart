class OtpVerification {
  bool status;
  String message;
  Data data;

  OtpVerification({this.status, this.message, this.data});

  OtpVerification.fromJson(Map<String, dynamic> json) {
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
  int amount;
  int balance;

  Data({this.amount, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['balance'] = this.balance;
    return data;
  }
}
