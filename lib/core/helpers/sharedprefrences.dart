import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrences {
  static Future addBoolToSP(String boolValue, bool value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(boolValue, value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

 static Future addStringToSP(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
  

  addIntToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', 123);
  }

  addDoubleToSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('doubleValue', 115.0);
  }
}
