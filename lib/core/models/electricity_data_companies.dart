class ElectricityCompanyList {
  String message;
  bool status;
  Data data;

  ElectricityCompanyList({this.message, this.status, this.data});

  ElectricityCompanyList.fromJson(Map<String, dynamic> json) {
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
  List<Electricity> electricity;

  Data({this.electricity});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['electricity'] != null) {
      electricity = new List<Electricity>();
      json['electricity'].forEach((v) {
        electricity.add(new Electricity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.electricity != null) {
      data['electricity'] = this.electricity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Electricity {
  String apiSource;
  String serviceId;
  String name;
  int minAmount;
  int maxAmount;
  int serviceFee;
  int apiActive;
  int active;
  String id;
  String createdAt;
  String updatedAt;

  Electricity(
      {this.apiSource,
        this.serviceId,
        this.name,
        this.minAmount,
        this.maxAmount,
        this.serviceFee,
        this.apiActive,
        this.active,
        this.id,
        this.createdAt,
        this.updatedAt});

  Electricity.fromJson(Map<String, dynamic> json) {
    apiSource = json['api_source'];
    serviceId = json['service_id'];
    name = json['name'];
    minAmount = json['min_amount'];
    maxAmount = json['max_amount'];
    serviceFee = json['service_fee'];
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
    data['min_amount'] = this.minAmount;
    data['max_amount'] = this.maxAmount;
    data['service_fee'] = this.serviceFee;
    data['api_active'] = this.apiActive;
    data['active'] = this.active;
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
