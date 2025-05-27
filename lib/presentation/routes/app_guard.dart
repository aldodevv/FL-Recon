import 'package:auto_route/auto_route.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

class AppGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isLoggedIn = false; // Ganti dengan pengecekan sesungguhnya

    if (!isLoggedIn) {
      router.push(
        LoginRoute(
            
        ),
      );
    }
  }
}
