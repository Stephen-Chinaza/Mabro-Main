class BuyAirtimeBundle {
  String message;
  bool status;
  Data data;

  BuyAirtimeBundle({this.message, this.status, this.data});

  BuyAirtimeBundle.fromJson(Map<String, dynamic> json) {
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
  String code;
  Content content;
  String responseDescription;
  String requestId;
  String amount;
  TransactionDate transactionDate;
  String purchasedCode;

  Data(
      {this.code,
      this.content,
      this.responseDescription,
      this.requestId,
      this.amount,
      this.transactionDate,
      this.purchasedCode});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    responseDescription = json['response_description'];
    requestId = json['requestId'];
    amount = json['amount'];
    transactionDate = json['transaction_date'] != null
        ? new TransactionDate.fromJson(json['transaction_date'])
        : null;
    purchasedCode = json['purchased_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['response_description'] = this.responseDescription;
    data['requestId'] = this.requestId;
    data['amount'] = this.amount;
    if (this.transactionDate != null) {
      data['transaction_date'] = this.transactionDate.toJson();
    }
    data['purchased_code'] = this.purchasedCode;
    return data;
  }
}

class Content {
  Transactions transactions;

  Content({this.transactions});

  Content.fromJson(Map<String, dynamic> json) {
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.transactions != null) {
      data['transactions'] = this.transactions.toJson();
    }
    return data;
  }
}

class Transactions {
  String status;
  String productName;
  String uniqueElement;
  int unitPrice;
  int quantity;
  Null serviceVerification;
  String channel;
  int commission;
  int totalAmount;
  Null discount;
  String type;
  String email;
  String phone;
  Null name;
  int convinienceFee;
  int amount;
  String platform;
  String method;
  String transactionId;

  Transactions(
      {this.status,
      this.productName,
      this.uniqueElement,
      this.unitPrice,
      this.quantity,
      this.serviceVerification,
      this.channel,
      this.commission,
      this.totalAmount,
      this.discount,
      this.type,
      this.email,
      this.phone,
      this.name,
      this.convinienceFee,
      this.amount,
      this.platform,
      this.method,
      this.transactionId});

  Transactions.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productName = json['product_name'];
    uniqueElement = json['unique_element'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    serviceVerification = json['service_verification'];
    channel = json['channel'];
    commission = json['commission'];
    totalAmount = json['total_amount'];
    discount = json['discount'];
    type = json['type'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    convinienceFee = json['convinience_fee'];
    amount = json['amount'];
    platform = json['platform'];
    method = json['method'];
    transactionId = json['transactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['product_name'] = this.productName;
    data['unique_element'] = this.uniqueElement;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['service_verification'] = this.serviceVerification;
    data['channel'] = this.channel;
    data['commission'] = this.commission;
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['convinience_fee'] = this.convinienceFee;
    data['amount'] = this.amount;
    data['platform'] = this.platform;
    data['method'] = this.method;
    data['transactionId'] = this.transactionId;
    return data;
  }
}

class TransactionDate {
  String date;
  int timezoneType;
  String timezone;

  TransactionDate({this.date, this.timezoneType, this.timezone});

  TransactionDate.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timezoneType = json['timezone_type'];
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['timezone_type'] = this.timezoneType;
    data['timezone'] = this.timezone;
    return data;
  }
}
