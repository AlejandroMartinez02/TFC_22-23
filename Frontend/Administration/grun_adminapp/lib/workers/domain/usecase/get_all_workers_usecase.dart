import 'dart:convert';

import '../../data/worker_repository.dart';
import '../entities/worker_dto.dart';

class GetAllWorkersUseCase {
  static Future<List<WorkerDTO>> getAllWorkers() async {
    final response = await WorkerRepository.getAllWorkers();
    List<WorkerDTO> workers = [];
    final workerMap = json.decode(response)['data'];
    workerMap.forEach((worker) => workers.add(WorkerDTO.fromJson(worker)));
    return workers;
  }
}
