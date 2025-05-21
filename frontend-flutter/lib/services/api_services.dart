import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_sqflite_getx/models/task.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:3000'; // For Android Emulator
  // Use 'http://localhost:3000' for iOS or web testing

  // Authentication
  Future<Map<String, dynamic>?> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data'];
        }
      }
      return null;
    } catch (e) {
      print('Registration error: $e');
      return null;
    }
  }

  // Tasks
  Future<List<Task>> fetchTasks() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/tasks'));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return (data['data'] as List)
              .map((taskJson) => Task.fromMap(taskJson))
              .toList();
        }
      }
      return [];
    } catch (e) {
      print('Fetch tasks error: $e');
      return [];
    }
  }

  Future<int> createTask(Map<String, dynamic> taskData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return data['data']['id'];
        }
      }
      return 0;
    } catch (e) {
      print('Create task error: $e');
      return 0;
    }
  }

  Future<int> updateTask(int id, Map<String, dynamic> taskData) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/tasks/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return 1;
        }
      }
      return 0;
    } catch (e) {
      print('Update task error: $e');
      return 0;
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          return 1;
        }
      }
      return 0;
    } catch (e) {
      print('Delete task error: $e');
      return 0;
    }
  }
}