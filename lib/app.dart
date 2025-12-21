import 'package:flutter_alice/alice.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/core/handler/network_handler.dart';
import 'package:recon/core/handler/permission_handler.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/core/handler/phone_call_handler.dart';
import 'package:recon/core/services/permission_service.dart';
import 'package:recon/core/utils/log_navigator_util.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.dart';
import 'dart:async';
import 'flavors.dart';
import 'package:overlay_support/overlay_support.dart';

class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final AppRouter _appRouter;
  // ignore: unused_field
  late final Alice _alice;
  late PhoneCallHandler _phoneHandler;
  late NetworkHandler _networkHandler;
  late PermissionHandler _permissionHandler;

  final _rootNavigatorKey = GlobalKey<NavigatorState>();

  // ! First Step for initialize
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _alice = Alice(showInspectorOnShake: true, navigatorKey: _rootNavigatorKey);
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
    final permissionService = PermissionService();
    _permissionHandler = PermissionHandler(
      navigatorKey: _rootNavigatorKey,
      service: permissionService,
    );
    _permissionHandler.start();

    _phoneHandler = PhoneCallHandler(navigatorKey: _rootNavigatorKey);
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
    getIt.registerSingleton<GlobalKey<NavigatorState>>(_rootNavigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ThemeBloc())],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) => previous.themeMode != current.themeMode,
        builder: (context, state) {
          return OverlaySupport(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              themeAnimationDuration: const Duration(milliseconds: 200),
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              title: F.title,
              routerConfig: _appRouter.config(
                navigatorObservers: () => [RouteLogger()],
                deepLinkTransformer: DeepLink.prefixStripper(''),
                deepLinkBuilder: (deepLink) {
                  debugPrint('Received deepLink: ${deepLink.uri}');
                  return deepLink;
                },
              ),
              builder: (context, child) {
                return child ?? const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
