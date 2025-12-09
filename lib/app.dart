import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/core/handler/network_handler.dart';
import 'package:recon/core/handler/permission_handler.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/core/handler/phone_call_handler.dart';
import 'package:recon/core/services/permission_service.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.dart';
import 'dart:async';
import 'flavors.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final AppRouter _appRouter;
  late PhoneCallHandler _phoneHandler;
  late NetworkHandler _networkHandler;
  late PermissionHandler _permissionHandler;

  // ! First Step for initialize
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appRouter = AppRouter();
    _init();
  }

  // ! Second Step for check cycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("🔥 App FOREGROUND");
        _resumeListeners();
        break;

      case AppLifecycleState.paused:
        debugPrint("🌙 App BACKGROUND");
        _pauseListeners();
        break;

      case AppLifecycleState.inactive:
        debugPrint("⚠️ App INACTIVE");
        _inactiveListeners();
        break;

      case AppLifecycleState.detached:
        debugPrint("🗑️ App DETACHED");
        _detachedListeners();
        break;

      default:
        debugPrint("ℹ️ Unknown lifecycle: $state");
    }
  }

  // ! Last Step for dispose
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _permissionHandler.dispose();
    _dispose();
    super.dispose();
  }

  Future<void> _init() async {
    await _registerNavKey();
    final navKey = getIt<GlobalKey<NavigatorState>>();
    final permissionService = PermissionService();
    _permissionHandler = PermissionHandler(
      navigatorKey: navKey,
      service: permissionService,
    );
    _permissionHandler.start();

    _phoneHandler = PhoneCallHandler(navigatorKey: navKey);
    _networkHandler = NetworkHandler();
    _phoneHandler.start();
    _networkHandler.start();
  }

  Future<void> _dispose() async {
    _phoneHandler.dispose();
    _networkHandler.dispose();
  }

  Future<void> _pauseListeners() async {
    _phoneHandler.resume();
    _networkHandler.resume();
  }

  Future<void> _resumeListeners() async {
    _phoneHandler.pause();
    _networkHandler.pause();
  }

  Future<void> _inactiveListeners() async {
    //
  }
  Future<void> _detachedListeners() async {
    //
  }

  Future<void> _registerNavKey() async {
    if (getIt.isRegistered<GlobalKey<NavigatorState>>()) {
      await getIt.unregister<GlobalKey<NavigatorState>>();
    }
    getIt.registerSingleton<GlobalKey<NavigatorState>>(_appRouter.navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeBloc())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen:
            (previous, current) => previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            themeAnimationDuration: const Duration(milliseconds: 200),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            title: F.title,
            routerConfig: _appRouter.config(
              deepLinkTransformer: DeepLink.prefixStripper(''),
              deepLinkBuilder: (deepLink) {
                debugPrint('Received deepLink: ${deepLink.uri}');
                return deepLink;
              },
            ),
            builder:
                (context, child) => _flavorBanner(
                  child: child ?? const SizedBox.shrink(),
                  show: false,
                ),
          );
        },
      ),
    );
  }

  // Inline conditional untuk performance - no function call overhead
  Widget _flavorBanner({required Widget child, bool show = true}) =>
      show
          ? Banner(
            location: BannerLocation.topEnd,
            message: '${F.name} ${dotenv.env['APP_NAME']}',
            color: Colors.red,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12.0,
              letterSpacing: 1.0,
            ),
            textDirection: TextDirection.ltr,
            child: child,
          )
          : child;
}
