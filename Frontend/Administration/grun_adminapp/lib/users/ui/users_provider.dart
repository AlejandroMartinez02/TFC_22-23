// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../domain/entities/user_dto.dart';
import '../domain/usecase/delete_user_case.dart';
import '../domain/usecase/get_all_user_usecase.dart';
import '../domain/usecase/update_user_usecase.dart';

class UserProvider extends ChangeNotifier {
  GlobalKey<FormState> updateUserKey = GlobalKey();
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isLoadingAction = false;
  bool get isLoadingAction => _isLoadingAction;
  set isLoadingAction(bool isLoadingAction) =>
      _isLoadingAction = isLoadingAction;

  List<UserDTO> users = [];
  UserDTO _updatedUser = UserDTO(
      id: '', name: '', lastname: '', email: '', address: '', phoneNumber: '');
  UserDTO get updatedUser => _updatedUser;
  set updatedUser(UserDTO user) => _updatedUser = user;

  int _currentUserIndex = 0;
  int get currentUserIndex => _currentUserIndex;
  set currentUserIndex(int currentIndex) => _currentUserIndex = currentIndex;

  UserProvider() {
    loadData();
  }

  void loadData() async {
    try {
      isLoading = true;
      notifyListeners();
      users = await GetAllUsersUseCase.getUsers();
      isLoading = false;
      notifyListeners();
    } catch (ex) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<int> updateUser() async {
    if (updateUserKey.currentState!.validate()) {
      if (!updatedUser.equals(users[currentUserIndex])) {
        try {
          isLoadingAction = true;
          notifyListeners();
          final response =
              await UpdateUserUseCase.updateUser(updatedUser: updatedUser);
          isLoadingAction = false;
          notifyListeners();
          if (response == 200) {
            users[currentUserIndex] = updatedUser;
          }
          return response;
        } catch (ex) {
          isLoadingAction = false;
          notifyListeners();
          return 500;
        }
      } else {
        return 100;
      }
    }
    return 0;
  }

  Future<int> deleteUser(String id) async {
    try {
      isLoadingAction = true;
      notifyListeners();
      final response = await DeleteUserUseCase.deleteUser(id: id);
      if (response == 200) {
        users.removeAt(currentUserIndex);
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
}
