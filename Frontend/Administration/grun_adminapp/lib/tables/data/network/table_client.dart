import '../../../utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/table_dto.dart';

class TableClient {
  static final _url = Uri.http(Constants.httpAPI, '/api/tables/');

  static Future<String> getTables({required String token}) async {
    final response =
        await http.get(_url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> createTable(
      {required String token, required TableDTO newTable}) async {
    final response = await http.post(_url,
        body: newTable.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateTable(
      {required String token, required TableDTO updatedTable}) async {
    final response = await http.patch(_url,
        body: updatedTable.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteTable(
      {required String token, required String id}) async {
    final response = await http.delete(_url,
        body: {"_id": id}, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
