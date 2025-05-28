// pages/home_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';
import 'package:recon/presentation/widgets/card/transactionschedulecard_widget.dart';
import 'package:recon/presentation/widgets/section/dividersection_widget.dart';
import 'package:recon/presentation/widgets/section/infosection_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/presentation/widgets/section/summarysection_widget.dart';

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  String? responseLog;
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

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
      logger.i(response);
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
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                spacing: 10,
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
                    colorType: ColorType.green,
                    rightIcon: Icons.arrow_forward_ios,
                    onTap: () {
                      debugPrint("Custom tapped");
                    },
                  ),
                  DividersectionWidget(size: 1.5),
                  StatusBadgeWidget(
                    text: 'In Progress',
                    size: BadgeSize.small,
                    colorType: ColorType.orange,
                    showBorder: true,
                  ),

                  const StatusBadgeWidget(
                    text: "Gagal",
                    size: BadgeSize.small,
                    colorType: ColorType.blue,
                    showBorder: true,
                  ),

                  const StatusBadgeWidget(
                    child: Icon(Icons.check_circle_outline, size: 18),
                    size: BadgeSize.small,
                    colorType: ColorType.red,
                  ),
                  DividersectionWidget(size: 1.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SummarysectionWidget(
                        label: "Daily",
                        type: SummarysectionType.harian,
                        value: 100,
                        icon: Icons.date_range,
                        iconSize: 24,
                        fontSize: 10,
                      ),
                      SummarysectionWidget(
                        label: "Success",
                        type: SummarysectionType.success,
                        value: 80,
                        iconSize: 24,
                        fontSize: 10,
                      ),
                      SummarysectionWidget(
                        label: "Process",
                        type: SummarysectionType.diproses,
                        value: 10,
                        iconSize: 24,
                        fontSize: 10,
                      ),
                      SummarysectionWidget(
                        label: "Failed",
                        type: SummarysectionType.gagal,
                        value: 5,
                        iconSize: 24,
                        fontSize: 10,
                      ),
                    ],
                  ),

                  DividersectionWidget(size: 1.5),

                  TransactionschedulecardWidget(
                    dateTime: '28 Mei 2025 14:45:10',
                    statusText: "Pending Signer",
                    statusColorType: ColorType.orange,
                    transactionId: "2361728374819",
                    description: "Transfer Sesama BRI",
                    amount: "IDR 99.999.000.000",
                    detailTitle: "Lihat Detail",
                    onPressDetail: () {
                      // Aksi ketika diklik
                      debugPrint("Detail pressed");
                    },
                  ),
                  TransactionschedulecardWidget(
                    dateTime: '28 Mei 2025 14:45:10',
                    statusText: "Pending Signer",
                    statusColorType: ColorType.orange,
                    transactionId: "2361728374819",
                    description: "Transfer Sesama BRI",
                    amount: "IDR 99.999.000.000",
                    detailTitle: "Lihat Detail",
                    onPressDetail: () {
                      // Aksi ketika diklik
                      debugPrint("Detail pressed");
                    },
                  ),
                  TransactionschedulecardWidget(
                    dateTime: '28 Mei 2025 14:45:10',
                    statusText: "Pending Signer",
                    statusColorType: ColorType.orange,
                    transactionId: "2361728374819",
                    description: "Transfer Sesama BRI",
                    amount: "IDR 99.999.000.000",
                    detailTitle: "Lihat Detail",
                    onPressDetail: () {
                      // Aksi ketika diklik
                      debugPrint("Detail pressed");
                    },
                  ),
                ],
              ),
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
