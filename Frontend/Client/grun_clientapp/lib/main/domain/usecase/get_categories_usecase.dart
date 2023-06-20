import 'dart:convert';

import '../../data/main_repository.dart';
import '../entity/category_dto.dart';

class GetCategoriesUseCase {
  static Future<List<CategoryDTO>> getCategories() async {
    final response = await MainRepository.getCategories();
    final Map<String, dynamic> categoriesMap = json.decode(response);
    final List<CategoryDTO> categories = [];
    categoriesMap['data'].forEach(
        (category) => {categories.add(CategoryDTO.fromJson(category))});
    return categories;
  }
}
