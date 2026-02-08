import 'package:e_commerce/Models/e_commerce_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum MyStatus { initial, loading, success, error }

class CartProvider extends ChangeNotifier {
  final Map<String, int> cartQuantities = {};
  List<ECommerceModel> allProducts = [];
  MyStatus status = MyStatus.initial;

  CartProvider() {
    loadCart();
  }

  void syncWithProducts(List<ECommerceModel> products) {
    allProducts = products;
    notifyListeners();
  }

  List<CartItem> get cartItems {
    return cartQuantities.entries.map((entry) {
      final product = allProducts.firstWhere(
        (p) => p.id.toString() == entry.key,
        orElse: () => ECommerceModel(),
      );
      return CartItem(product: product, quantity: entry.value);
    }).toList();
  }

  int get totalItems => cartQuantities.values.fold(0, (sum, qty) => sum + qty);

  double get totalPrice {
    double total = 0;
    cartQuantities.forEach((id, qty) {
      final product = allProducts.firstWhere(
        (p) => p.id.toString() == id,
        orElse: () => ECommerceModel(),
      );
      total += (product.price ?? 0) * qty;
    });
    return total;
  }

  bool isInCart(ECommerceModel product) {
    return cartQuantities.containsKey(product.id.toString());
  }

  int getQuantity(ECommerceModel product) {
    return cartQuantities[product.id.toString()] ?? 0;
  }

  void addToCart(ECommerceModel product, {int quantity = 1}) {
    final id = product.id.toString();
    cartQuantities[id] = (cartQuantities[id] ?? 0) + quantity;
    saveCart();
    notifyListeners();
  }

  void incrementQuantity(ECommerceModel product) {
    final id = product.id.toString();
    if (cartQuantities.containsKey(id)) {
      cartQuantities[id] = cartQuantities[id]! + 1;
      saveCart();
      notifyListeners();
    }
  }

  void decrementQuantity(ECommerceModel product) {
    final id = product.id.toString();
    if (cartQuantities.containsKey(id)) {
      if (cartQuantities[id]! > 1) {
        cartQuantities[id] = cartQuantities[id]! - 1;
      } else {
        cartQuantities.remove(id);
      }
      saveCart();
      notifyListeners();
    }
  }

  void removeFromCart(ECommerceModel product) {
    cartQuantities.remove(product.id.toString());
    saveCart();
    notifyListeners();
  }

  void clearCart() {
    cartQuantities.clear();
    saveCart();
    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('cart_data', jsonEncode(cartQuantities));
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart_data');
    if (cartString != null) {
      final Map<String, dynamic> decoded = jsonDecode(cartString);
      cartQuantities.clear();
      decoded.forEach((key, value) {
        cartQuantities[key] = value as int;
      });
    }
    notifyListeners();
  }
}

class CartItem {
  final ECommerceModel product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}
