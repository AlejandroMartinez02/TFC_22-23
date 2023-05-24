import '../../data/worker_repository.dart';
import '../entities/worker_dto.dart';

class AddWorkerUseCase {
  static Future<String> addWorker({required WorkerDTO newWorker}) async {
    return await WorkerRepository.addWorker(newWorker: newWorker);
  }
}
