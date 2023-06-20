// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../domain/usecase/login_usecase.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String? _email = '';
  String? get email => _email;
  set email(String? email) => _email = email;

  String? _password = '';
  String? get password => _password;
  set password(String? pass) => _password = pass;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) => _isLoading = isLoading;

  bool _isHidden = true;
  bool get isHidden => _isHidden;
  set isHidden(bool isHidden) {
    _isHidden = isHidden;
    notifyListeners();
  }

  Future isValidForm() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        _isLoading = true;
        notifyListeners();
        final reponse = await LoginUseCase.login(email!, password!);
        _isLoading = false;
        notifyListeners();
        return reponse;
      }
      return "NoValid";
    } catch (ex) {
      _isLoading = false;
      notifyListeners();
      return Constants.error;
    }
  }
}
