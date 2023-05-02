// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/entity.dart';
import 'package:grun_mobileapp/main/domain/usecase/usecase.dart';
import 'package:grun_mobileapp/main/ui/menu_provider.dart';

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

  int _actualPage = 0;

  int get actualPage => _actualPage;

  void changeActualPage(int page, MenuProvider menuProvider,
      {String secondaryPageName = 'Entrantes'}) {
    _actualPage = page;
    if (page == 1) {
      menuProvider.actualPage = secondaryPageName;
    }
    _pageController.animateToPage(_actualPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
    notifyListeners();
  }

  PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;
}
