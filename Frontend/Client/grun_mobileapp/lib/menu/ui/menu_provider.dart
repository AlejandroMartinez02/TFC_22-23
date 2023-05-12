import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../main/domain/entity/entity.dart';

import '../domain/entity/order_dto.dart';
import '../domain/entity/order_line_dto.dart';
import '../domain/usecase/create_order_usecase.dart';
import '../domain/usecase/get_categories_usecase.dart';
import '../domain/usecase/get_products_by_category_usecase.dart';

class MenuProvider extends ChangeNotifier {
  MenuProvider() {
    loadData();
  }

  final ItemScrollController _categoryController = ItemScrollController();

  ItemScrollController get categoryController => _categoryController;

  OrderDTO order = OrderDTO(
      date: DateTime.now().toLocal(),
      totalCost: 0,
      orderLines: [],
      state: 'En espera');

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

  void changeActualPage({int page = -1}) async {
    try {
      if (page != -1) _actualCategory = page;
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

  Map<String, List<ProductDTO>> categoryProducts = {};
  List<CategoryDTO> categories = [];

  Future loadData() async {
    try {
      await loadCategories();
      await loadProducts();
      _isLoading = false;
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

  bool _creatingOrder = true;
  bool get creatingOrder => _creatingOrder;
  set creatingOrder(bool creatingOrder) => _creatingOrder = creatingOrder;

  Future<int> finishOrder() async {
    try {
      _creatingOrder = true;
      notifyListeners();
      final response = await CreateOrderUseCase.createOrder(order: order);
      _creatingOrder = false;
      notifyListeners();
      order = OrderDTO(
          date: DateTime.now().toLocal(),
          totalCost: 0,
          orderLines: [],
          state: 'En espera');
      return response;
    } catch (ex) {
      _creatingOrder = false;
      notifyListeners();
      return 500;
    }
  }
}
