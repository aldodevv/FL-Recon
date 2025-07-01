// pages/home_screen.dart
import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:recon/core/constants/colors_const.dart';
import 'package:recon/core/constants/images_const.dart';
import 'package:recon/domain/entitites/ui/entity_language.dart';
import 'package:recon/domain/repositories/ui_repository.dart';
import 'package:recon/presentation/bloc/theme/theme_bloc.dart';
import 'package:recon/presentation/routes/app_router.gr.dart';
import 'package:recon/presentation/widgets/badge/infobadge_widget.dart';
import 'package:recon/presentation/widgets/button/button_currency_widget.dart';
import 'package:recon/presentation/widgets/card/accounttransfercard_widget.dart';
import 'package:recon/presentation/widgets/card/card_ringkasan_widget.dart';
import 'package:recon/presentation/widgets/card/saldobadgecard_widget.dart';
import 'package:recon/presentation/widgets/card/transactionschedulecard_widget.dart';
import 'package:recon/presentation/widgets/chart/piedonutchart_widget.dart';
import 'package:recon/presentation/widgets/section/dateofweeksection_widget.dart';
import 'package:recon/presentation/widgets/section/dividersection_widget.dart';
import 'package:recon/presentation/widgets/section/infosection_widget.dart';
import 'package:recon/presentation/widgets/section/profile_home_widget.dart';
import 'package:recon/presentation/widgets/section/summarysection_widget.dart';

@RoutePage()
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  String? responseLog;
  StreamSubscription<int>? _subscription;
  int _counter = 0;
  Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void initState() {
    super.initState();
    // Simulasi fetch API async
        _loadUIData();

    // Simulasi stream data, misal event dari server atau sensor
    Stream<int> stream = Stream.periodic(
      Duration(seconds: 1),
      (x) => x,
    ).take(10);
    _subscription = stream.listen((event) {
      setState(() {
        _counter = event;
      });
      print("Stream event: $event $_counter");
    });

    // _fetchUIData();
  }

  @override
  void dispose() {
    print("dispose - bersihkan subscription stream $_counter");
    _subscription?.cancel();
    super.dispose();
  }

Future<void> _loadUIData() async {
    final result = await UiLanguageRepository().getUIData();

    result.fold(
      (failure) {
        // ❌ Sudah dihandle oleh DioApp (modal, logout, dll), tinggal log kalau perlu
        debugPrint('Gagal ambil data: ${failure.message}');
      },
      (response) {
        try {
          final uiResponse = EntityLanguage.fromJson(response as Map<String, dynamic>);

          setState(() {
            responseLog = uiResponse.toJson().toString();
          });

          for (final item in uiResponse.response) {
            debugPrint('${item.id} - ${item.label} - ${item.group}');
          }
        } catch (e, stack) {
          debugPrint('❌ Parsing error: $e\n$stack');
        }
      },
    );
  }

  List<PieChartSectionData> sections = [
    PieChartSectionData(
      value: 60,
      title: '60%',
      color: Colors.blue,
      radius: 50,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
      titlePositionPercentageOffset: 0.5,
    ),
    PieChartSectionData(
      value: 40,
      title: '40%',
      color: Colors.red,
      radius: 50,
      titleStyle: const TextStyle(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.bold,
      ),
      titlePositionPercentageOffset: 0.5,
    ),
  ];

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
                      context.router.replace(DetailTransactionRoute());
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
                    size: BadgeSize.small,
                    colorType: ColorType.red,
                    child: Icon(Icons.check_circle_outline, size: 18),
                  ),
                  DividersectionWidget(size: 1.5),
                  PiedonutchartWidget(
                    size: 200,
                    sections: sections,
                    centerText: 'Februari',
                    onSectionTapped: (index, position) {
                      print('Tapped section $index at $position');
                    },
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
                  DateofweeksectionWidget(
                    initialDate: DateTime.now(),
                    onDateSelected: (date) {
                      print('Selected date: ${date.toString()}');
                      // Handle date selection
                    },
                  ),

                  DividersectionWidget(size: 1.5),
                  // Example 1: Exact replica from image
                  SaldoBadgeCardWidget(
                    title: 'Deposito',
                    amount: 'IDR 999.153.000.000.000,00',
                    leftColor: const Color(0xFFEA580C), // Orange color
                    size: BadgeSize.medium,
                    badges: [
                      BadgeData(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.credit_card,
                              size: 14,
                              color: Color(0xFF6B7280),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '2 Rekening',
                              style: TextStyle(color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        colorType: ColorType.blue,
                      ),
                      BadgeData(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.percent,
                              size: 14,
                              color: Color(0xFF6B7280),
                            ),
                            SizedBox(width: 4),
                            Text(
                              '10.00%',
                              style: TextStyle(color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                        colorType: ColorType.blue,
                      ),
                    ],
                    onTap: () => print('Deposito tapped'),
                  ),

                  const SizedBox(height: 16),

                  // Example 2: Different variations
                  SaldoBadgeCardWidget(
                    title: 'Tabungan',
                    amount: 'IDR 50.000.000,00',
                    leftColor: const Color(0xFF16A34A), // Green color
                    size: BadgeSize.small,
                    badges: [
                      BadgeData(text: 'Aktif', colorType: ColorType.green),
                      BadgeData(text: '5.5%', colorType: ColorType.blue),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ButtonCurrencyWidget(value: 'IDR', onChangeFlag: (){}),
                  const SizedBox(height: 16),

                  CardRingkasanWidget(
                      value1: "IDR 1.000.000",
                      value2: "IDR 5.000.000",
                      percentage1: "90.00%",
                      percentage2: "10.00%",
                      label: "Giro",
                      label2: "Deposito",
                      showPercentage1: true,
                      showPercentage2: true, // untuk sembunyikan badge
                    ),
                  CardRingkasanWidget(
                      value1: "IDR 1.000.000",
                      value2: "IDR 5.000.000",
                      label: "Giro",
                      label2: "Deposito", // untuk sembunyikan badge
                    ),

                  ProfileHomeWidget(valueName: 'Jhon Doe'),

                  const SizedBox(height: 16),
                  // Example 3: Large size
                  SaldoBadgeCardWidget(
                    title: 'Investasi',
                    amount: 'IDR 1.250.000.000,00',
                    leftColor: const Color(0xFFDC2626), // Red color
                    size: BadgeSize.large,
                    badges: [
                      BadgeData(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.trending_up, size: 16),
                            SizedBox(width: 4),
                            Text('High Risk'),
                          ],
                        ),
                        colorType: ColorType.red,
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
                       context.router.replace(TermsconditionRoute());
                      debugPrint("Detail pressed");
                    },
                  ),
                  DividersectionWidget(size: 1.5),
                  Row(
                    children: [
                      AccounttransfercardWidget(
                        logoUrl: AppImages.logoQlola,
                        title: 'Rachman Hakim',
                        desc: '123456789012345',
                        badgeText: 'USD',
                        badgeColor: ColorType.blue,
                        badgeSize: BadgeSize.small,
                      ),
                      AccounttransfercardWidget(
                        logoUrl: AppImages.logoQlola,
                        title: 'Rachman Hakim',
                        desc: '123456789012345',
                        badgeText: 'USD',
                        badgeColor: ColorType.blue,
                        badgeSize: BadgeSize.small,
                      ),
                    ],
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
