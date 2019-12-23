import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {

  static const String pref_user_display_name = "USER_DISPLAY_NAME";

  void setCurrentUserDisplayName(SharedPreferences prefs, String displayName) async {
    await prefs.setString(pref_user_display_name, displayName);
  }

  String getCurrentUserDisplayName(SharedPreferences prefs) {
    return prefs.getString(pref_user_display_name) ?? null;
  }
}