import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_weather/pages/map_page/map_page.dart';
import 'package:my_weather/pages/search_page/search_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: MapRoute.page,
          path: '/map-route',
        ),
        AutoRoute(
          page: SearchRoute.page,
          path: '/search-route',
        ),
      ];
}
