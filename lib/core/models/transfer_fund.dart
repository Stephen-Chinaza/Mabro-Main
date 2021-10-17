class TransferFund {
  bool status;
  String message;
  Data data;

  TransferFund({this.status, this.message, this.data});

  TransferFund.fromJson(Map<String, dynamic> json) {
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
  var balance;
  var amountTransferred;

  Data({this.balance, this.amountTransferred});

  Data.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    amountTransferred = json['amount_transferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['amount_transferred'] = this.amountTransferred;
    return data;
  }
}
