import 'dart:convert';

import '../../data/worker_repository.dart';

class DeleteWorkerUseCase {
  static Future<int> deleteWorker({required String id}) async {
    final response = await WorkerRepository.deleteWorker(id: id);
    return json.decode(response)['status'];
  }
}
