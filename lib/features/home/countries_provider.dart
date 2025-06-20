import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countries_app/shared/domain/models/country_model.dart';
import 'package:countries_app/shared/data/remote/country_repository_impl.dart';

final countriesProvider = FutureProvider<List<Country>>((ref) async {
  final repo = ref.watch(countryRepositoryProvider);
  return repo.fetchCountries();
});
