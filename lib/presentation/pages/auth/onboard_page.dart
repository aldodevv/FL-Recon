// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recon/core/services/permission_service.dart';
import 'package:recon/domain/notification/i_local_notification_repository.dart';
import 'package:recon/domain/notification/local_notification_repository.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';

final onboardMenuSections = <OnboardMenuSection>[
  /// AUTH
  OnboardMenuSection(
    title: 'Auth Pages',
    icon: Icons.lock_outline,
    items: [
      OnboardMenuItem(
        title: 'Onboard Page',
        subtitle: 'Entry & showcase page',
        icon: Icons.flag,
        route: const OnboardRoute(),
      ),
      OnboardMenuItem(
        title: 'Forgot Password',
        subtitle: 'Reset password flow',
        icon: Icons.password,
        route: const ForgetpasswordRoute(),
      ),
      OnboardMenuItem(
        title: 'Terms & Condition',
        subtitle: 'Legal & agreement',
        icon: Icons.description,
        route: const TermsconditionRoute(),
      ),
    ],
  ),

  /// GAMES
  OnboardMenuSection(
    title: 'Games',
    icon: Icons.sports_esports,
    items: [
      OnboardMenuItem(
        title: 'Unknow Route',
        subtitle: 'Unknow Route',
        icon: Icons.device_unknown,
        route: const UnknowRoute(),
      ),
      OnboardMenuItem(
        title: 'Memory Match',
        subtitle: 'Card matching game',
        icon: Icons.grid_view,
        route: const MemoryMatchGameRoute(),
      ),
      OnboardMenuItem(
        title: 'Snake Game',
        subtitle: 'Classic snake',
        icon: Icons.drag_indicator,
        route: const SnakeGameRoute(),
      ),
      OnboardMenuItem(
        title: 'Tap The Target',
        subtitle: 'Reflex test game',
        icon: Icons.touch_app,
        route: const TapTheTargetGameRoute(),
      ),
      OnboardMenuItem(
        title: 'Wordle',
        subtitle: 'Guess the word',
        icon: Icons.text_fields,
        route: const WordleGameRoute(),
      ),
    ],
  ),

  /// TOOLS
  OnboardMenuSection(
    title: 'Tools',
    icon: Icons.build,
    items: [
      OnboardMenuItem(
        title: 'Main Tool',
        subtitle: 'Tools entry point',
        icon: Icons.dashboard,
        route: MaintoolRoute(username: 'aldodevv'),
      ),
      OnboardMenuItem(
        title: 'Base32',
        subtitle: 'Encode & decode',
        icon: Icons.code,
        route: const Base32Route(),
      ),
      OnboardMenuItem(
        title: 'Bridging',
        subtitle: 'Platform channel demo',
        icon: Icons.compare_arrows,
        route: const BridgingRoute(),
      ),
      OnboardMenuItem(
        title: 'Flushbar',
        subtitle: 'Notification demo',
        icon: Icons.notifications,
        route: const FlushbarRoute(),
      ),
      OnboardMenuItem(
        title: 'WebView',
        subtitle: 'In-app browser',
        icon: Icons.public,
        route: WebViewRoute(initialUrl: 'https://flutter.dev'),
      ),
      OnboardMenuItem(
        title: 'CAMERA',
        subtitle: 'CAMERA DEMO',
        icon: Icons.camera,
      ),
    ],
  ),

  /// TRANSACTION
  OnboardMenuSection(
    title: 'Transaction',
    icon: Icons.receipt_long,
    items: [
      OnboardMenuItem(
        title: 'Transaction Detail',
        subtitle: 'Detail transaction UI',
        icon: Icons.payments,
        route: const DetailTransactionRoute(),
      ),
    ],
  ),
];

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final ILocalNotificationRepository _localNotification =
      LocalNotificationRepository();

  @override
  void initState() {
    super.initState();
    _geoLocation();
  }

  Future<void> _goToCamera(BuildContext context) async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
    );
    if (!context.mounted) return;
    context.router.push(CameraRoute(cameraDescription: frontCamera));
  }

  Future<void> _geoLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();

    if (!isServiceEnabled) {
      print('tidak enabled');
    }

    if (permission == LocationPermission.denied) {
      PermissionService().request(Permission.location);
    }

    return await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        )
        .then((value) async {
          await _localNotification.show(
            1,
            'Lokasi Ditemukan',
            'Lat : ${value.latitude}, Long : ${value.longitude}',
            payload: 'Location Berhasil',
          );
        })
        .catchError((e) {
          print('error lokasi: $e');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🚀 Onboard Hub')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: onboardMenuSections.length,
        separatorBuilder: (_, _) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final section = onboardMenuSections[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(section.icon, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              ...section.items.map(
                (item) => Card(
                  child: ListTile(
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      if (item.title == 'CAMERA') {
                        _goToCamera(context);
                      } else if (item.onTap != null) {
                        item.onTap!();
                      } else if (item.route != null) {
                        context.router.push(item.route!);
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class OnboardMenuSection {
  final String title;
  final IconData icon;
  final List<OnboardMenuItem> items;

  const OnboardMenuSection({
    required this.title,
    required this.icon,
    required this.items,
  });
}

class OnboardMenuItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final PageRouteInfo? route;
  final VoidCallback? onTap;

  const OnboardMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.route,
    this.onTap,
  });
}
