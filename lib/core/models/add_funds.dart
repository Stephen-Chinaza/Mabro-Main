class AddFunds {
  String message;
  bool status;
  Data data;

  AddFunds({this.message, this.status, this.data});

  AddFunds.fromJson(Map<String, dynamic> json) {
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
  var amount;
  var currency;
  var reference;
  var source;
  var sourceReference;
  var status;
  var id;
  var createdAt;
  var updatedAt;
  var nairaBalance;

  Data(
      {this.user,
      this.amount,
      this.currency,
      this.reference,
      this.source,
      this.sourceReference,
      this.status,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.nairaBalance});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    amount = json['amount'];
    currency = json['currency'];
    reference = json['reference'];
    source = json['source'];
    sourceReference = json['source_reference'];
    status = json['status'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nairaBalance = json['nairaBalance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['reference'] = this.reference;
    data['source'] = this.source;
    data['source_reference'] = this.sourceReference;
    data['status'] = this.status;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nairaBalance'] = this.nairaBalance;
    return data;
  }
}
