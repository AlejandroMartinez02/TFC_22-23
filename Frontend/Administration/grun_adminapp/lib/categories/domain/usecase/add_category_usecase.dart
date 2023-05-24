import '../../data/category_repository.dart';
import '../entities/category_dto.dart';

class AddCategoryUseCase {
  static Future<String> addCategory({required CategoryDTO category}) async {
    return await CategoryRepository.addCategory(category: category);
  }
}
