// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:countries_app/features/country/country_route.dart' as _i1;
import 'package:countries_app/features/favorites/favorites_route.dart' as _i3;
import 'package:countries_app/features/home/dashboard_route.dart' as _i2;
import 'package:countries_app/features/home/home_route.dart' as _i4;
import 'package:countries_app/shared/domain/models/country_model.dart' as _i7;
import 'package:flutter/material.dart' as _i6;

/// generated route for
/// [_i1.CountryRoute]
class CountryRoute extends _i5.PageRouteInfo<CountryRouteArgs> {
  CountryRoute({
    _i6.Key? key,
    required _i7.Country country,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         CountryRoute.name,
         args: CountryRouteArgs(key: key, country: country),
         initialChildren: children,
       );

  static const String name = 'CountryRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CountryRouteArgs>();
      return _i1.CountryRoute(key: args.key, country: args.country);
    },
  );
}

class CountryRouteArgs {
  const CountryRouteArgs({this.key, required this.country});

  final _i6.Key? key;

  final _i7.Country country;

  @override
  String toString() {
    return 'CountryRouteArgs{key: $key, country: $country}';
  }
}

/// generated route for
/// [_i2.DashboardRoute]
class DashboardRoute extends _i5.PageRouteInfo<void> {
  const DashboardRoute({List<_i5.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardRoute();
    },
  );
}

/// generated route for
/// [_i3.FavoritesRoute]
class FavoritesRoute extends _i5.PageRouteInfo<void> {
  const FavoritesRoute({List<_i5.PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.FavoritesRoute();
    },
  );
}

/// generated route for
/// [_i4.HomeRoute]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeRoute();
    },
  );
}
