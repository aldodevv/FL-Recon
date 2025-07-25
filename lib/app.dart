import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.dart';

import 'flavors.dart';

class App extends StatefulWidget {
  const App({super.key});

  // Static router untuk performance - shared instance

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appRouter = AppRouter();
    _init();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _init() async {
    await _registerNavKey();
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
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        // Tambah providers lain di sini
      ],
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
                print('Received deepLink: ${deepLink.uri}');
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
