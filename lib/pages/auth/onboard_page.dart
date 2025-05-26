// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/router/app_router.gr.dart';
import 'package:recon/widgets/badge/infobadge_widget.dart';
import 'package:recon/widgets/section/infosection_widget.dart';

@RoutePage()
class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Onboard")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Welcome to Onboard Screen"),
            FilledButton(
              onPressed: () {
                context.router.replace(LoginRoute());
              },
              child: Text("Next"),
            ),
            _ToolIcon(
              icon: Icons.date_range,
              label: 'Date Picker',
              onTap: DatePickerRoute(),
            ),

            InfoSectionWidget(
              text: "Total Transfer",
              value: 999,
              size: 12,
              leftIcon: Icons.money,
              rightIcon: Icons.arrow_forward_ios,
              backgroundColor: Colors.orange.shade50,
              borderColor: Colors.orange,
              iconColor: Colors.orange,
              textColor: Colors.orange.shade900,
              valueColor: Colors.deepOrange,
              onTap: () {
                debugPrint("Custom tapped");
              },
            ),

            const StatusBadgeWidget(
              text: "90.00%",
              colorType: BadgeColorType.blue,
              size: BadgeSize.medium,
            ),

            const StatusBadgeWidget(
              text: "Gagal",
              colorType: BadgeColorType.red,
              size: BadgeSize.small,
              showBorder: true,
            ),

            const StatusBadgeWidget(
              child: Icon(Icons.check_circle_outline, size: 18),
              colorType: BadgeColorType.green,
              size: BadgeSize.small,
            ),
          ],
        ),
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
