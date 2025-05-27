// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:recon/bloc/theme/theme_bloc.dart';
import 'package:recon/constant/colors_const.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';
import 'package:recon/presentation/widgets/section/infosection_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  String? responseLog;

  @override
  void initState() {
    super.initState();
    _fetchUIData();
  }

  Future<void> _fetchUIData() async {
    try {
      final response = await DioApp.instance.get(
        '/ui/v1.1.0/public/userInterface/ID',
      );

      setState(() {
        responseLog = response.data.toString();
      });

      // Log ke console
      debugPrint('✅ API Response:\n${response.data}');
    } catch (e, stackTrace) {
      debugPrint('❌ API Error: $e\n$stackTrace');
    }
  }
  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.select(
      (ThemeBloc bloc) => bloc.state.themeMode,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Onboard")),
      body: BlocSelector<ThemeBloc, ThemeState, ThemeMode>(
        selector: (state) => state.themeMode,
        builder: (context, currentThemeMode) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                RadioListTile<ThemeMode>(
                  title: const Text('Light'),
                  value: ThemeMode.light,
                  groupValue: currentThemeMode,
                  onChanged: (val) {
                    if (val != null) {
                      context.read<ThemeBloc>().add(ThemeEvent.light);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('Dark'),
                  value: ThemeMode.dark,
                  groupValue: currentThemeMode,
                  onChanged: (val) {
                    if (val != null) {
                      context.read<ThemeBloc>().add(ThemeEvent.dark);
                    }
                  },
                ),
                RadioListTile<ThemeMode>(
                  title: const Text('System'),
                  value: ThemeMode.system,
                  groupValue: currentThemeMode,
                  onChanged: (val) {
                    if (val != null) {
                      context.read<ThemeBloc>().add(ThemeEvent.system);
                    }
                  },
                ),
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
                  onTap: () {
                    debugPrint("Custom tapped");
                  },
                ),

                StatusBadgeWidget(
                  text: 'In Progress',
                  colorType: ColorType.orange,
                  size: BadgeSize.small,
                  showBorder: true,
                ),

                const StatusBadgeWidget(
                  text: "Gagal",
                  colorType: ColorType.red,
                  size: BadgeSize.small,
                  showBorder: true,
                ),

                const StatusBadgeWidget(
                  child: Icon(Icons.check_circle_outline, size: 18),
                  colorType: ColorType.green,
                  size: BadgeSize.small,
                ),
              ],
            ),
          );
        },
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
