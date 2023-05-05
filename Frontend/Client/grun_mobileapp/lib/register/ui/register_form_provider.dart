// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:grun_mobileapp/login/data/network/login_client.dart';
import 'package:grun_mobileapp/register/domain/entities/register_user_dto.dart';
import 'package:grun_mobileapp/register/domain/usecase/register_usecase.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> firstKey = GlobalKey();

  bool _isHidden = true;
  bool get isHidden => _isHidden;
  set isHidden(bool isHidden) {
    _isHidden = isHidden;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String? _name;
  String? get name => _name;
  set name(String? name) => _name = name;

  String? _lastName;
  String? get lastName => _lastName;
  set lastName(String? lastName) => _lastName = lastName;

  String? _email;
  String? get email => _email;
  set email(String? email) => _email = email;

  String? _address;
  String? get address => _address;
  set address(String? address) => _address = address;

  String? _phoneNumber;
  String? get phoneNumber => _phoneNumber;
  set phoneNumber(String? phone) => _phoneNumber = phone;

  String? _password;
  String? get password => _password;
  set password(String? password) => _password = password;

  Future isValidForm() async {
    if (firstKey.currentState?.validate() ?? false) {
      isLoading = true;
      notifyListeners();
      final user = RegisterUserDTO(
          email: email!,
          lastname: lastName!,
          name: name!,
          password: password!,
          phoneNumber: phoneNumber!,
          address: address!);
      final response = await RegisterUseCase.register(user);
      isLoading = false;
      notifyListeners();
      return response;
    }

    return "noValid";
  }
}
