import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:grun_mobileapp/utils/utils.dart' show Constants;

class AuthService extends ChangeNotifier {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> loginUser(String? email, String? pass) async {
    final Map<String, String?> credentials = {'email': email, 'password': pass};

    final url = Uri.http(_baseUrl, '/api/login');

    final response = await http.post(url,
        body: json.encode(credentials),
        headers: {'content-type': 'application/json'});

    return response.body;
  }

  static Future<String> registerUser(Map<String, dynamic> user) async {
    final url = Uri.http(_baseUrl, '/api/register');
    final response = await http.post(
      url,
      body: json.encode(user),
      headers: {'content-type': 'application/json'},
    );

    return response.body;
  }
}
