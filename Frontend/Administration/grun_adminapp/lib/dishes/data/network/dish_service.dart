import 'package:file_selector/file_selector.dart';

import '../../../utils/services/secure_storage_service.dart';
import '../../domain/entities/dish_dto.dart';
import '../network/dish_client.dart';

class DishService {
  static Future<String> getDishes() async {
    final token = await SecureStorageService.getToken();
    return await DishClient.getDishes(token: token);
  }

  static Future<String> getCategories() async {
    final token = await SecureStorageService.getToken();
    return await DishClient.getCategories(token: token);
  }

  static Future<String> updateDish({required DishDTO updatedDish}) async {
    final token = await SecureStorageService.getToken();
    return await DishClient.updateDish(token: token, updatedDish: updatedDish);
  }

  static Future<String> deleteDish({required String id}) async {
    final token = await SecureStorageService.getToken();
    return await DishClient.deleteDish(id: id, token: token);
  }

  static Future<String> changeImage(XFile newFile, String oldImage) async {
    return await DishClient.changeImage(newFile, oldImage);
  }

  static Future<String> addDish({required DishDTO newDish}) async {
    final token = await SecureStorageService.getToken();
    return await DishClient.addDish(newDish: newDish, token: token);
  }

  static Future<String> addImage({required XFile file}) async {
    return await DishClient.addImage(file: file);
  }
}
