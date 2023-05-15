import 'package:flutter/material.dart';
import 'package:grun_adminapp/users/domain/usecase/update_user_usecase.dart';

import '../domain/entities/user_dto.dart';
import '../domain/usecase/delete_user_case.dart';
import '../domain/usecase/get_all_user_usecase.dart';

class UserProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  List<UserDTO> users = [];

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

  Future<String> updateUser(UserDTO updatedUser) async {
    try {
      isLoading = true;
      notifyListeners();
      final response =
          await UpdateUserUseCase.updateUser(updatedUser: updatedUser);
      isLoading = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoading = false;
      notifyListeners();
      return '500';
    }
  }

  Future<String> deleteUser(String id) async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await DeleteUserUseCase.deleteUser(id: id);
      isLoading = false;
      notifyListeners();
      return response;
    } catch (ex) {
      isLoading = false;
      notifyListeners();
      return '500';
    }
  }
}
