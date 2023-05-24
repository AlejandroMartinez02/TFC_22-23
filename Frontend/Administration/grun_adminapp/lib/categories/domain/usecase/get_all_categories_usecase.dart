import 'dart:convert';

import '../../data/category_repository.dart';
import '../entities/category_dto.dart';

class GetAllCategoriesUseCase {
  static Future<List<CategoryDTO>> getAllCategories() async {
    final response = await CategoryRepository.getAllCategories();
    List<CategoryDTO> categories = [];
    final categorieMap = json.decode(response)['data'];
    categorieMap
        .forEach((category) => categories.add(CategoryDTO.fromJson(category)));
    return categories;
  }
}
