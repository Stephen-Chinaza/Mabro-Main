class VerifySmartcard {
  bool status;
  String message;
  Data data;

  VerifySmartcard({this.status, this.message, this.data});

  VerifySmartcard.fromJson(Map<String, dynamic> json) {
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
  int apiId;
  String apiReference;
  String reference;
  String responseMessage;
  String redirectUrl;
  String authMode;

  Data(
      {this.apiId,
        this.apiReference,
        this.reference,
        this.responseMessage,
        this.redirectUrl,
        this.authMode});

  Data.fromJson(Map<String, dynamic> json) {
    apiId = json['api_id'];
    apiReference = json['api_reference'];
    reference = json['reference'];
    responseMessage = json['response_message'];
    redirectUrl = json['redirect_url'];
    authMode = json['auth_mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_id'] = this.apiId;
    data['api_reference'] = this.apiReference;
    data['reference'] = this.reference;
    data['response_message'] = this.responseMessage;
    data['redirect_url'] = this.redirectUrl;
    data['auth_mode'] = this.authMode;
    return data;
  }
}
