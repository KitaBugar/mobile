import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Impor dotenv
import 'package:shared_preferences/shared_preferences.dart'; // Impor SharedPreferences

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL'] ??
      'http://localhost:8080'; // Ambil BASE_URL dari .env

  // Metode untuk mengambil token dari SharedPreferences
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token'); // Ganti dengan kunci yang sesuai
  }

  Future<List<dynamic>> getGyms() async {
    final String? token = await _getToken(); // Ambil token

    // Buat header dengan token jika ada
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // Menyertakan token
    };

    try {
      final response = await http.get(Uri.parse('$baseUrl/api/gym'),
          headers: headers); // Gunakan baseUrl

      print('Response status: ${response.statusCode}'); // Log status kode
      print('Response body: ${response.body}'); // Log isi respons

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data'); // Log data yang diterima
        return data['items']; // Mengembalikan daftar gym
      } else {
        throw Exception(
            'Failed to load gyms: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e'); // Log kesalahan
      throw Exception('Failed to load gyms: $e');
    }
  }

  Future<List<dynamic>> getMembers() async {
    final String? token = await _getToken(); // Ambil token

    // Buat header dengan token jika ada
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // Menyertakan token
    };

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/membership'),
        headers: headers,
      ); // Gunakan baseUrl

      print('Response status: ${response.statusCode}'); // Log status kode
      print('Response body: ${response.body}'); // Log isi respons

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Data received: $data'); // Log data yang diterima
        return data['items'].isEmpty
            ? []
            : data['items']; // Mengembalikan daftar gym
      } else {
        throw Exception(
            'Failed to load gyms: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error occurred: $e'); // Log kesalahan
      throw Exception('Failed to load gyms: $e');
    }
  }

  // Metode untuk mengambil opsi keanggotaan berdasarkan gymId
  Future<Map<String, dynamic>> getMembershipOptions(int gymId) async {
    final String? token = await _getToken(); // Ambil token

    // Buat header dengan token jika ada
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // Menyertakan token
    };

    final response = await http.get(Uri.parse('$baseUrl/api/gym/$gymId'),
        headers: headers); // Sertakan headers

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Mengembalikan data yang diterima
    } else {
      throw Exception(
          'Failed to load membership options: ${response.statusCode} ${response.body}');
    }
  }

  // Metode untuk mengambil detail gym berdasarkan gymId
  Future<Map<String, dynamic>> getGymDetails(int gymId) async {
    final String? token = await _getToken(); // Ambil token

    // Buat header dengan token jika ada
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token', // Menyertakan token
    };

    final response = await http.get(Uri.parse('$baseUrl/api/gym/$gymId'),
        headers: headers); // Sertakan headers

    print('Request URL: $baseUrl/api/gym/$gymId'); // Log URL yang diminta
    print('Response status: ${response.statusCode}'); // Log status kode

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Mengembalikan data yang diterima
    } else {
      print('Response body: ${response.body}'); // Log isi respons jika gagal
      throw Exception(
          'Failed to load gym details: ${response.statusCode} ${response.body}');
    }
  }

  // Metode untuk melakukan POST ke /api/membership
  Future<bool> subscribeMembership(
    String? path,
    var paymentMethodId,
    var gymId,
    var membershipOptionId,
  ) async {
    final String? token = await _getToken();

    final sender =
        http.MultipartRequest("POST", Uri.parse('$baseUrl/api/membership'));

    sender.fields["start_date"] = DateTime.now().toIso8601String();
    sender.fields["method_payment_id"] = paymentMethodId;
    sender.fields["gym_id"] = gymId;
    sender.fields["membership_option_id"] = membershipOptionId;
    sender.files
        .add(await http.MultipartFile.fromPath("photo_transaction", path!));
    sender.headers["Content-Type"] = "multipart/form-data";
    sender.headers["Authorization"] = 'Bearer $token';
    print("REQUEST => ${sender.fields}");

    var response = await sender.send();

    if (response.statusCode == 200) {
      print("RESPONSE => ${response.request}");
      return true;
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to subscribe membership: ${response.statusCode}');
    }

    return false;
  }

  Future<void> uploadFile(String filePath) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Failed to upload file');
    }
  }
}
