import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {
  int _activeIndex = 0;

  final PageController _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  PageController get pageController => _pageController;
  GlobalKey<ScaffoldState> get getScaffoldKey => scaffoldKey;

  int get activeIndex => _activeIndex;

  void setActiveIndex(int index) {
    _activeIndex = index;
    notifyListeners();
  }

  bool get tabBarVisible => _tabBarVisible;

  bool _tabBarVisible = true;
  set tabBarVisible(bool visible) {
    _tabBarVisible = visible;
    notifyListeners();
  }
}
