import 'dart:convert';

import '../../data/menu_repository.dart';
import '../../data/network/response/worker_dto.dart';

class GetWorkerUseCase {
  static Future<WorkerDTO> getWorker() async {
    final response = await MenuRepository.getWorker();
    final worker = WorkerDTO.fromJson(json.decode(response)['data']);
    return worker;
  }
}
