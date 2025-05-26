import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/bloc/theme/theme_bloc.dart';
import 'package:recon/router/app_router.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => ThemeBloc(), child: const IntiApp());
  }
}

class IntiApp extends StatelessWidget {
  const IntiApp({super.key});

  static final _appRouter = AppRouter(); // Static untuk performance

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        print("pler ${state.themeMode}");
        return MaterialApp.router(
          themeAnimationDuration: const Duration(
            milliseconds: 100,
          ),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          title: F.title,
          routerConfig: _appRouter.config(),
          builder: (context, child) => _flavorBanner(child: child ?? const SizedBox(), show: false),
        );
      },
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
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
