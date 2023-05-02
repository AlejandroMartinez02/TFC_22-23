import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  String _actualPage = "";

  String get actualPage => _actualPage;

  set actualPage(String page) {
    _actualPage = page;
    notifyListeners();
  }

  PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;
}
