class BuyAirtimeBundle {
  bool status;
  String message;
  Data data;

  BuyAirtimeBundle({this.status, this.message, this.data});

  BuyAirtimeBundle.fromJson(Map<String, dynamic> json) {
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
  String token;
  var balance;

  Data({this.token, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['balance'] = this.balance;
    return data;
  }
}
