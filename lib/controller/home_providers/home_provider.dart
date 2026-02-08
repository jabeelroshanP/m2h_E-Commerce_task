import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool isSearchOpen = false;

  void openSearch() {
    isSearchOpen = true;
    notifyListeners();
  }

  void closeSearch() {
    isSearchOpen = false;
    notifyListeners();
  }

  void toggleSearch() {
    isSearchOpen = !isSearchOpen;
    notifyListeners();
  }

}
