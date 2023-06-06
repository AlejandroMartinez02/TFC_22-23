import 'package:file_selector/file_selector.dart';

import '../domain/entities/dish_dto.dart';
import 'network/dish_service.dart';

class DishRepository {
  static Future<String> getDishes() async {
    return await DishService.getDishes();
  }

  static Future<String> getCategories() async {
    return await DishService.getCategories();
  }

  static Future<String> updateDish({required DishDTO updatedDish}) async {
    return await DishService.updateDish(updatedDish: updatedDish);
  }

  static Future<String> deleteDish({required String id}) async {
    return await DishService.deleteDish(id: id);
  }

  static Future<String> changeImage(XFile newFile, String oldImage) async {
    return await DishService.changeImage(newFile, oldImage);
  }

  static Future<String> addDish({required DishDTO newDish}) async {
    return await DishService.addDish(newDish: newDish);
  }

  static Future<String> addImage({required XFile file}) async {
    return await DishService.addImage(file: file);
  }
}
