import 'package:shared_preferences/shared_preferences.dart';

class EmergencySharePreference {
  activatedEmergency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("emergency", true);
  }

  disableEmergency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("emergency", false);
  }

  Future getEmergency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("emergency");
  }
}
