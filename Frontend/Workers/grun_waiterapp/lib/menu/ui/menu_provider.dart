// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/constants.dart';
import '../data/network/response/category_dto.dart';
import '../data/network/response/products_dto.dart';
import '../data/network/response/table_dto.dart';
import '../data/network/response/worker_dto.dart';
import '../domain/entity/order_dto.dart';
import '../domain/entity/order_line_dto.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../domain/usecase/usecase.dart';

class MenuProvider extends ChangeNotifier {
  MenuProvider() {
    loadData();
    final socket = IO.io(Constants.httpSocket, {
      'autoConnect': true,
      'transports': ['websocket']
    });

    socket.on('UpdateTables', (data) {
      List<TableDTO> tables = [];
      data.forEach((table) => tables.add(TableDTO.fromJson(table)));
      changeTables(tables);
    });
  }

  late WorkerDTO actualWorker;

  final ItemScrollController _categoryController = ItemScrollController();

  ItemScrollController get categoryController => _categoryController;

  OrderDTO order = OrderDTO(
      date: DateTime.now().toLocal(),
      totalCost: 0,
      orderLines: [],
      state: 'En cocina');

  late OrderLineDTO _newOrderLine;
  OrderLineDTO get newOrderLine => _newOrderLine;
  set newOrderLine(OrderLineDTO orderline) => _newOrderLine = orderline;

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool loading) {
    _isLoading = loading;
  }

  int _actualCategory = 0;

  int get actualCategory => _actualCategory;

  Map<String, List<ProductDTO>> categoryProducts = {};
  List<CategoryDTO> categories = [];
  List<TableDTO> tables = [];

  bool _creatingOrder = true;
  bool get creatingOrder => _creatingOrder;
  set creatingOrder(bool creatingOrder) => _creatingOrder = creatingOrder;

  int _tableNumberSelected = 0;
  int get tableNumberSelected => _tableNumberSelected;
  set tableNumberSelected(int tableNumber) =>
      _tableNumberSelected = tableNumber;

  final TableDTO _noTable = TableDTO(id: '', tableNumber: -1, isInUse: false);

  void changeSelectedTable(int table) {
    _tableNumberSelected = table;
    notifyListeners();
  }

  void changeActualPage({required int page}) async {
    try {
      _actualCategory = page;
      _isLoading = true;
      notifyListeners();
      await loadProducts();
      _isLoading = false;
      notifyListeners();
    } catch (ex) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future loadData() async {
    try {
      await loadCategories();
      await loadProducts();
      await loadTables();
      await loadWorker();
      _isLoading = false;
      notifyListeners();
    } catch (ex) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future loadProducts() async {
    if (categoryProducts[categories[_actualCategory].name]!.isNotEmpty) return;

    categoryProducts[categories[_actualCategory].name] =
        await GetProductsByCategoryUseCase.getProductsByCategory(
            category: categories[_actualCategory].name);
  }

  loadCategories() async {
    try {
      categories = await GetCategoriesUseCase.getCategories();
      for (var element in categories) {
        categoryProducts[element.name] = [];
      }
    } catch (ex) {
      categories = [];
    }
  }

  void addToCart({required ProductDTO product, int count = 1}) {
    try {
      final orderLine =
          order.orderLines.firstWhere((element) => element.product == product);
      orderLine.count += count;
      orderLine.cost += count * product.cost;
      order.totalCost += count * product.cost;
    } catch (ex) {
      final cost = product.cost * count;
      order.orderLines
          .add(OrderLineDTO(product: product, count: count, cost: cost));
      order.totalCost += cost;
    }
  }

  void removeProductCount({required OrderLineDTO orderLine}) {
    if (orderLine.count - 1 == 0) {
      order.orderLines.removeWhere((element) => element == orderLine);
    } else {
      orderLine.count--;
      orderLine.cost -= orderLine.product.cost;
    }
    order.totalCost -= orderLine.product.cost;
    notifyListeners();
  }

  void addProductCount({required OrderLineDTO orderLine}) {
    orderLine.count++;
    orderLine.cost += orderLine.product.cost;
    order.totalCost += orderLine.product.cost;
    notifyListeners();
  }

  void addOrderLine() {
    addToCart(product: newOrderLine.product, count: newOrderLine.count);
  }

  void removeCountNewOrderLine() {
    if (newOrderLine.count - 1 != 0) {
      newOrderLine.count--;
      newOrderLine.cost -= newOrderLine.product.cost;
      notifyListeners();
    }
  }

  void addProductCountNewOrderLine() {
    newOrderLine.count++;
    newOrderLine.cost += newOrderLine.product.cost;
    notifyListeners();
  }

  Future<int> finishOrder() async {
    try {
      _creatingOrder = true;
      notifyListeners();
      final response = await CreateOrderUseCase.createOrder(order: order);
      _creatingOrder = false;
      notifyListeners();
      return response;
    } catch (ex) {
      _creatingOrder = false;
      notifyListeners();
      return 500;
    }
  }

  loadTables() async {
    tables = await GetTablesUseCase.getTables();
    tables.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
    tables.add(_noTable);
  }

  void changeTables(List<TableDTO> tables) {
    tables.add(_noTable);
    this.tables = tables;

    if (this.tables[tableNumberSelected].isInUse) {
      tableNumberSelected = -1;
    }
    notifyListeners();
  }

  void restartOrder() {
    order = OrderDTO(
        date: DateTime.now().toLocal(),
        totalCost: 0,
        orderLines: [],
        state: 'En cocina',
        worker: actualWorker);
    notifyListeners();
  }

  Future loadWorker() async {
    actualWorker = await GetWorkerUseCase.getWorker();
    order.worker = actualWorker;
  }
}
