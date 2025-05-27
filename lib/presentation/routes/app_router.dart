// app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/onboarding', page: OnboardRoute.page, initial: true),
    AutoRoute(path: '/signin', page: LoginRoute.page),
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/flushbar', page: FlushbarRoute.page),
    AutoRoute(path: '/setting', page: SettingRoute.page),
    AutoRoute(path: '/base32', page: Base32Route.page),
    AutoRoute(path: '/datepicker', page: DatePickerRoute.page),
  ];
}
