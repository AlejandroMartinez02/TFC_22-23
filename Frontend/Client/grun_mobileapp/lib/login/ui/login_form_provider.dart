import 'package:flutter/material.dart';
import 'package:grun_mobileapp/login/domain/usecase/login_usecase.dart';

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
      final reponse = await LoginUseCase.login(email!, password!);
      isLoading = false;
      notifyListeners();
      return reponse;
    }
    return "NoValid";
  }
}
