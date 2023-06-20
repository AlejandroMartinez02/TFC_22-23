import 'dart:convert';

import '../../data/menu_repository.dart';
import '../../data/network/response/category_dto.dart';

class GetCategoriesUseCase {
  static Future<List<CategoryDTO>> getCategories() async {
    final response = await MenuRepository.getCategories();
    final Map<String, dynamic> categoriesMap = json.decode(response);
    final List<CategoryDTO> categories = [];
    categoriesMap['data'].forEach(
        (category) => {categories.add(CategoryDTO.fromJson(category))});
    return categories;
  }
}
