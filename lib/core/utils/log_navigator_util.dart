import 'package:flutter/material.dart';

class RouteLogger extends NavigatorObserver {
  void _log(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) {
    debugPrint(
      '🧭 [$action]\n'
      '⬅️ from: ${previousRoute?.settings.name}\n'
      '➡️ to  : ${route?.settings.name}',
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _log('PUSH', route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _log('POP', previousRoute, route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    debugPrint(
      '🔁 [REPLACE]\n'
      '❌ old: ${oldRoute?.settings.name}\n'
      '✅ new: ${newRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    debugPrint(
      '🗑️ [REMOVE]\n'
      '❌ removed: ${route.settings.name}\n'
      '⬅️ back to: ${previousRoute?.settings.name}',
    );
  }
}
