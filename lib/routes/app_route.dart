import 'package:auto_route/auto_route.dart';
import 'package:countries_app/routes/app_route.gr.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@AutoRouterConfig(replaceInRouteName: 'Tab|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.ref, super.navigatorKey});

  final Ref ref;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DashboardRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: FavoritesRoute.page),
      ],
    ),
    AutoRoute(page: CountryRoute.page),
  ];
}
