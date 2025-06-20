import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:countries_app/shared/domain/models/country_model.dart';
import 'package:countries_app/shared/domain/repositories/country_repository.dart';
import 'package:countries_app/shared/domain/providers/dio_network_service_provider.dart';

final countryRepositoryProvider = Provider<CountryRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  return CountryRepositoryImpl(networkService);
});

class CountryRepositoryImpl implements CountryRepository {
  final dynamic networkService;
  CountryRepositoryImpl(this.networkService);

  @override
  Future<List<Country>> fetchCountries() async {
    final endpoint = 'https://restcountries.com/v3.1/independent';
    final query = {
      'status': 'true',
      'fields': 'name,population,flags,area,region,subregion,timezones',
    };
    final result = await networkService.get(endpoint, queryParameters: query);
    return result.fold((error) => throw Exception(error.message), (response) {
      final data = response.data as List<dynamic>;
      return data.map((e) => Country.fromJson(e)).toList();
    });
  }
}
