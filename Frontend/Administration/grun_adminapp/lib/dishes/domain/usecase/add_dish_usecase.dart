import 'dart:convert';

import '../../data/dish_repository.dart';
import '../entities/dish_dto.dart';

class AddDishUseCase {
  static Future<int> addDish({required DishDTO newDish}) async {
    final response = await DishRepository.addDish(newDish: newDish);
    return json.decode(response)['status'];
  }
}
