import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

@RoutePage()
class HomeRoute extends StatelessWidget {
  const HomeRoute({super.key});
  static const routeName = '/homeScreen';

  @override
  Widget build(BuildContext context) => const HomePage();
}
