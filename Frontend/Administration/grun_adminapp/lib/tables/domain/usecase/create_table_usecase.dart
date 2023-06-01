import '../../data/table_repository.dart';
import '../entities/table_dto.dart';

class CreateTableUseCase {
  static Future<String> createTable({required TableDTO newTable}) async {
    return await TableRepository.createTable(newTable: newTable);
  }
}
