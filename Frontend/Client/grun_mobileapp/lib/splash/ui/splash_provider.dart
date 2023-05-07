// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/login/data/datastore/secure_storage_service.dart';
import 'package:grun_mobileapp/splash/domain/usecase/check_token_usecase.dart';

class SplashProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool loading) => _isLoading = loading;

  Future<String> getToken() async {
    return await SecureStorageService.getToken();
  }

  Future<bool> checkToken() async {
    try {
      _isLoading = true;
      notifyListeners();
      final checkToken = await CheckTokenUseCase.checkToken();
      isLoading = false;
      notifyListeners();
      return checkToken;
    } catch (ex) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
