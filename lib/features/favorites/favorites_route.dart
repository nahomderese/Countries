import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'favorites_page.dart';

@RoutePage()
class FavoritesRoute extends StatelessWidget {
  const FavoritesRoute({super.key});
  static const routeName = '/favoritesScreen';

  @override
  Widget build(BuildContext context) => const FavoritesPage();
}
