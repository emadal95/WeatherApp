import 'package:shared_preferences/shared_preferences.dart';
import 'package:weathernow/src/data/shared_preferences/preferences_const.dart';

class PreferencesController {
  static Future<void> savePreference(PreferenceKey key, dynamic value) async {
    if (value == null) return;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    PreferenceType valueType = PreferenceKeyTypes[key] ?? PreferenceType.string;
    switch (valueType) {
      case PreferenceType.string:
        await preferences.setString(key.name, value as String);
        break;
      case PreferenceType.number:
        await preferences.setInt(key.name, value as int);
        break;
      case PreferenceType.list:
        await preferences.setStringList(key.name, value as List<String>);
        break;
    }
  }

  static Future<T?> getPreference<T>(PreferenceKey key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    PreferenceType valueType = PreferenceKeyTypes[key] ?? PreferenceType.string;
    switch (valueType) {
      case PreferenceType.string:
        return preferences.getString(key.name) as T?;
      case PreferenceType.number:
        return preferences.getInt(key.name) as T?;
      case PreferenceType.list:
        return preferences.getStringList(key.name) as T?;
    }
  }
}
