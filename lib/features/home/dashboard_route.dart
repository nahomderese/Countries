import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'dashboard_page.dart';

@RoutePage()
class DashboardRoute extends StatelessWidget {
  const DashboardRoute({super.key});
  static const routeName = '/dashboardScreen';

  @override
  Widget build(BuildContext context) => const DashboardPage();
}
