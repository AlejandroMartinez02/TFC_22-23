import 'package:file_selector/file_selector.dart';

import '../domain/entities/category_dto.dart';
import 'network/category_service.dart';

class CategoryRepository {
  static Future<String> getAllCategories() async {
    return await CategoryService.getAllCategories();
  }

  static Future<String> addCategory({required CategoryDTO category}) async {
    return await CategoryService.addCategory(category: category);
  }

  static Future<String> updateCategory({required CategoryDTO category}) async {
    return await CategoryService.updateCategory(category: category);
  }

  static Future<String> deleteCategory(
      {required String id, required String oldImage}) async {
    return await CategoryService.deleteCategory(id: id, oldImage: oldImage);
  }

  static Future<String> changeImage(
      {required XFile newImage, required String oldImage}) async {
    return await CategoryService.changeImage(
        newImage: newImage, oldImage: oldImage);
  }
}
