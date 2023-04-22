import 'package:flutter/material.dart';
import 'package:grun_mobileapp/repositories/auth_repository.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email = '';
  String? password = '';

  bool isLoading = false;

  bool isHidden = true;

  Future isValidForm() async {
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;
      notifyListeners();
      final reponse = await AuthRepository.login(email, password);
      isLoading = false;
      notifyListeners();
      return reponse;
    }
    return "ERRROR";
  }

  Future<String> readToken() async {
    return await AuthRepository.readToken();
  }

  Future<void> logout() async {
    return await AuthRepository.logOut();
  }
}
