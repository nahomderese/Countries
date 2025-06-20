import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countries_app/shared/data/local/favorites_repository_impl.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._repo) : super({}) {
    _loadFavorites();
  }
  final FavoritesRepositoryImpl _repo;

  Future<void> _loadFavorites() async {
    final favs = await _repo.getFavorites();
    state = Set<String>.from(favs);
  }

  Future<void> toggleFavorite(String countryName) async {
    if (state.contains(countryName)) {
      await _repo.removeFavorite(countryName);
      state = {...state}..remove(countryName);
    } else {
      await _repo.addFavorite(countryName);
      state = {...state, countryName};
    }
  }

  bool isFavorite(String countryName) => state.contains(countryName);
}

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) {
    final repo =
        ref.watch(favoritesRepositoryProvider) as FavoritesRepositoryImpl;
    return FavoritesNotifier(repo);
  },
);
