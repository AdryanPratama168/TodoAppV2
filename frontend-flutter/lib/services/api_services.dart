import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Ganti dengan URL backend Anda
  static const String baseUrl =
      'http://10.0.2.2:3000'; // untuk emulator Android
  // static const String baseUrl = 'http://192.168.x.x:3000'; // untuk device fisik

  Future<List<dynamic>> getTodos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/todos'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Mengembalikan data dalam bentuk list
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
