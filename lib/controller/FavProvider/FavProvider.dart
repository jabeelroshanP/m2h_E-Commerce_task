import 'package:e_commerce/Models/e_commerce_model.dart';
import 'package:e_commerce/service/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MyStatus { initial, loading, success, error }

class Favprovider extends ChangeNotifier {
  final List<ECommerceModel> favorites = [];
  final List<String> favoriteIds = [];

  Favprovider() {
    loadFavoriteIds();
  }

  void tapFav(ECommerceModel product) {
    final ids = product.id.toString();

    if (favoriteIds.contains(ids)) {
      favoriteIds.remove(ids);
      favorites.removeWhere((p) => p.id == product.id);
    } else {
      favoriteIds.add(ids);
      favorites.add(product);
    }

    saveFavoriteIds();
    notifyListeners();
  }

  bool isFavorite(ECommerceModel product) {
    return favoriteIds.contains(product.id.toString());
  }

  Future<void> loadFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final savedIds = prefs.getStringList('favorite_ids') ?? [];
    favoriteIds.clear();
    favoriteIds.addAll(savedIds);
    notifyListeners();
  }

  void withProducts(List<ECommerceModel> allProducts) {
    favorites.clear();
    favorites.addAll(
      allProducts.where((p) => favoriteIds.contains(p.id.toString())),
    );
    notifyListeners();
  }

  Future<void> saveFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_ids', favoriteIds);
    debugPrint("saved favors ids to prefs $favoriteIds");
  }
}
