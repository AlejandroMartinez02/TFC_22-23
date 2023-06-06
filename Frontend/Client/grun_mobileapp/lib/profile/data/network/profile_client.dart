import 'dart:convert';

import 'package:grun_mobileapp/profile/data/network/response/user_dto.dart';
import 'package:http/http.dart' as http;

import '../../../utils/constants.dart';

class ProfileClient {
  static String _baseUrl = Constants.httpAPI;

  static Future<String> getUser({required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/users/');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> changePassword(
      {required String oldPassword,
      required String newPassword,
      required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/changepassword');
    final response = await http.patch(uri,
        body: {"oldPassword": oldPassword, "newPassword": newPassword},
        headers: {"Authorization": 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateUser(
      {required UserDTO user, required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/users/');
    final response = await http.patch(uri,
        body: user.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> getOrders({required String token}) async {
    final uri = Uri.https(_baseUrl, '/api/orders/all');
    final response =
        await http.get(uri, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
