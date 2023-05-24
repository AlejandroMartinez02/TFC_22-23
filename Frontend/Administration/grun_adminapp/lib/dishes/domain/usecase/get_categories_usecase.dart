import 'dart:convert';

import '../../data/dish_repository.dart';
import '../entities/category_dto.dart';

class GetAllCategoriesUseCase {
  static Future<List<CategoryDTO>> getCategories() async {
    final response = await DishRepository.getCategories();
    final List<CategoryDTO> dishes = [];
    final usersMap = json.decode(response)['data'];
    usersMap.forEach((dish) => dishes.add(CategoryDTO.fromJson(dish)));
    return dishes;
  }
}
