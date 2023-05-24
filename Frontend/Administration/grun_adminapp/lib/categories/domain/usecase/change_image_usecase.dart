import 'package:file_selector/file_selector.dart';

import '../../data/category_repository.dart';

class ChangeImageUseCase {
  static Future<String> changeImage(
      {required XFile newImage, required String oldImage}) async {
    return await CategoryRepository.changeImage(
        newImage: newImage, oldImage: oldImage);
  }
}
