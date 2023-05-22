import 'dart:convert';

import '../../data/category_repository.dart';
import '../entities/category_dto.dart';

class AddCategoryUseCase {
  static Future<int> addCategory({required CategoryDTO category}) async {
    final response = await CategoryRepository.addCategory(category: category);
    return json.decode(response)['status'];
  }
}
