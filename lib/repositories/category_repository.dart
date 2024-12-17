import 'dart:convert';
import 'package:fakestore_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$apiUrl/products/categories'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((category) => category.toString()).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
