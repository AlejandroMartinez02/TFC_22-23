import 'dart:convert';

import '../../data/category_repository.dart';

class DeleteCategoryUseCase {
  static Future<int> deleteCategory(
      {required String id, required String oldImage}) async {
    final response =
        await CategoryRepository.deleteCategory(id: id, oldImage: oldImage);
    return json.decode(response)['status'];
  }
}
