import 'dart:convert';

import '../../data/dish_repository.dart';
import '../entities/dish_dto.dart';

class UpdateDishUseCase {
  static Future<int> updateDish({required DishDTO updatedDish}) async {
    final response = await DishRepository.updateDish(updatedDish: updatedDish);
    return json.decode(response)['status'];
  }
}
