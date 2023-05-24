import 'dart:convert';

import '../../data/dish_repository.dart';

class DeleteDishUseCase {
  static Future<int> deleteDish({required String id}) async {
    final response = await DishRepository.deleteDish(id: id);
    return json.decode(response)['status'];
  }
}
