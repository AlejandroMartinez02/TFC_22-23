import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/table_dto.dart';
import 'table_client.dart';

class TableService {
  static Future<String> getTables() async {
    final token = await SecureStorageService.getToken();
    return await TableClient.getTables(token: token);
  }

  static Future<String> createTable({required TableDTO newTable}) async {
    final token = await SecureStorageService.getToken();
    return await TableClient.createTable(token: token, newTable: newTable);
  }

  static Future<String> updateTable({required TableDTO updatedTable}) async {
    final token = await SecureStorageService.getToken();
    return await TableClient.updateTable(
        token: token, updatedTable: updatedTable);
  }

  static Future<String> deleteTable({required String id}) async {
    final token = await SecureStorageService.getToken();
    return await TableClient.deleteTable(token: token, id: id);
  }
}
