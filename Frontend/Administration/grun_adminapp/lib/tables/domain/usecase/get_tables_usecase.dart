import 'dart:convert';

import '../../data/table_repository.dart';
import '../entities/table_dto.dart';

class GetTablesUseCase {
  static Future<List<TableDTO>> getTables() async {
    final response = await TableRepository.getTables();
    final List<TableDTO> tables = [];
    final mapTables = json.decode(response)['data'];
    mapTables.forEach((table) => tables.add(TableDTO.fromJson(table)));
    return tables;
  }
}
