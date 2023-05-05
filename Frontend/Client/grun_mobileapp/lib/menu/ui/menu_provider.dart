import 'package:flutter/material.dart';
import 'package:grun_mobileapp/main/domain/entity/entity.dart';
import 'package:grun_mobileapp/main/domain/usecase/get_categories_usecase.dart';
import 'package:grun_mobileapp/menu/domain/usecase/get_products_by_category_usecase.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuProvider extends ChangeNotifier {
  MenuProvider() {
    loadData();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool loading) => _isLoading = loading;

  int _actualCategory = 0;

  int get actualCategory => _actualCategory;

  void changeActualPage({int page = -1}) async {
    if (page != -1) _actualCategory = page;

    _isLoading = true;
    notifyListeners();
    await loadProducts();
    _isLoading = false;
    notifyListeners();
  }

  Map<String, List<ProductDTO>> categoryProducts = {};
  late List<CategoryDTO> categories;

  Future loadData() async {
    await loadCategories();
    await loadProducts();
    _isLoading = false;
    notifyListeners();
  }

  Future loadProducts() async {
    if (categoryProducts[categories[_actualCategory].name]!.isNotEmpty) return;

    categoryProducts[categories[_actualCategory].name] =
        await GetProductsByCategoryUseCase.getProductsByCategory(
            category: categories[_actualCategory].name);
  }

  loadCategories() async {
    categories = await GetCategoriesUseCase.getCategories();
    categories.forEach((element) {
      categoryProducts[element.name] = [];
    });
  }

  final ItemScrollController _categoryController = ItemScrollController();

  ItemScrollController get categoryController => _categoryController;
}
