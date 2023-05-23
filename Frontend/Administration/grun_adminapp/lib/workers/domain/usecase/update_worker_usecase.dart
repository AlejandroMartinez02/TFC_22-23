import 'dart:convert';

import '../../data/worker_repository.dart';
import '../entities/worker_dto.dart';

class UpdateWorkerUseCase {
  static Future<int> updateWorker({required WorkerDTO updatedWorker}) async {
    final response =
        await WorkerRepository.updateWorker(updatedWorker: updatedWorker);
    return json.decode(response)['status'];
  }
}
