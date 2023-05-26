import 'dart:convert';

import '../../data/menu_repository.dart';
import '../../data/network/response/table_dto.dart';

class GetTablesUseCase {
  static Future<List<TableDTO>> getTables() async {
    final response = await MenuRepository.getTables();
    List<TableDTO> tables = [];
    final mapTables = json.decode(response)['data'];
    mapTables.forEach((table) => tables.add(TableDTO.fromJson(table)));
    return tables;
  }
}
