import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ace/utils/api_constants.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

class ApiService {
  // Register a new user with file upload
  // static Future<Map<String, dynamic>> register({
  //     required String name,
  //     required String email,
  //     required String password,
  //     required String role,
  //     File? photoDocument,
  //     required String password2,
  //     required String userId,
  //     required String phone,
  //     required String city,
  //     required String province,
  //     required String gender,
  //   }) async {
  //     try {
  //       var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.register));
  //
  //       // Attach file if available
  //       if (photoDocument != null) {
  //         request.files.add(await http.MultipartFile.fromPath(
  //           'photo_document',
  //           photoDocument.path,
  //         ));
  //       }
  //
  //       request.fields.addAll({
  //         "user_id": userId,
  //         "email": email,
  //         "name": name,
  //         "role": role.toLowerCase(),
  //         "password": password,
  //         "password2": password2,
  //         "phone": phone,
  //         "city": city,
  //         "province": province,
  //         "gender": gender.toLowerCase(),
  //       });
  //
  //       final streamedResponse = await request.send();
  //       final responseBody = await streamedResponse.stream.bytesToString();
  //       final response = http.Response(
  //         responseBody,
  //         streamedResponse.statusCode,
  //         headers: streamedResponse.headers,
  //       );
  //
  //       if (kDebugMode) {
  //         print("Status Code: ${response.statusCode}");
  //         print("Response Body: ${response.body}");
  //       }
  //
  //       final data = jsonDecode(response.body);
  //
  //       return {
  //         'status': response.statusCode,
  //         'data': data,
  //       };
  //     } catch (e) {
  //       return {
  //         'status': 500,
  //         'error': 'Unexpected error occurred: $e',
  //       };
  //     }
  //   }
  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
    File? photoDocument,
    required String password2,
    required String userId,
    required String phone,
    required String city,
    required String province,
    required String gender,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(ApiConstants.register));

      // Attach file if available
      if (photoDocument != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'photo_document',
          photoDocument.path,
        ));
      }

      request.fields.addAll({
        "user_id": userId,
        "email": email,
        "name": name,
        "role": role.toLowerCase(),
        "password": password,
        "password2": password2,
        "phone": phone,
        "city": city,
        "province": province,
        "gender": gender.toLowerCase(),
      });

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();
      final response = http.Response(
        responseBody,
        streamedResponse.statusCode,
        headers: streamedResponse.headers,
      );

      if (kDebugMode) {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
      }

      final data = jsonDecode(response.body);

      return {
        'status': response.statusCode,
        'data': data,
      };
    } catch (e) {
      return {
        'status': 500,
        'error': 'Unexpected error occurred: $e',
      };
    }
  }

  // Login user
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (kDebugMode) {
        print('Login API call started...');
        print('Login URL: ${ApiConstants.login}');
        print('Login Payload: ${jsonEncode({'email': email, 'password': '***'})}'); // Mask password
      }

      final response = await http.post(
        Uri.parse(ApiConstants.login),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (kDebugMode) {
        print('Login Response Status: ${response.statusCode}');
        print('Login Response Headers: ${response.headers}');
        print('Login Response Body: ${response.body}');
      }

      // Gracefully handle JSON parsing
      try {
        final data = jsonDecode(response.body);
        return {
          'status': response.statusCode,
          'data': data,
        };
      } catch (e) {
        // Return an error if the response is not valid JSON (e.g., HTML error page)
        if (kDebugMode) {
          print('Login JSON Decode Error: $e');
          print('Raw Login Response Body for JSON error: ${response.body}');
        }
        return {
          'status': response.statusCode,
          'error': 'Server returned an invalid format. Please try again later.',
        };
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Login Network Error (SocketException): $e');
      }
      return {
        'status': 503,
        'error': 'No internet connection or server is unreachable. Please check your network.',
      };
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('Login HTTP Client Error: $e');
      }
      return {
        'status': 400,
        'error': 'Client error during request: ${e.message}',
      };
    } catch (e) {
      if (kDebugMode) {
        print('Login Unexpected Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unexpected error occurred: ${e.toString()}',
      };
    }
  }
}