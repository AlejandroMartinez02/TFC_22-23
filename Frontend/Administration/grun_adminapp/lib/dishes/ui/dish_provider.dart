// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../domain/entities/category_dto.dart';
import '../domain/entities/dish_dto.dart';
import '../domain/usecase/usecase.dart';

class DishProvider extends ChangeNotifier {
  GlobalKey<FormState> updateDishKey = GlobalKey();
  GlobalKey<FormState> addDishKey = GlobalKey();

  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool isLoadingAction) =>
      _isLoadingAction = isLoadingAction;

  List<DishDTO> dishes = [];
  List<CategoryDTO> categories = [];
  XFile? _file;

  final DishDTO _clearDish = DishDTO(
      id: '',
      name: '',
      ingredients: '',
      category:
          CategoryDTO(id: '', name: 'Entrantes', description: '', photo: ''),
      cost: 0,
      photo: '',
      description: '');

  DishDTO _updatedDish = DishDTO(
      id: '',
      name: '',
      ingredients: '',
      category: CategoryDTO(id: '', name: '', description: '', photo: ''),
      cost: 0,
      photo: '',
      description: '');

  DishDTO get updatedDish => _updatedDish;
  set updatedDish(DishDTO dish) => _updatedDish = dish;

  DishDTO newDish = DishDTO(
      id: '',
      name: '',
      ingredients: '',
      category: CategoryDTO(id: '', name: '', description: '', photo: ''),
      cost: 0,
      photo: '',
      description: '');

  int _currentDishIndex = 0;
  int get currentDishIndex => _currentDishIndex;
  set currentDishIndex(int currentIndex) => _currentDishIndex = currentIndex;

  Future loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      dishes = await GetAllDishesUseCase.getDishes();

      categories = await GetAllCategoriesUseCase.getCategories();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> updateDish() async {
    if (updateDishKey.currentState!.validate()) {
      isLoadingAction = true;
      notifyListeners();
      await changeImage();
      if (!updatedDish.equals(dishes[currentDishIndex])) {
        try {
          updatedDish.cost =
              double.tryParse(updatedDish.cost.toStringAsFixed(2))!;
          final response =
              await UpdateDishUseCase.updateDish(updatedDish: updatedDish);
          if (response == 200) {
            dishes[currentDishIndex] = updatedDish;
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

  Future<int> deleteDish(String id) async {
    try {
      isLoadingAction = true;
      notifyListeners();
      final response = await DeleteDishUseCase.deleteDish(id: id);
      if (response == 200) {
        dishes.removeAt(currentDishIndex);
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

  changeCategory(String? value, DishDTO dish) {
    dish.category = categories.firstWhere((element) => element.name == value);
    notifyListeners();
  }

  Future getImage() async {
    const XTypeGroup typeGroup =
        XTypeGroup(label: 'images', extensions: ['jpg', 'png', 'jpeg']);
    _file = await openFile(acceptedTypeGroups: [typeGroup]);
  }

  changeImage() async {
    if (_file == null) return;
    final newUrl =
        await ChangeImageUseCase.changeImage(_file!, updatedDish.photo!);
    updatedDish.photo = newUrl;
    _file = null;
  }

  Future<int> addDish() async {
    try {
      if (addDishKey.currentState!.validate()) {
        isLoadingAction = true;
        notifyListeners();
        final response =
            json.decode(await AddDishUseCase.addDish(newDish: newDish));
        if (response['status'] == 201) {
          newDish.id = response['data']['_id'];
          dishes.add(newDish);
          newDish = _clearDish;
        }
        isLoadingAction = false;
        notifyListeners();
        return response['status'];
      }
      return 0;
    } catch (ex) {
      isLoadingAction = false;
      notifyListeners();
      return 404;
    }
  }
}
