import 'package:flutter/material.dart';

class DetailsProvider extends ChangeNotifier {
  int count = 1;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    if (count > 1) {
      count--;
      notifyListeners();
    }
  }
}
