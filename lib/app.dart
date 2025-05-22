import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/router/app_router.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: F.title,
      theme: AppTheme.lightTheme,          // 💡 Use light theme
      darkTheme: AppTheme.darkTheme,       // 💡 Use dark theme
      themeMode: ThemeMode.system,         // 🌗 Automatically switch based on system
      routerConfig: _appRouter.config(),
      builder: (context, child) => _flavorBanner(child: child ?? const SizedBox(), show: false),
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