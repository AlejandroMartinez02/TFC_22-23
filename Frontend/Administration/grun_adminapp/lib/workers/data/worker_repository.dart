import '../domain/entities/worker_dto.dart';
import 'network/worker_service.dart';

class WorkerRepository {
  static Future<String> getAllWorkers() async {
    return await WorkerService.getAllWorkers();
  }

  static Future<String> addWorker({required WorkerDTO newWorker}) async {
    return await WorkerService.addWorker(newWorker: newWorker);
  }

  static Future<String> updateWorker({required WorkerDTO updatedWorker}) async {
    return await WorkerService.updateWorker(updatedWorker: updatedWorker);
  }

  static Future<String> deleteWorker({required String id}) async {
    return await WorkerService.deleteWorker(id: id);
  }
}
