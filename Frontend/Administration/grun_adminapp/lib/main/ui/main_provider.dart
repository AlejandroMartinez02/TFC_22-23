import 'package:flutter/material.dart';

import '../../users/ui/users_screen.dart';

class MainProvider extends ChangeNotifier {
  Widget currentPage = const UsersScreen();

  void changePage(Widget page) {
    currentPage = page;
    notifyListeners();
  }
}
