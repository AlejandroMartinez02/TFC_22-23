// ignore_for_file: unnecessary_getters_setters

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../domain/entities/category_dto.dart';
import '../domain/usecase/usecase.dart';

class CategoryProvider extends ChangeNotifier {
  GlobalKey<FormState> updateCategoryKey = GlobalKey();
  GlobalKey<FormState> addCategoryKey = GlobalKey();

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool isLoadingAction) =>
      _isLoadingAction = isLoadingAction;

  List<CategoryDTO> categories = [];
  XFile? _image;

  final CategoryDTO _clearCategory =
      CategoryDTO(id: '', name: '', description: '', photo: '');

  CategoryDTO _updatedCategory =
      CategoryDTO(id: '', name: '', photo: '', description: '');

  CategoryDTO get updatedCategory => _updatedCategory;
  set updatedCategory(CategoryDTO category) => _updatedCategory = category;

  CategoryDTO _newCategory =
      CategoryDTO(id: '', name: '', photo: '', description: '');

  CategoryDTO get newCategory => _newCategory;
  set newCategory(CategoryDTO category) => _newCategory = category;

  int _currentCategoryIndex = 0;
  int get currentCategoryIndex => _currentCategoryIndex;
  set currentCategoryIndex(int currentIndex) =>
      _currentCategoryIndex = currentIndex;

  Future loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      categories = await GetAllCategoriesUseCase.getAllCategories();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> addCategory() async {
    try {
      if (addCategoryKey.currentState!.validate()) {
        isLoadingAction = true;
        notifyListeners();
        final response =
            await AddCategoryUseCase.addCategory(category: newCategory);
        if (response == 200) {
          categories.add(newCategory);
          newCategory = _clearCategory;
        }
        isLoadingAction = false;
        notifyListeners();
        return response;
      }
      return 0;
    } catch (ex) {
      isLoadingAction = false;
      notifyListeners();
      return 404;
    }
  }

  Future<int> updateCategory() async {
    if (updateCategoryKey.currentState!.validate()) {
      isLoadingAction = true;
      notifyListeners();
      await changeImage();
      if (!updatedCategory.equals(categories[currentCategoryIndex])) {
        try {
          final response = await UpdateCategoryUseCase.updateCategory(
              category: updatedCategory);
          if (response == 200) {
            categories[currentCategoryIndex] = updatedCategory;
          }
          isLoadingAction = false;
          notifyListeners();
          return response;
        } catch (ex) {
          isLoadingAction = false;
          notifyListeners();
          return 500;
        }
      } else {
        isLoadingAction = false;
        notifyListeners();
        return 100;
      }
    }
    return 0;
  }

  Future<int> deleteCategory(String id, String oldImage) async {
    try {
      isLoadingAction = true;
      notifyListeners();
      final response = await DeleteCategoryUseCase.deleteCategory(
          id: id, oldImage: oldImage);
      if (response == 200) {
        categories.removeAt(currentCategoryIndex);
      }
      isLoadingAction = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoadingAction = false;
      notifyListeners();
      return 500;
    }
  }

  Future getImage() async {
    const XTypeGroup typeGroup =
        XTypeGroup(label: 'images', extensions: ['jpg', 'png', 'jpeg']);
    _image = await openFile(acceptedTypeGroups: [typeGroup]);
  }

  changeImage() async {
    if (_image == null) return;
    final newUrl = await ChangeImageUseCase.changeImage(
        newImage: _image!, oldImage: updatedCategory.photo);
    updatedCategory.photo = newUrl;
    _image = null;
  }
}
