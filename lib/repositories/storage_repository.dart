import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static final StorageRepository _instance = StorageRepository._internal();

  factory StorageRepository() {
    return _instance;
  }

  StorageRepository._internal();

  Future<void> saveData(String key, List<Map<String, dynamic>> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = data.map((item) => jsonEncode(item)).toList();
      await prefs.setStringList(key, jsonList);
    } catch (e) {
      print('Erro ao salvar dados: $e');
    }
  }

  Future<List<Map<String, dynamic>>> loadData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(key);

      if (jsonList == null || jsonList.isEmpty) {
        return [];
      }

      return jsonList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Erro ao carregar dados: $e');
      return [];
    }
  }

  Future<void> clearData(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      print('Erro ao limpar dados: $e');
    }
  }
}
