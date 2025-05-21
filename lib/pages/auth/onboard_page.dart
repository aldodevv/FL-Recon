// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/router/app_router.gr.dart';

@RoutePage()
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Onboard")),
      body:  Center(child: Column(
        children: [
          Text("Welcome to Onboard Screen"),
          FilledButton(onPressed: () {context.router.replace(LoginRoute());}, child: Text("Next")),
          _ToolIcon(
                  icon: Icons.date_range,
                  label: 'Date Picker',
                  onTap: DatePickerRoute(),
                ),
        ],
      )),
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
