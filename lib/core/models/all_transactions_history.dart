class AllTransactionHistory {
  String message;
  bool status;
  List<Data> data;

  AllTransactionHistory({this.message, this.status, this.data});

  AllTransactionHistory.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String user;
  String amount;
  String currency;
  String reference;
  String title;
  String description;
  String status;
  String id;
  String createdAt;
  String updatedAt;

  Data(
      {this.user,
      this.amount,
      this.currency,
      this.reference,
      this.title,
      this.description,
      this.status,
      this.id,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    amount = json['amount'];
    currency = json['currency'];
    reference = json['reference'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['reference'] = this.reference;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
