import 'package:shared_preferences/shared_preferences.dart';

class FavoritesServices {
  static const _key = 'favorites';

  Future<List<int>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites.map((e) => int.parse(e)).toList();
  }

  Future<void> addFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    if (!favorites.contains(productId.toString())) {
      favorites.add(productId.toString());
      await prefs.setStringList(_key, favorites);
    }
  }

  Future<void> removeFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    favorites.remove(productId.toString());
    await prefs.setStringList(_key, favorites);
  }

  Future<bool> isFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites.contains(productId.toString());
  }
}
