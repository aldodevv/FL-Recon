import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/router/app_router.dart';

import 'flavors.dart';

class App extends StatelessWidget {
   App({super.key});

  // Inisialisasi router sebagai final field agar tidak dibuat ulang di build()
  final _appRouter =  AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: F.title,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _appRouter.config(),
      builder: (context, child) => _flavorBanner(child: child ?? const SizedBox(), show: kDebugMode),
    );
  }

  Widget _flavorBanner({required Widget child, bool show = true}) => show
      ? Banner(
          location: BannerLocation.topStart,
          message: '${F.name} ${dotenv.env['APP_NAME']}',
          color: Colors.green.withAlpha(150),
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
