import 'package:file_selector/file_selector.dart';

import '../../data/dish_repository.dart';

class ChangeImageUseCase {
  static Future<String> changeImage(XFile file, String oldImage) async {
    final response = await DishRepository.changeImage(file, oldImage);
    return response;
  }
}
