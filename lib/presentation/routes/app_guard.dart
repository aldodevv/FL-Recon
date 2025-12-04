import 'package:auto_route/auto_route.dart';

class AppGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isLoggedIn = false;

    if (!isLoggedIn) {
      // router.push(LoginRoute());
    }
  }
}
