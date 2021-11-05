class P2PExchangeDetails {
  String message;
  bool status;
  List<Data> data;

  P2PExchangeDetails({this.message, this.status, this.data});

  P2PExchangeDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
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
  var buyingPrice;
  var sellingPrice;
  var usdBuyingPrice;
  var usdSellingPrice;
  String coin;

  Data(
      {this.buyingPrice,
        this.sellingPrice,
        this.usdBuyingPrice,
        this.usdSellingPrice,
        this.coin});

  Data.fromJson(Map<String, dynamic> json) {
    buyingPrice = json['buying_price'];
    sellingPrice = json['selling_price'];
    usdBuyingPrice = json['usd_buying_price'];
    usdSellingPrice = json['usd_selling_price'];
    coin = json['coin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buying_price'] = this.buyingPrice;
    data['selling_price'] = this.sellingPrice;
    data['usd_buying_price'] = this.usdBuyingPrice;
    data['usd_selling_price'] = this.usdSellingPrice;
    data['coin'] = this.coin;
    return data;
  }
}
