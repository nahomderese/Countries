abstract class FavoritesRepository {
  Future<List<String>> getFavorites();
  Future<void> addFavorite(String countryName);
  Future<void> removeFavorite(String countryName);
  Future<bool> isFavorite(String countryName);
}
