import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/api_constants.dart';
class ApiConstants {
  static const String baseUrl = 'https://lms-app-2025-5998bd74d24a.herokuapp.com';

  static const String register = '$baseUrl/register/';
  static const String login = '$baseUrl/login/';
  static const String logout = '$baseUrl/logout/';
  static const String resendVerification = '$baseUrl/resend-verification';
}

class ApiService {
  // Register a new user
  static Future<Map<String, dynamic>> register({
    required String userId,
    required String email,
    required String name,
    required String role,
    required String password,
    required String password2,
    required String phone,
    required String city,
    required String province,
    required String gender,
    required String photoDocument, // this will be sent in header
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.register),
        headers: {
          'Content-Type': 'application/json',
          'photo_document': photoDocument, // Custom header
        },
        body: jsonEncode({
          "user_id": userId,
          "email": email,
          "name": name,
          "role": role,
          "password": password,
          "password2": password2,
          "phone": phone,
          "city": city,
          "province": province,
          "gender": gender,
        }),
      );

      final data = jsonDecode(response.body);
      return {
        'status': response.statusCode,
        'data': data,
      };
    } catch (e) {
      return {
        'status': 500,
        'error': e.toString(),
      };
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);
      return {
        'status': response.statusCode,
        'data': data,
      };
    } catch (e) {
      return {
        'status': 500,
        'error': e.toString(),
      };
    }
  }
}
