import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthApi {
  final url = 'https://fakestoreapi.com';
  int? _userId;
  int get userId {
    return _userId!;
  }

  Future<int> auth(String name, String password, bool isLogin) async {
    try {
      final response = await http.post(
        Uri.parse('$url/${isLogin ? 'auth/login' : 'users'}'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: json.encode({
          'username': name,
          'password': password,
        }),
      );

      if (response.statusCode != 200) {
        throw ErrorDescription(response.body);
      } else {
        // Extract relevant data from the API response and Store it in Shared Preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        _userId = 0;
        final responseData = json.decode(response.body);
        if (!isLogin) {
          _userId = responseData['id'];
          final userData = json.encode({
            'id': _userId,
            'userName': name,
          });
          prefs.setString('userData', userData);
        } else {
          final userData = json.encode({
            'id': _userId,
            'userName': name,
          });
          prefs.setString('userData', userData);
        }
        return _userId!;
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return null;
    }
    final extractUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _userId = extractUserData['id'];

    return extractUserData;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
