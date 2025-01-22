import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://example.com/api'; // Ganti dengan URL server Anda

  Future<List<dynamic>> getLastAddedItems() async {
    final response = await http.get(Uri.parse('$baseUrl/last-added'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
