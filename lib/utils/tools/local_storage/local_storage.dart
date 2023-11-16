import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final _instance = LocalStorage._init();

  factory LocalStorage() => _instance;

  static SharedPreferences? _storage;

  LocalStorage._init() {
    _initStorage();
  }

  _initStorage() async {
    _storage ??= await SharedPreferences.getInstance();
  }

  setInt(String? key, int? value) async {
    await _initStorage();
    _storage!.setInt(key!, value!);
  }

  setDouble(String? key, double? value) async {
    await _initStorage();
    _storage!.setDouble(key!, value!);
  }

  setString(String? key, String? value) async {
    await _initStorage();
    _storage!.setString(key!, value!);
  }

  Future<String?> getString(String? key) async {
    await _initStorage();
    return _storage!.getString(key!);
  }

  setStringList(String? key, List<String>? value) async {
    await _initStorage();
    _storage!.setStringList(key!, value!);
  }

  setBool(String? key, bool? value) async {
    await _initStorage();
    _storage!.setBool(key!, value!);
  }

  setObject(String? key, dynamic value) async {
    await _initStorage();
    String jsonStr = json.encode(value);
    await _storage!.setString(key!, jsonStr);
  }

  Future<dynamic> getStorage(String? key) async {
    await _initStorage();
    Object? value = _storage!.get(key!);
    if (value != null) {
      if (value is String && _isJson(value)) {
        return json.decode(value);
      } else {
        return value;
      }
    }
    return null;
  }

  Future<bool> hasKey(String key) async {
    await _initStorage();
    return _storage!.containsKey(key);
  }

  Future<bool> removeStorage(String key) async {
    await _initStorage();
    if (await hasKey(key)) {
      await _storage!.remove(key);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> clear() async {
    await _initStorage();
    _storage!.clear();
    return true;
  }

  Future<Set<String>> getKeys() async {
    await _initStorage();
    return _storage!.getKeys();
  }

  _isJson(dynamic value) {
    try {
      json.decode(value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
