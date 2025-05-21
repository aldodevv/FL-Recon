// app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:recon/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: FlushbarRoute.page),
    AutoRoute(page: SettingRoute.page),
    AutoRoute(page: Base32Route.page),
    AutoRoute(page: TransformerBlocRoute.page),
    AutoRoute(page: DatePickerRoute.page),
  ];
}
