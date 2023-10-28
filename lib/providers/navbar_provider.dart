import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _currentIndex = 1;

  late final PageController _pageController =
      PageController(initialPage: _currentIndex);

  PageController get pageController => _pageController;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    notifyListeners();
  }
}
