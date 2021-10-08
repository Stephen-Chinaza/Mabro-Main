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
  String authMode;
  String redirectUrl;

  Data(
      {this.apiId,
        this.apiReference,
        this.reference,
        this.responseMessage,
        this.authMode,
        this.redirectUrl});

  Data.fromJson(Map<String, dynamic> json) {
    apiId = json['api_id'];
    apiReference = json['api_reference'];
    reference = json['reference'];
    responseMessage = json['response_message'];
    authMode = json['auth_mode'];
    redirectUrl = json['redirect_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['api_id'] = this.apiId;
    data['api_reference'] = this.apiReference;
    data['reference'] = this.reference;
    data['response_message'] = this.responseMessage;
    data['auth_mode'] = this.authMode;
    data['redirect_url'] = this.redirectUrl;
    return data;
  }
}
