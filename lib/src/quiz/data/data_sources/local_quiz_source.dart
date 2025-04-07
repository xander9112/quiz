import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class LocalQuizSource {
  Future<Map<String, dynamic>> _loadJsonFromFile(String fileName) async {
    try {
      final String fileContent =
          await rootBundle.loadString('assets/$fileName.json');

      final Map<String, dynamic> jsonData =
          jsonDecode(fileContent) as Map<String, dynamic>;

      return jsonData;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getJsonSchema([
    String name = 'json_schema',
  ]) async {
    final response = await _loadJsonFromFile(name);

    return response;
  }

  Future<Map<String, dynamic>> getUiSchema([
    String name = 'ui_schema',
  ]) async {
    final response = await _loadJsonFromFile(name);

    return response;
  }
}
