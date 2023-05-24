import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/worker_dto.dart';
import 'worker_client.dart';

class WorkerService {
  static Future<String> getAllWorkers() async {
    final token = await SecureStorageService.getToken();
    return await WorkerClient.getAllWorkers(token: token);
  }

  static Future<String> addWorker({required WorkerDTO newWorker}) async {
    final token = await SecureStorageService.getToken();
    return await WorkerClient.addWorker(newWorker: newWorker, token: token);
  }

  static Future<String> updateWorker({required WorkerDTO updatedWorker}) async {
    final token = await SecureStorageService.getToken();
    return await WorkerClient.updateWorker(
        updatedWorker: updatedWorker, token: token);
  }

  static Future<String> deleteWorker({required String id}) async {
    final token = await SecureStorageService.getToken();
    return await WorkerClient.deleteWorker(id: id, token: token);
  }
}
