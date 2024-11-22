import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthController {
  static const String baseUrl = 'http://10.0.2.2/task2/public';
  
  // Shared Preference Keys
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';
  static const String _usernameKey = 'username';
  static const String _roleKey = 'role';
  static const String _isLoggedInKey = 'is_logged_in';

  // Comprehensive login status check
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString(_tokenKey);
    final isLoggedInFlag = prefs.getBool(_isLoggedInKey);
    
    // Debug logging
    print('Checking Login Status:');
    print('Token: $token');
    print('Is Logged In: $isLoggedInFlag');

    return isLoggedInFlag == true && token != null && token.isNotEmpty;
  }

static Future<void> clearAllAuthData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_tokenKey);
  await prefs.remove(_userIdKey);
  await prefs.remove(_usernameKey);
  await prefs.remove(_roleKey);
  await prefs.remove(_isLoggedInKey);
  print('Authentication data cleared');
}



// AuthController: logout method
static Future<void> logout() async {
  try {
    final prefs = await SharedPreferences.getInstance();

    // Print all current auth data before logout
    print('Pre-Logout Auth Data:');
    await printAuthData();

    // Get the current token
    final token = prefs.getString(_tokenKey);

    // Attempt server-side logout
    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/logoutPage'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
            'X-Requested-With': 'XMLHttpRequest',
          },
        );

        print('Logout Server Response:');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      } catch (e) {
        print('Error during server-side logout: $e');
      }
    }

    // Clear all auth-related preferences
    await clearAllAuthData();

    // Verify data is cleared
    print('Post-Logout Auth Data:');
    await printAuthData();

  } catch (e) {
    print('Logout Exception: $e');
  }
}

static Future<void> printAuthData() async {
  final prefs = await SharedPreferences.getInstance();
  print('Current Auth Data:');
  print('Token: ${prefs.getString(_tokenKey)}');
  print('User ID: ${prefs.getString(_userIdKey)}');
  print('Username: ${prefs.getString(_usernameKey)}');
  print('Role: ${prefs.getString(_roleKey)}');
  print('Is Logged In: ${prefs.getBool(_isLoggedInKey)}');
}


  // Login method with extensive error handling and logging
Future<Map<String, dynamic>> login(UserModel user) async {
  try {
    // Extensive pre-login debugging
    print('Pre-Login Debug:');
    print('Attempting to login with username: ${user.username}');
    
    // Clear previous auth data before new login attempt
    // await clearAllAuthData();

    // Add network connectivity check
    try {
      final connectivityResult = await InternetAddress.lookup('google.com');
      if (connectivityResult.isNotEmpty && 
          connectivityResult[0].rawAddress.isNotEmpty) {
        print('Device has internet connectivity');
      }
    } catch (connectivityError) {
      print('No internet connectivity: $connectivityError');
      return {
        'success': false,
        'message': 'No internet connection',
      };
    }

    print('Preparing to send login request');
    print('Request URL: $baseUrl/loginPage');
    print('Request Body: ${user.toJson()}');

    http.Response response;
    try {
      response = await http.post(
        Uri.parse('$baseUrl/loginPage'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
          'Accept': 'application/json',
          'X-Requested-With': 'XMLHttpRequest',
        },
        body: user.toJson(),
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Connection timed out');
        },
      );
    } on SocketException catch (e) {
      print('Socket Exception: $e');
      return {
        'success': false,
        'message': 'Network error: ${e.message}',
      };
    } on TimeoutException catch (e) {
      print('Timeout Exception: $e');
      return {
        'success': false,
        'message': 'Connection timed out',
      };
    } catch (e) {
      print('Unexpected error before response: $e');
      return {
        'success': false,
        'message': 'Unexpected error: $e',
      };
    }

    print('Login Response:');
    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    // Add safeguard for empty or invalid response
    if (response.body.isEmpty) {
      print('Received empty response body');
      return {
        'success': false,
        'message': 'Received empty response from server',
      };
    }

    // Robust JSON parsing with error handling
    late Map<String, dynamic> data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      print('JSON Parsing Error: $e');
      print('Problematic JSON: ${response.body}');
      return {
        'success': false,
        'message': 'Failed to parse server response',
      };
    }

    if (response.statusCode == 200 && data['success'] == true) {
      final prefs = await SharedPreferences.getInstance();

      // Robust preference saving
      await prefs.setString(_tokenKey, data['token'] ?? '');
      await prefs.setString(_userIdKey, data['user']['id']?.toString() ?? '');
      await prefs.setString(_usernameKey, data['user']['username'] ?? '');
      await prefs.setString(_roleKey, data['user']['role'] ?? '');
      await prefs.setBool(_isLoggedInKey, true);
      
      print('Login successful, preferences updated.');

      return {
        'success': true,
        'message': data['message'] ?? 'Login successful',
        'data': data
      };
    } else {
      print('Login Failed:');
      print('Message: ${data['message'] ?? 'Unknown error'}');
      
      return {
        'success': false,
        'message': data['message'] ?? 'Server error: ${response.statusCode}',
      };
    }
  } catch (e, stackTrace) {
    print('Catastrophic Login Exception:');
    print('Error: $e');
    print('Stack Trace: $stackTrace');
    
    return {
      'success': false,
      'message': 'Unhandled error: $e',
    };
  }
}
}