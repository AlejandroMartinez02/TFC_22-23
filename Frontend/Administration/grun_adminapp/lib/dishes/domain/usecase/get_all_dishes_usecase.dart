import 'dart:convert';

import '../../data/dish_repository.dart';
import '../entities/dish_dto.dart';

class GetAllDishesUseCase {
  static Future<List<DishDTO>> getDishes() async {
    final response = await DishRepository.getDishes();
    final List<DishDTO> dishes = [];
    final usersMap = json.decode(response)['data'];
    usersMap.forEach((dish) => dishes.add(DishDTO.fromJson(dish)));
    return dishes;
  }
}
