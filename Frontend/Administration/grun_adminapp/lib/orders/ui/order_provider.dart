// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../domain/entities/order_dto.dart';
import '../domain/usecase/delete_order_usecase.dart';
import '../domain/usecase/get_orders_usecase.dart';

class OrderProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool isLoadingAction) =>
      _isLoadingAction = isLoadingAction;

  List<OrderDTO> orders = [];

  int _currentOrderIndex = 0;
  int get currentOrderIndex => _currentOrderIndex;
  set currentOrderIndex(int currentIndex) => _currentOrderIndex = currentIndex;

  Future loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      orders = await GetAllOrdersUseCase.getOrders();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> deleteOrder(String id) async {
    try {
      isLoadingAction = true;
      notifyListeners();
      final response = await DeleteOrderUseCase.deleteOrder(id: id);
      if (response == 200) {
        orders.removeAt(currentOrderIndex);
      }
      isLoadingAction = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoadingAction = false;
      notifyListeners();
      return 500;
    }
  }

  double getTotalCost() {
    double totalCost = 0.0;
    for (var order in orders) {
      totalCost += order.totalCost;
    }
    return totalCost;
  }
}
