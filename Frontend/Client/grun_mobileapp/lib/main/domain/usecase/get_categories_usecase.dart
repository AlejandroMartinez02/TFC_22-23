import 'dart:convert';

import 'package:grun_mobileapp/main/data/main_repository.dart';
import 'package:grun_mobileapp/main/domain/entity/category_dto.dart';

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
