// ignore_for_file: unnecessary_null_comparison, unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';

import '../../utils/constants.dart';
import '../data/network/response/user_dto.dart';
import '../domain/usecase/get_user_usecase.dart';

class ProfileProvider extends ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  set isLoading(bool isLoading) => _isLoading = isLoading;

  UserDTO _user = UserDTO(
      id: '', name: '', lastname: '', email: '', phoneNumber: '', address: '');
  UserDTO get user => _user;
  set user(UserDTO user) => _user = user;

  ProfileProvider() {
    getUser();
  }

  void getUser() async {
    try {
      if (user.id.isEmpty) {
        isLoading = true;
        notifyListeners();
        user = await GetUserUseCase.init();
        isLoading = false;
        notifyListeners();
      }
    } catch (ex) {
      isLoading = false;
      user.id = Constants.error;
      notifyListeners();
    }
  }

  Future<bool> logOut() async {
    try {
      await SecureStorageService.deleteToken();
    } catch (ex) {
      return false;
    }
    return true;
  }
}
