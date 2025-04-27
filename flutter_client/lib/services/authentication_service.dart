import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  //Base URL
  final String baseUrl = "http://192.168.8.150:5000/api/auth";

  //Register a New User
  Future<Map<String, dynamic>> register({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userName": userName,
          "email": email,
          "password": password,
        }),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to Register New User!");
      }
    } catch (error) {
      throw Exception("An error occurred during registration: $error");
    }
  }

  //Login User
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        //Store the Token in Shared Preferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("token", result["token"]);
        return result;
      } else {
        throw Exception("Failed to Login!");
      }
    } catch (error) {
      throw Exception("An error occurred during login: $error");
    }
  }

  //Get Stored Token
  Future<String?> getToken() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      return preferences.getString("token");
    } catch (error) {
      throw Exception("An error occurred while retrieving the token: $error");
    }
  }

  //Logout
  Future<void> logout() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove("token");
      debugPrint("Logout Successfully!");
    } catch (error) {
      throw Exception("An error occurred during logout: $error");
    }
  }
}
