// import 'package:flutter/material.dart';
//
// class HomeProvider extends ChangeNotifier {
//   bool isSearchOpen = false;
//   final TextEditingController searchController = TextEditingController();
//
//   void openSearch() {
//     isSearchOpen = true;
//     notifyListeners();
//   }
//
//   void closeSearch() {
//     isSearchOpen = false;
//     searchController.clear();
//     notifyListeners();
//   }
//
//   void toggleSearch() {
//     if (isSearchOpen) {
//       closeSearch();
//     } else {
//       openSearch();
//     }
//   }
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
// }

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
