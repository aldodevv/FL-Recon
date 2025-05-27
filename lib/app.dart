import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/app_theme.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.dart';

import 'flavors.dart';


class App extends StatelessWidget {
  const App({super.key});

  // Static router untuk performance - shared instance
  static final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        // Tambah providers lain di sini
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        buildWhen: (previous, current) => previous.themeMode != current.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            themeAnimationDuration: const Duration(milliseconds: 100),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            title: F.title,
            routerConfig: _appRouter.config(),
            builder: (context, child) => _flavorBanner(
              child: child ?? const SizedBox.shrink(),
              show: false,
            ),
          );
        },
      ),
    );
  }

  // Inline conditional untuk performance - no function call overhead
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