class WithdrawalData {
  String message;
  bool status;
  Data data;

  WithdrawalData({this.message, this.status, this.data});

  WithdrawalData.fromJson(Map<String, dynamic> json) {
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
  int amount;
  String reference;
  String status;
  String dateCreated;
  int totalFee;

  Data(
      {this.amount,
      this.reference,
      this.status,
      this.dateCreated,
      this.totalFee});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    reference = json['reference'];
    status = json['status'];
    dateCreated = json['dateCreated'];
    totalFee = json['totalFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['reference'] = this.reference;
    data['status'] = this.status;
    data['dateCreated'] = this.dateCreated;
    data['totalFee'] = this.totalFee;
    return data;
  }
}
