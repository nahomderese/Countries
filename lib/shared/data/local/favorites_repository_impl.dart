import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:countries_app/shared/domain/repositories/favorites_repository.dart';

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepositoryImpl();
});

class FavoritesRepositoryImpl implements FavoritesRepository {
  static const String _key = 'favorite_countries';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<List<String>> getFavorites() async {
    final prefs = await _prefs;
    return prefs.getStringList(_key) ?? [];
  }

  @override
  Future<void> addFavorite(String countryName) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList(_key) ?? [];
    if (!favorites.contains(countryName)) {
      favorites.add(countryName);
      await prefs.setStringList(_key, favorites);
    }
  }

  @override
  Future<void> removeFavorite(String countryName) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList(_key) ?? [];
    favorites.remove(countryName);
    await prefs.setStringList(_key, favorites);
  }

  @override
  Future<bool> isFavorite(String countryName) async {
    final prefs = await _prefs;
    final favorites = prefs.getStringList(_key) ?? [];
    return favorites.contains(countryName);
  }
}
