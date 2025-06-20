import '../models/country_model.dart';

abstract class CountryRepository {
  Future<List<Country>> fetchCountries();
}
