import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class LogObserver extends AutoRouteObserver {
  void _log(String? route, String action) {
    if (route == null) return;

    Logger().i("$action: $route, header: route, action: Push");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    Logger().i("${route.settings.name ?? ''} header: route, action: Push");
    _log(route.settings.name, 'Push');

    super.didPush(route, previousRoute);
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    Logger().i("${route.name} header: route, action: InitTab");
    _log(route.name, 'InitTab');

    super.didInitTabRoute(route, previousRoute);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    Logger().i("${route.name} header: route, action: ChangeTab");
    _log(route.name, 'ChangeTab');

    super.didChangeTabRoute(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    Logger().i("${route.settings.name ?? ''} header: route, action: Pop");
    _log(route.settings.name ?? '', 'Pop');
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    Logger().i(
      "${newRoute?.settings.name ?? ''} header: route, action: Replace",
    );
    _log(newRoute?.settings.name ?? '', 'Replace');

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    Logger().i("${route.settings.name ?? ''} header: route, action: Remove");
    _log(route.settings.name ?? '', 'Remove');

    super.didRemove(route, previousRoute);
  }
}
