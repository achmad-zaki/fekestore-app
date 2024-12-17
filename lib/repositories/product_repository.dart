import 'dart:convert';
import 'package:fakestore_app/models/product.dart';
import 'package:fakestore_app/services/api_service.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$apiUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((product) => Product.fromJson(product)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}