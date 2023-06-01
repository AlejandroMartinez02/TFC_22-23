import '../domain/entities/table_dto.dart';
import 'network/table_service.dart';

class TableRepository {
  static Future<String> getTables() async {
    return await TableService.getTables();
  }

  static Future<String> createTable({required TableDTO newTable}) async {
    return await TableService.createTable(newTable: newTable);
  }

  static Future<String> updateTable({required TableDTO updatedTable}) async {
    return await TableService.updateTable(updatedTable: updatedTable);
  }

  static Future<String> deleteTable({required String id}) async {
    return await TableService.deleteTable(id: id);
  }
}
