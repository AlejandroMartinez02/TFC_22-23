import 'package:flutter/material.dart';

import '../domain/entities/product_graphics_dto.dart';
import '../domain/usecase/get_best_selling_usecase.dart';
import '../domain/usecase/get_less_sold_usecase.dart';

class GraphicsProvider extends ChangeNotifier {
  GraphicsProvider() {
    numProducts['10'] = [];
    numProducts['50'] = [];
    numProducts['100'] = [];
    numProducts['-10'] = [];
    numProducts['-50'] = [];
    numProducts['-100'] = [];
  }

  bool isBestSelected = true;

  int currentNumOrders = 10;
  Map<String, List<ProductGraphicsDTO>> numProducts = {};

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool loading) => _isLoading = loading;

  changeCurrentNumOrders(int number) async {
    var formatNumber = isBestSelected ? number.abs() : -number;
    notifyListeners();
    try {
      if (currentNumOrders != formatNumber) {
        currentNumOrders = formatNumber;
        notifyListeners();
        if (isBestSelected) {
          await loadBestData();
        } else {
          await loadLessData();
        }
        notifyListeners();
      }
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  loadBestData() async {
    if (numProducts[currentNumOrders.toString()]?.isNotEmpty ?? false) {
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    numProducts[currentNumOrders.toString()] =
        await GetBestSellingUseCase.getBestSelling(
            numOrders: currentNumOrders.abs());
    isLoading = false;
    notifyListeners();
  }

  loadLessData() async {
    print('LESSS');
    if (numProducts[currentNumOrders.toString()]?.isNotEmpty ?? false) {
      print(currentNumOrders);
      notifyListeners();
      return;
    }
    isLoading = true;
    notifyListeners();
    numProducts[currentNumOrders.toString()] =
        await GetLessSoldUseCase.getLessPaidProducts(
            numOrders: currentNumOrders.abs());
    isLoading = false;
    notifyListeners();
  }

  void changeIsBestSelected(bool selected) async {
    isBestSelected = selected;
    print(isBestSelected);
    notifyListeners();
    await changeCurrentNumOrders(currentNumOrders);
  }
}
