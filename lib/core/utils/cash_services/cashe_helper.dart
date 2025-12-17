import 'dart:async';
import 'dart:developer';

// import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CacheHelper {
  static late SharedPreferences sharedPreferences;
  static final Completer<SharedPreferences> completer =
      Completer<SharedPreferences>();

  static Future<SharedPreferences> init() async {
    if (completer.isCompleted) {
      return completer.future;
    }
    sharedPreferences = await SharedPreferences.getInstance();
    completer.complete(sharedPreferences);
    return sharedPreferences;
  }

  static T? getData<T>({required String key}) {
    try {
      return sharedPreferences.get(key) as T?;
    } catch (e, st) {
      log(e.toString(), stackTrace: st, name: 'CacheHelper getData');
      return null;
    }
  }

  static Future<void> removeLoginCredentials() async {
    await removeData(key: 'email');
    await removeData(key: 'password');
    await removeData(key: 'rememberMe');
  }

  static Map<String, dynamic>? getLoginCredentials() {
    final email = getData<String>(key: 'email');
    final password = getData<String>(key: 'password');
    final rememberMe = getData<bool>(key: 'rememberMe') ?? false;

    if (email != null && password != null) {
      return {'email': email, 'password': password, 'rememberMe': rememberMe};
    }
    return null;
  }

  static Future<void> deleteData({required String key}) async {
    await CacheHelper.removeData(key: key);
  }

  static Future<void> deleteFawaselList({required String key}) async {
    await CacheHelper.removeData(key: key);
  }

  static Future<void> deleteFavouritesList({required String key}) async {
    await CacheHelper.removeData(key: key);
  }

  static Future<bool> saveData({required String key, required value}) async {
    if (value == null) return false; // Return false for null values
    if (value is String) return sharedPreferences.setString(key, value);
    if (value is int) return sharedPreferences.setInt(key, value);
    if (value is bool) return sharedPreferences.setBool(key, value);
    if (value is double) return sharedPreferences.setDouble(key, value);

    return false; // Return false for unsupported types
  }

  static Future<bool> saveStringData({
    required String key,
    required List<String> value,
  }) async {
    return sharedPreferences.setStringList(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return sharedPreferences.remove(key);
  }

  static Future<bool> removeAllData() async {
    // Save values to keep
    final theme = sharedPreferences.get(Constant.kThemeMode);
    final advertisement = getData<String>(key: Constant.advertisementKey);

    // Clear all data
    await sharedPreferences.clear();

    // Restore values that should be kept
    if (theme != null) {
      await saveData(key: Constant.kThemeMode, value: theme);
    }
    if (advertisement != null) {
      await saveData(key: Constant.advertisementKey, value: advertisement);
    }

    return false;
  }

  //TODO: remove this and use it direct from the user notifier
  static UserData? get currentUser => UserNotifier.instance.userData;
}
