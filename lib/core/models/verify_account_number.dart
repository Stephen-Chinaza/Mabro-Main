class AccountVerification {
  bool status;
  String message;
  Data data;

  AccountVerification({this.status, this.message, this.data});

  AccountVerification.fromJson(Map<String, dynamic> json) {
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
  var firstName;
  var surname;
  var dob;
  var phone;

  Data({this.firstName, this.surname, this.dob, this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    surname = json['surname'];
    dob = json['dob'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['surname'] = this.surname;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    return data;
  }
}
