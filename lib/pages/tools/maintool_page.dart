// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/router/app_router.gr.dart';

@RoutePage()
class MaintoolPage extends StatelessWidget {
  final String username;

  const MaintoolPage({super.key, required this.username});
  

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MainTools')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== Tools horizontal scroll icons =====
          SizedBox(
            height: 80, // ⬅️ Tambah tinggi agar tidak overflow
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: const [
                _ToolIcon(
                  icon: Icons.notification_important,
                  label: 'Flushbar',
                  onTap: FlushbarRoute(),
                ),
                _ToolIcon(
                  icon: Icons.settings_applications,
                  label: 'Setting',
                  onTap: SettingRoute(),
                ),
                _ToolIcon(
                  icon: Icons.date_range,
                  label: 'Date Picker',
                  onTap: DatePickerRoute(),
                ),
                _ToolIcon(icon: Icons.security, label: 'Keamanan', onTap: null),
                _ToolIcon(icon: Icons.storage, label: 'Storage', onTap: null),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tooltip(
                    message: 'Base32 Example',
                    child: IconButton(
                      icon: const Icon(Icons.code),
                      onPressed: () {
                        context.pushRoute(Base32Route());
                      },
                    ),
                  ),
                  Tooltip(
                    message: 'Bloc Currency Example',
                    child: IconButton(
                      icon: const Icon(Icons.timeline),
                      onPressed: () {
                        context.pushRoute(TransformerBlocRoute());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final PageRouteInfo? onTap;

  const _ToolIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onTap != null ? () => context.pushRoute(onTap!) : null,
            borderRadius: BorderRadius.circular(12),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue.shade100,
              child: Icon(icon, color: Colors.blue, size: 20),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
