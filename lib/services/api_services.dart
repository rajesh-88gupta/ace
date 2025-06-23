// api_services.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ace/utils/api_constants.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

class ApiService {
  // --- register and login methods remain the same ---
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
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print('Register Response Status: ${response.statusCode}');
        print('Register Response Body: ${response.body}');
      }

      try {
        final data = jsonDecode(response.body);
        return {
          'status': response.statusCode,
          'data': data,
        };
      } catch (e) {
        if (kDebugMode) {
          print('Register JSON Decode Error: $e');
          print('Raw Register Response Body for JSON error: ${response.body}');
        }
        return {
          'status': response.statusCode,
          'error': 'Server returned an invalid format. Please try again later.',
        };
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Register Network Error (SocketException): $e');
      }
      return {
        'status': 503,
        'error': 'No internet connection or server is unreachable. Please check your network.',
      };
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('Register HTTP Client Error: $e');
      }
      return {
        'status': 400,
        'error': 'Client error during request: ${e.message}',
      };
    } catch (e) {
      if (kDebugMode) {
        print('Register Unknown Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unknown error occurred during registration: $e',
      };
    }
  }

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
        print('Login Unknown Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unknown error occurred during login: $e',
      };
    }
  }

  // Method for fetching user profile
  static Future<Map<String, dynamic>> getProfile(String token) async {
    try {
      final response = await http.get(
        // FIXED: Changed to use 'getProfile' which is defined in ApiConstants.
        Uri.parse(ApiConstants.getProfile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (kDebugMode) {
        print('Get Profile Response Status: ${response.statusCode}');
        print('Get Profile Response Body: ${response.body}');
      }

      try {
        final data = jsonDecode(response.body);
        return {
          'status': response.statusCode,
          'data': data,
        };
      } catch (e) {
        if (kDebugMode) {
          print('Get Profile JSON Decode Error: $e');
          print('Raw Get Profile Response Body for JSON error: ${response.body}');
        }
        return {
          'status': response.statusCode,
          'error': 'Server returned an invalid format. Please try again later.',
        };
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Get Profile Network Error (SocketException): $e');
      }
      return {
        'status': 503,
        'error': 'No internet connection or server is unreachable. Please check your network.',
      };
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('Get Profile HTTP Client Error: $e');
      }
      return {
        'status': 400,
        'error': 'Client error during request: ${e.message}',
      };
    } catch (e) {
      if (kDebugMode) {
        print('Get Profile Unknown Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unknown error occurred while fetching profile: $e',
      };
    }
  }

  // Method for updating user profile
  static Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String email,
    required String phone,
    required String dob, // Assuming DOB is sent as a string (e.g., YYYY-MM-dd)
  }) async {
    try {
      final response = await http.put( // Or http.patch if your API uses PATCH for partial updates
        // FIXED: Changed to use 'getProfile' which is defined in ApiConstants.
        Uri.parse(ApiConstants.getProfile),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone': phone,
          'dob': dob,
          // Add other fields here if your update API accepts them
        }),
      );

      if (kDebugMode) {
        print('Update Profile Response Status: ${response.statusCode}');
        print('Update Profile Response Body: ${response.body}');
      }

      try {
        final data = jsonDecode(response.body);
        return {
          'status': response.statusCode,
          'data': data,
        };
      } catch (e) {
        if (kDebugMode) {
          print('Update Profile JSON Decode Error: $e');
          print('Raw Update Profile Response Body for JSON error: ${response.body}');
        }
        return {
          'status': response.statusCode,
          'error': 'Server returned an invalid format. Please try again later.',
        };
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Update Profile Network Error (SocketException): $e');
      }
      return {
        'status': 503,
        'error': 'No internet connection or server is unreachable. Please check your network.',
      };
    } on http.ClientException catch (e) {
      if (kDebugMode) {
        print('Update Profile HTTP Client Error: $e');
      }
      return {
        'status': 400,
        'error': 'Client error during request: ${e.message}',
      };
    } catch (e) {
      if (kDebugMode) {
        print('Update Profile Unknown Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unknown error occurred while updating profile: $e',
      };
    }
  }

  // Method for logging out
  static Future<Map<String, dynamic>> logout(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.logout),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'refresh': refreshToken,
        }),
      );

      if (kDebugMode) {
        print('Logout Response Status: ${response.statusCode}');
        print('Logout Response Body: ${response.body}');
      }

      try {
        final data = jsonDecode(response.body);
        return {
          'status': response.statusCode,
          'data': data,
        };
      } catch (e) {
        if (kDebugMode) {
          print('Logout JSON Decode Error: $e');
          print('Raw Logout Response Body for JSON error: ${response.body}');
        }
        return {
          'status': response.statusCode,
          'error': 'Server returned an invalid format. Please try again later.',
        };
      }
    } on SocketException catch (e) {
      if (kDebugMode) {
        print('Logout Network Error (SocketException): $e');
      }
      return {
        'status': 503,
        'error': 'No internet connection or server is unreachable. Please check your network.',
      };
    } catch (e) {
      if (kDebugMode) {
        print('Logout Unknown Error: $e');
      }
      return {
        'status': 500,
        'error': 'An unknown error occurred during logout: $e',
      };
    }
  }
}