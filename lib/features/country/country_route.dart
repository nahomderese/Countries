import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'country_page.dart';
import 'package:countries_app/shared/domain/models/country_model.dart';

@RoutePage()
class CountryRoute extends StatelessWidget {
  final Country country;
  const CountryRoute({super.key, required this.country});
  static const routeName = '/countryScreen';
  @override
  Widget build(BuildContext context) => CountryPage(country: country);
}
