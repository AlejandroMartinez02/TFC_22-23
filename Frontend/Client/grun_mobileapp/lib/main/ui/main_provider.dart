// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/entity.dart';
import 'package:grun_mobileapp/main/domain/usecase/usecase.dart';

class MainProvider extends ChangeNotifier {
  final List<ProductDTO> _products = [];

  List<ProductDTO> get products => _products;

  set products(List<ProductDTO> products) {
    _products.removeRange(0, _products.length);
    _products.addAll(products);
  }

  final List<CategoryDTO> _categories = [];

  List<CategoryDTO> get categories => _categories;

  set categories(List<CategoryDTO> categories) {
    _categories.removeRange(0, _categories.length);
    _categories.addAll(categories);
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool load) {
    _isLoading = load;
  }

  MainProvider() {
    loadData();
  }

  Future loadData() async {
    products = await GetProductsUseCase.init();
    categories = await GetCategoriesUseCase.init();

    isLoading = false;
    notifyListeners();
  }
}
