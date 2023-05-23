import '../../../utils/constants.dart';
import '../../domain/entities/worker_dto.dart';
import 'package:http/http.dart' as http;

class WorkerClient {
  static const _baseUrl = Constants.httpAPI;

  static Future<String> getAllWorkers({required String token}) async {
    final url = Uri.http(_baseUrl, '/api/workers/all');
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> addWorker(
      {required WorkerDTO newWorker, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/workers');
    final response = await http.post(url,
        body: newWorker.toJson(), headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> updateWorker(
      {required WorkerDTO updatedWorker, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/workers');
    final response = await http.patch(url,
        body: updatedWorker.toJson(),
        headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }

  static Future<String> deleteWorker(
      {required String id, required String token}) async {
    final url = Uri.http(_baseUrl, '/api/workers');
    final response = await http.delete(url,
        body: {"_id": id}, headers: {'Authorization': 'Bearer $token'});
    return response.body;
  }
}
