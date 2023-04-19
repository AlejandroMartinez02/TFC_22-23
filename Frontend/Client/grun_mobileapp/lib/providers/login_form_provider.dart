import 'package:flutter/material.dart';
import 'package:grun_mobileapp/repositories/auth_repository.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email = '';
  String? password = '';

  bool isLoading = false;

  bool isHidden = true;

  bool isValidForm2() => formKey.currentState?.validate() ?? false;

  Future isValidForm() async {
    if (formKey.currentState?.validate() ?? false) {
      return await AuthRepository.Login(email, password);
    }
    return "ERRROR";
  }
}
