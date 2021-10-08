class AllTransactionHistory {
  bool status;
  String message;
  Data data;

  AllTransactionHistory({this.status, this.message, this.data});

  AllTransactionHistory.fromJson(Map<String, dynamic> json) {
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
  List<Transactions> transactions;

  Data({this.transactions});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String user;
  String activity;
  String description;
  int amount;
  String status;
  String reference;
  String id;
  String createdAt;
  String updatedAt;

  Transactions(
      {this.user,
        this.activity,
        this.description,
        this.amount,
        this.status,
        this.reference,
        this.id,
        this.createdAt,
        this.updatedAt});

  Transactions.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    activity = json['activity'];
    description = json['description'];
    amount = json['amount'];
    status = json['status'];
    reference = json['reference'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['activity'] = this.activity;
    data['description'] = this.description;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['reference'] = this.reference;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
