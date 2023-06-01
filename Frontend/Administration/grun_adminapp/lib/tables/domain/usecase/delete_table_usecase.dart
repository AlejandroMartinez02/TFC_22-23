import 'dart:convert';

import '../../data/table_repository.dart';

class DeleteTableUseCase {
  static Future<int> deleteTable({required String id}) async {
    final response = await TableRepository.deleteTable(id: id);
    return json.decode(response)['status'];
  }
}
