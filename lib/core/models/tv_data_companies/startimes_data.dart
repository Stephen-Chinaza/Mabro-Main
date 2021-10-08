class StartimesDataCompany {
  bool status;
  String message;
  Data data;

  StartimesDataCompany({this.status, this.message, this.data});

  StartimesDataCompany.fromJson(Map<String, dynamic> json) {
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
  List<Startimes> startimes;

  Data({this.startimes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['startimes'] != null) {
      startimes = new List<Startimes>();
      json['startimes'].forEach((v) {
        startimes.add(new Startimes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startimes != null) {
      data['startimes'] = this.startimes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Startimes {
  String apiSource;
  String serviceId;
  String name;
  String package;
  String packageId;
  int apiPrice;
  int price;
  int apiActive;
  int active;
  String id;
  String createdAt;
  String updatedAt;

  Startimes(
      {this.apiSource,
        this.serviceId,
        this.name,
        this.package,
        this.packageId,
        this.apiPrice,
        this.price,
        this.apiActive,
        this.active,
        this.id,
        this.createdAt,
        this.updatedAt});

  Startimes.fromJson(Map<String, dynamic> json) {
    apiSource = json['api_source'];
    serviceId = json['service_id'];
    name = json['name'];
    package = json['package'];
    packageId = json['package_id'];
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
    data['service_id'] = this.serviceId;
    data['name'] = this.name;
    data['package'] = this.package;
    data['package_id'] = this.packageId;
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
