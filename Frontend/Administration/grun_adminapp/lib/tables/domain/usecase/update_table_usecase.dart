import 'dart:convert';

import '../../data/table_repository.dart';
import '../entities/table_dto.dart';

class UpdateTableUseCase {
  static Future<int> updateTable({required TableDTO updatedTable}) async {
    final response =
        await TableRepository.updateTable(updatedTable: updatedTable);
    return json.decode(response)['status'];
  }
}
