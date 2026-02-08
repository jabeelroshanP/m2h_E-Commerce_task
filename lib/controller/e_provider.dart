import 'package:flutter/cupertino.dart';

import '../Models/e_commerce_model.dart';
import '../service/service.dart';

enum MyStatus { initial, loading, success, error }

class EcommerceProvider extends ChangeNotifier {
  final NetworkingService service = NetworkingService();

  List<ECommerceModel> model = [];
  List<ECommerceModel> filteredProducts = [];
  String selectedCategory = 'All';


  MyStatus status = MyStatus.initial;

  String errorMessage = "";

  Future<void> getProducts() async {
    status = MyStatus.loading;
    errorMessage = "";
    notifyListeners();

    try {
      final result = await service.getProducts();

      if (result != null) {
        model = result;
        filteredProducts = List.from(model);
        status = MyStatus.success;
      } else {
        status = MyStatus.error;
        errorMessage = "No data received from API";
      }
    } catch (e) {
      status = MyStatus.error;
      errorMessage = e.toString();
    }

    notifyListeners();
  }

  void setProducts(List<ECommerceModel> products) {
    model = products;
    filteredProducts = List.from(model);
    notifyListeners();
  }

  void filterByCategory(String category) {
    selectedCategory = category;

    if (category == 'All') {
      filteredProducts = List.from(model);
    } else {
      filteredProducts = model
          .where((p) => p.category?.toLowerCase() == category.toLowerCase())
          .toList();
    }

    notifyListeners();
  }
}