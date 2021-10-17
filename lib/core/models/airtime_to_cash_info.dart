class AirtimeToCashInfo {
  String message;
  bool status;
  Data data;

  AirtimeToCashInfo({this.message, this.status, this.data});

  AirtimeToCashInfo.fromJson(Map<String, dynamic> json) {
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
  String mtnChangePin;
  String mtnTransfer;
  String airtelChangePin;
  String airtelTransfer;
  String gloChangePin;
  String gloTransfer;
  String mobileChangePin;
  String mobileTransfer;

  Data(
      {this.mtnChangePin,
        this.mtnTransfer,
        this.airtelChangePin,
        this.airtelTransfer,
        this.gloChangePin,
        this.gloTransfer,
        this.mobileChangePin,
        this.mobileTransfer});

  Data.fromJson(Map<String, dynamic> json) {
    mtnChangePin = json['mtn_change_pin'];
    mtnTransfer = json['mtn_transfer'];
    airtelChangePin = json['airtel_change_pin'];
    airtelTransfer = json['airtel_transfer'];
    gloChangePin = json['glo_change_pin'];
    gloTransfer = json['glo_transfer'];
    mobileChangePin = json['mobile_change_pin'];
    mobileTransfer = json['mobile_transfer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mtn_change_pin'] = this.mtnChangePin;
    data['mtn_transfer'] = this.mtnTransfer;
    data['airtel_change_pin'] = this.airtelChangePin;
    data['airtel_transfer'] = this.airtelTransfer;
    data['glo_change_pin'] = this.gloChangePin;
    data['glo_transfer'] = this.gloTransfer;
    data['mobile_change_pin'] = this.mobileChangePin;
    data['mobile_transfer'] = this.mobileTransfer;
    return data;
  }
}
