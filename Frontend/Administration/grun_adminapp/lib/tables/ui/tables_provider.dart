// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:flutter/material.dart';

import '../domain/entities/table_dto.dart';
import '../domain/usecase/usecase.dart';

class TableProvider extends ChangeNotifier {
  final GlobalKey<FormState> addTableKey = GlobalKey();
  final GlobalKey<FormState> updateTableKey = GlobalKey();

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool loading) => _isLoading = loading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool loading) => _isLoadingAction = loading;

  final TableDTO _clearTable =
      TableDTO(id: '', tableNumber: -1, isInUse: false);

  TableDTO newTable = TableDTO(id: '', tableNumber: 0, isInUse: false);

  List<TableDTO> tables = [];

  late TableDTO updatedTable;

  int _currentTableIndex = 0;
  int get currentTableIndex => _currentTableIndex;
  set currentTableIndex(int index) => _currentTableIndex = index;

  loadData() async {
    try {
      _isLoading = true;
      notifyListeners();
      tables = await GetTablesUseCase.getTables();
      tables.sort(((a, b) => a.tableNumber.compareTo(b.tableNumber)));
      _isLoading = false;
      notifyListeners();
    } catch (ex) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<int> createTable() async {
    if (addTableKey.currentState!.validate()) {
      try {
        _isLoadingAction = true;
        notifyListeners();
        final response = json
            .decode(await CreateTableUseCase.createTable(newTable: newTable));
        if (response['status'] == 201) {
          newTable.id = response['data']['_id'];
          tables.add(newTable);
          newTable = _clearTable.copyWith();
        }
        _isLoadingAction = false;
        notifyListeners();
        tables.sort(((a, b) => a.tableNumber.compareTo(b.tableNumber)));
        return response['status'];
      } catch (ex) {
        _isLoadingAction = false;
        notifyListeners();
        return 500;
      }
    }
    return 100;
  }

  Future<int> updateTable() async {
    if (updateTableKey.currentState!.validate()) {
      if (!tables[currentTableIndex].equals(updatedTable)) {
        try {
          _isLoadingAction = true;
          notifyListeners();
          final response =
              await UpdateTableUseCase.updateTable(updatedTable: updatedTable);
          if (response == 200) {
            tables[currentTableIndex] = updatedTable;
          }
          tables.sort(((a, b) => a.tableNumber.compareTo(b.tableNumber)));
          _isLoadingAction = false;
          notifyListeners();
          return response;
        } catch (ex) {
          _isLoadingAction = false;
          notifyListeners();
          return 500;
        }
      }
      return 100;
    }
    return 0;
  }

  Future<int> deleteTable(String id) async {
    try {
      _isLoadingAction = true;
      notifyListeners();
      final response = await DeleteTableUseCase.deleteTable(id: id);
      if (response == 200) {
        tables.removeAt(currentTableIndex);
      }
      _isLoadingAction = false;
      notifyListeners();
      return response;
    } catch (ex) {
      _isLoadingAction = false;
      notifyListeners();
      return 500;
    }
  }

  bool checkExistingTables(int number) {
    try {
      tables.firstWhere((element) => element.tableNumber == number);
      return true;
    } catch (ex) {
      return false;
    }
  }
}
