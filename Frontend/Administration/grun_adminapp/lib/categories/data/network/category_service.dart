import 'package:file_selector/file_selector.dart';

import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/category_dto.dart';
import 'category_client.dart';

class CategoryService {
  static Future<String> getAllCategories() async {
    final token = await SecureStorageService.getToken();
    return await CategoryClient.getAllCategories(token: token);
  }

  static Future<String> addCategory({required CategoryDTO category}) async {
    final token = await SecureStorageService.getToken();
    return await CategoryClient.addCategory(category: category, token: token);
  }

  static Future<String> updateCategory({required CategoryDTO category}) async {
    final token = await SecureStorageService.getToken();
    return await CategoryClient.updateCategory(
        category: category, token: token);
  }

  static Future<String> deleteCategory(
      {required String id, required String oldImage}) async {
    final token = await SecureStorageService.getToken();
    return await CategoryClient.deleteCategory(
        id: id, token: token, oldImage: oldImage);
  }

  static Future<String> changeImage(
      {required XFile newImage, required String oldImage}) async {
    return await CategoryClient.changeImage(newImage, oldImage);
  }
}
