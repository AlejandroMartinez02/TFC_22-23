import 'package:file_selector/file_selector.dart';

import '../../data/dish_repository.dart';

class AddImageUseCase {
  static Future<String> addImage({required XFile file}) async {
    return await DishRepository.addImage(file: file);
  }
}
