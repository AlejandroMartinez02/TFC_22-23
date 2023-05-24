import 'dart:convert';

import '../../data/category_repository.dart';
import '../entities/category_dto.dart';

class UpdateCategoryUseCase {
  static Future<int> updateCategory({required CategoryDTO category}) async {
    final response =
        await CategoryRepository.updateCategory(category: category);
    return json.decode(response)['status'];
  }
}
