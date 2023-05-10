// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/entity.dart';
import 'package:grun_mobileapp/main/domain/usecase/usecase.dart';
import 'package:grun_mobileapp/menu/ui/menu_provider.dart';

class MainProvider extends ChangeNotifier {
  bool faIsVisible = true;
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
    try {
      products = await GetProductsUseCase.init();
      categories = await GetCategoriesUseCase.getCategories();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  int _actualPage = 0;

  int get actualPage => _actualPage;

  void changeActualPage(int page, MenuProvider menuProvider,
      {int secondaryPageName = -1}) {
    faIsVisible = true;
    notifyListeners();
    if (page == _actualPage) return;

    if (page == 1) {
      menuProvider.changeActualPage(page: secondaryPageName);
    }

    if (page == 2) {
      faIsVisible = false;
      notifyListeners();
    }
    _actualPage = page;
    _pageController.animateToPage(_actualPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic);
    notifyListeners();
  }

  PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;
}
