class P2PExchangeDetails {
  String message;
  bool status;
  Data data;

  P2PExchangeDetails({this.message, this.status, this.data});

  P2PExchangeDetails.fromJson(Map<String, dynamic> json) {
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
  Basic basic;
  Bitcoin bitcoin;
  Bitcoin litecoin;
  Dogecoin dogecoin;

  Data({this.basic, this.bitcoin, this.litecoin, this.dogecoin});

  Data.fromJson(Map<String, dynamic> json) {
    basic = json['basic'] != null ? new Basic.fromJson(json['basic']) : null;
    bitcoin =
        json['bitcoin'] != null ? new Bitcoin.fromJson(json['bitcoin']) : null;
    litecoin = json['litecoin'] != null
        ? new Bitcoin.fromJson(json['litecoin'])
        : null;
    dogecoin = json['dogecoin'] != null
        ? new Dogecoin.fromJson(json['dogecoin'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basic != null) {
      data['basic'] = this.basic.toJson();
    }
    if (this.bitcoin != null) {
      data['bitcoin'] = this.bitcoin.toJson();
    }
    if (this.litecoin != null) {
      data['litecoin'] = this.litecoin.toJson();
    }
    if (this.dogecoin != null) {
      data['dogecoin'] = this.dogecoin.toJson();
    }
    return data;
  }
}

class Basic {
  var exchangeRate;
  String defaultCurrency;

  Basic({this.exchangeRate, this.defaultCurrency});

  Basic.fromJson(Map<String, dynamic> json) {
    exchangeRate = json['exchange_rate'];
    defaultCurrency = json['default_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exchange_rate'] = this.exchangeRate;
    data['default_currency'] = this.defaultCurrency;
    return data;
  }
}

class Bitcoin {
  int buyingPrice;
  int sellingPrice;
  int usdBuyingPrice;
  int usdSellingPrice;

  Bitcoin(
      {this.buyingPrice,
      this.sellingPrice,
      this.usdBuyingPrice,
      this.usdSellingPrice});

  Bitcoin.fromJson(Map<String, dynamic> json) {
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    usdBuyingPrice = json['usd_buying_price'];
    usdSellingPrice = json['usd_selling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buying_price'] = this.buyingPrice;
    data['selling_price'] = this.sellingPrice;
    data['usd_buying_price'] = this.usdBuyingPrice;
    data['usd_selling_price'] = this.usdSellingPrice;
    return data;
  }
}

class Dogecoin {
  int buyingPrice;
  int sellingPrice;
  double usdBuyingPrice;
  double usdSellingPrice;

  Dogecoin(
      {this.buyingPrice,
      this.sellingPrice,
      this.usdBuyingPrice,
      this.usdSellingPrice});

  Dogecoin.fromJson(Map<String, dynamic> json) {
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    usdBuyingPrice = json['usd_buying_price'];
    usdSellingPrice = json['usd_selling_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buying_price'] = this.buyingPrice;
    data['selling_price'] = this.sellingPrice;
    data['usd_buying_price'] = this.usdBuyingPrice;
    data['usd_selling_price'] = this.usdSellingPrice;
    return data;
  }
}
