class dataGloList {
  bool status;
  String message;
  Data data;

  dataGloList({this.status, this.message, this.data});

  dataGloList.fromJson(Map<String, dynamic> json) {
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
  List<Glo> glo;

  Data({this.glo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['glo'] != null) {
      glo = new List<Glo>();
      json['glo'].forEach((v) {
        glo.add(new Glo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.glo != null) {
      data['glo'] = this.glo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Glo {
  String apiSource;
  String dataId;
  int networkId;
  String network;
  String dataName;
  String size;
  String bonusSize;
  String duration;
  int apiPrice;
  int price;
  int apiActive;
  int active;
  String id;
  String createdAt;
  String updatedAt;

  Glo(
      {this.apiSource,
        this.dataId,
        this.networkId,
        this.network,
        this.dataName,
        this.size,
        this.bonusSize,
        this.duration,
        this.apiPrice,
        this.price,
        this.apiActive,
        this.active,
        this.id,
        this.createdAt,
        this.updatedAt});

  Glo.fromJson(Map<String, dynamic> json) {
    apiSource = json['api_source'];
    dataId = json['data_id'];
    networkId = json['network_id'];
    network = json['network'];
    dataName = json['data_name'];
    size = json['size'];
    bonusSize = json['bonus_size'];
    duration = json['duration'];
    apiPrice = json['api_price'];
    price = json['price'];
    apiActive = json['api_active'];
    active = json['active'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_source'] = this.apiSource;
    data['data_id'] = this.dataId;
    data['network_id'] = this.networkId;
    data['network'] = this.network;
    data['data_name'] = this.dataName;
    data['size'] = this.size;
    data['bonus_size'] = this.bonusSize;
    data['duration'] = this.duration;
    data['api_price'] = this.apiPrice;
    data['price'] = this.price;
    data['api_active'] = this.apiActive;
    data['active'] = this.active;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
