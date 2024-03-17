import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences prefs;

  static String? getSteps() {
    return prefs.getString("Steps");
  }

  static saveSteps(String steps) async {
    await prefs.setString("Steps", steps);
  }

  static int? getWaterHeight() {
    return prefs.getInt("Water Height");
  }

  static saveWaterHeight(int waterHeight) async {
    await prefs.setInt("Water Height", waterHeight);
  }

  static int? getMLDrunk() {
    return prefs.getInt("ml Drunk");
  }

  static saveMLDrunk(int ml) async {
    await prefs.setInt("ml Drunk", ml);
  }

  static String? getWeight() {
    return prefs.getString("Weight");
  }

  static saveWeight(String weight) async {
    await prefs.setString("Weight", weight);
  }

  static String? getHeight() {
    return prefs.getString("Height");
  }

  static saveHeight(String oldWeight) async {
    await prefs.setString("Height", oldWeight);
  }
}
