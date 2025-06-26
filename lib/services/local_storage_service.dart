import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveUserData({
    required String uid,
    required String email,
    required String name,
  }) async {
    await _prefs?.setString('uid', uid);
    await _prefs?.setString('email', email);
    await _prefs?.setString('name', name);
  }

  String? get uid => _prefs?.getString('uid');
  String? get email => _prefs?.getString('email');
  String? get name => _prefs?.getString('name');
  bool get isLoggedIn => uid != null;

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
