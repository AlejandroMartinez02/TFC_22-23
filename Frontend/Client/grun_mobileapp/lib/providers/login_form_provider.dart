import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email = '';
  String? password = '';

  bool isLoading = false;

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
