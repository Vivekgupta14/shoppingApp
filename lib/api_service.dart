import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests

class ApiService {
  final String baseUrl = 'https://fakestoreapi.com';
  // Fetch product details from the API
  Future<List<dynamic>> fetchProducts() async {
      final response = await http.get(Uri.parse('$baseUrl/products'));
      if (response.statusCode == 200) {
        // Return the list of products
        return json.decode(response.body) as List<dynamic>;
      } else {
        throw Exception('Failed to load products. Status Code: ${response.statusCode}');
      }

  }

  Future<List<dynamic>> fetchCategory() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic> ; // Return the product details as a Map
    } else {
      throw Exception('Failed to load category details');
    }
  }

  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return the product details as a Map
    } else {
      throw Exception('Failed to load product details');
    }
  }

}
