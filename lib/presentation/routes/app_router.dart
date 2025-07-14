// app_router.dart
import 'package:auto_route/auto_route.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    //! Auth Routes
    AutoRoute(path: '/onboarding', page: OnboardRoute.page, initial: true),
    AutoRoute(path: '/forgetpassword', page: ForgetpasswordRoute.page),
    AutoRoute(path: '/termscondition', page: TermsconditionRoute.page),
    AutoRoute(path: '/login', page: LoginRoute.page),
    AutoRoute(path: '/signin', page: SigninRoute.page),

    //! Home Routes
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/flushbar', page: FlushbarRoute.page),
    AutoRoute(path: '/setting', page: SettingRoute.page),
    AutoRoute(path: '/base32', page: Base32Route.page),
    AutoRoute(path: '/datepicker', page: DatePickerRoute.page),
    AutoRoute(path: '/game', page: WordleGameRoute.page),
    AutoRoute(path: '/memory-match', page: MemoryMatchGameRoute.page),
    AutoRoute(path: '/snake-game', page: SnakeGameRoute.page),
    AutoRoute(path: '/tap-the-target', page: TapTheTargetGameRoute.page),
    AutoRoute(path: '/lazy', page: LazyRoute.page),


     //! Transaction Routes
    AutoRoute(path: '/detail-transaction', page: DetailTransactionRoute.page),
  ];
}
