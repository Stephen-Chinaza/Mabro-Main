import 'dart:convert';

import 'package:http/http.dart' as http;

class APIService {
  // secret key
  static final String secretKey =
      'sk_test_5031aae886b430022c410efb43b64b6f3f1a764d';
  // public key
  static final String publicKey =
      'pk_test_9a1befcef6741639660d3028bb8414b2216c8f04';

  // initialize transaction url
  static var initTransactionUrl =
      Uri.parse('https://api.paystack.co/transaction/initialize');

  // initialize transaction connection
  static Future initTransaction(
      String secretKey, String amount, String email) async {
    // headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $secretKey'
    };

    // body
    Map<String, String> body = {"amount": amount, "email": email};

    // api connection
    var response = await http.post(APIService.initTransactionUrl,
        headers: headers, body: jsonEncode(body));
//    print(response.body);
    var values = jsonDecode(response.body);
    return values;
  }
}
