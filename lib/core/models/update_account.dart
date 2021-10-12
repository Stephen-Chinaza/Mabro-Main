class UpdateBankDetails {
  bool status;
  String message;
  Data data;

  UpdateBankDetails({this.status, this.message, this.data});

  UpdateBankDetails.fromJson(Map<String, dynamic> json) {
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
  String accountName;

  Data({this.accountName});

  Data.fromJson(Map<String, dynamic> json) {
    accountName = json['accountName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountName'] = this.accountName;
    return data;
  }
}
