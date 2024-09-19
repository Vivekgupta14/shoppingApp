import 'dart:convert'; // For JSON decoding
import 'package:http/http.dart' as http; // For making HTTP requests

class ApiService {
  // Fetch product details from the API
  Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/$productId'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return the product details as a Map
    } else {
      throw Exception('Failed to load product details');
    }
  }
  Future<Map<String, dynamic>> fetchCartDetails(int productId) async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/carts'));

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return the product details as a Map
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
