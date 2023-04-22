import 'package:flutter/material.dart';
import 'package:grun_mobileapp/models/Request/create_user_dto.dart';
import 'package:grun_mobileapp/repositories/auth_repository.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> firstKey = GlobalKey();

  bool isHidden = true;

  bool isLoading = false;

  String? name;
  String? lastName;
  String? email;
  String? address;
  String? phoneNumber;
  final String rol = "User";
  String? password;

  Future isValidForm() async {
    if (firstKey.currentState?.validate() ?? false) {
      isLoading = true;
      notifyListeners();
      final user = CreateUserDto(
          email: email!,
          lastname: lastName!,
          name: name!,
          password: password!,
          phoneNumber: phoneNumber!,
          rol: rol);

      return await AuthRepository.register(user);
    }
    isLoading = false;
    notifyListeners();
    return "ERROR";
  }
}
