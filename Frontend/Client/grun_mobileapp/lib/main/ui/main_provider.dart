// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../../menu/ui/menu_provider.dart';
import '../domain/entity/entity.dart';
import '../domain/usecase/get_less_pais_products_usecase.dart';
import '../domain/usecase/usecase.dart';

class MainProvider extends ChangeNotifier {
  bool _faIsVisible = true;
  bool get faIsVisible => _faIsVisible;
  set faIsVisible(bool visible) => _faIsVisible = visible;

  final List<ProductDTO> _products = [];
  List<ProductDTO> get products => _products;

  set products(List<ProductDTO> products) {
    _products.removeRange(0, _products.length);
    _products.addAll(products);
  }

  final List<ProductDTO> _lessPaidProducts = [];
  List<ProductDTO> get lessPaidProducts => _lessPaidProducts;
  set lessPaidProducts(List<ProductDTO> products) {
    if (products.length <= 6) {
      for (var product in products) {
        _lessPaidProducts.add(product);
      }
    } else {
      for (var x = 0; x < 6; x++) {
        _lessPaidProducts.add(products[x]);
      }
    }
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
      products = await GetProductsUseCase.getProducts();
      categories = await GetCategoriesUseCase.getCategories();
      lessPaidProducts = await GetLessPaidProductsUseCase.getLessPaidProducts();
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
    if (page == _actualPage) return;

    if (page == 1) {
      menuProvider.changeActualPage(page: secondaryPageName);
    }

    if (page == 2) {
      faIsVisible = false;
      notifyListeners();
    } else {
      faIsVisible = true;
      notifyListeners();
    }
    _actualPage = page;
    _pageController.animateToPage(_actualPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic);
    notifyListeners();
  }

  final PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;
}
