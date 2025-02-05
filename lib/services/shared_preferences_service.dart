import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  // Inicializasiya funksiyası
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Mətni saxlamaq
  static Future<void> saveString(String key, String value) async {
    await init(); // Əgər əvvəllər başlatılmayıbsa, başlatmaq
    await _prefs!.setString(key, value);
  }

  // Mətni oxumaq
  static Future<String?> getString(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  // Bütün verilənləri silmək
  static Future<void> clear() async {
    await init(); // Əgər əvvəllər başlatılmayıbsa, başlatmaq
    await _prefs!.clear();
  }
}
