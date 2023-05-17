import 'package:flutter/material.dart';

import '../../users/ui/users_screen.dart';
import '../domain/usecase/logout_usecase.dart';

class MainProvider extends ChangeNotifier {
  Widget currentPage = const UsersScreen();

  void changePage(Widget page) {
    currentPage = page;
    notifyListeners();
  }

  Future<bool> logOut() async {
    try {
      await LogoutUseCase.logout();
    } catch (ex) {
      return false;
    }
    return true;
  }
}
