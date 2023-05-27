import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../domain/entities/order_dto.dart';
import '../domain/usecase/get_orders_usecase.dart';
import '../domain/usecase/update_orders_usecase.dart';

class OrdersProvider extends ChangeNotifier {
  late IO.Socket _socket;
  IO.Socket get socket => _socket;

  OrdersProvider() {
    config();
    loadData();
    socket.on('NewOrder', (data) {
      addOrder(OrderDTO.fromJson(data));
    });
  }

  void config() {
    _socket = IO.io('http://192.168.1.105:3000', {
      'autoConnect': true,
      'transports': ['websocket']
    });
  }

  List<OrderDTO> orders = [];

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool loading) => _isLoading = loading;

  loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      orders = await GetOrdersUseCase.getOrders();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> updateOrder(OrderDTO order) async {
    try {
      isLoading = true;
      notifyListeners();
      if (order.table != null) {
        order.table!.isInUse = false;
      }
      order.state = 'Finalizado';
      final response =
          await UpdateOrderUseCase.updateOrder(updatedOrder: order);
      if (response == 200) {
        orders.removeWhere((element) => element.id == order.id);
      }
      isLoading = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoading = false;
      notifyListeners();
      return 500;
    }
  }

  void addOrder(OrderDTO order) {
    final orderIndex = orders.indexWhere((element) => element.id == order.id);
    if (orderIndex == -1) {
      orders.add(order);
      notifyListeners();
    }
  }

  void changeIsDone(OrderLine orderLine) {
    orderLine.isDone = !orderLine.isDone;
    notifyListeners();
  }
}
