import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/presentation/bloc/me/me_bloc.dart';
import 'package:recon/presentation/bloc/me/me_event.dart';
import 'package:recon/presentation/bloc/me/me_state.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_bloc.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_event.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_bloc.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_event.dart';
import 'package:recon/presentation/pages/home/widgets/RowInformasi.dart';
import 'package:recon/presentation/pages/home/widgets/SaldoCard.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final BalanceBloc _balanceBloc = getIt<BalanceBloc>();
  late final HistorytransBloc _historytransBloc = getIt<HistorytransBloc>();
  late final MeBloc _meBloc = getIt<MeBloc>();

  @override
  void initState() {
    super.initState();
    _getBalance();
    _getHistory();
    _getMe();
  }

  void _getBalance() {
    _balanceBloc.add(
      BalanceRequested(
        accountList: ['ALL'],
        accountType: ["CA", "TD", "SA"],
        currency: "IDR",
        lang: "ID",
        year: "2025",
      ),
    );
  }

  void _getHistory() {
    _historytransBloc.add(
      HistoryTransRequested(
        accountList: ['ALL'],
        accountType: ["CA", "TD", "SA"],
        currency: "IDR",
        lang: "ID",
        year: "2025",
      ),
    );
  }

  void _getMe() {
    _meBloc.add(MeGet());
  }

  @override
  void dispose() {
    _balanceBloc.close();
    _historytransBloc.close();
    _meBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BalanceBloc>.value(value: _balanceBloc),
        BlocProvider<HistorytransBloc>.value(value: _historytransBloc),
        BlocProvider<MeBloc>.value(value: _meBloc),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://qlola-uat.dev.bri.co.id/api/general/v2.0/public/banner/image/d482b907-62a8-4e03-84b4-8db21e610e5b',
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              BlocBuilder<MeBloc, MeState>(
                                builder: (context, state) {
                                  if (state.username == '' ||
                                      state.corporateName == '') {
                                    return const Text(
                                      'Gagal memuat informasi user',
                                    );
                                  }
                                  return InformasiRow(
                                    greeting: 'Selamat Datang',
                                    companyName: state.corporateName,
                                    logoAssetPath:
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg/500px-Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg",
                                    notificationCount: 12,
                                    onNotificationTap:
                                        () => print('Notifikasi ditekan'),
                                    onSearchTap: () => print('Cari ditekan'),
                                  );
                                },
                              ),
                              Saldocard(
                                title: 'Total Saldo',
                                currencySymbol: 'IDR',
                                value: '9.999.000.000.000',
                                dateTime: '14 Feb 2025, 13:53',
                                isHidden: false,
                                onToggleVisibility: () {},
                                onTapDetail: () {},
                                selectedCurrency: 'IDR',
                                onCurrencyChange: (val) {},
                              ),
                              const SizedBox(height: 20),

                              // Tambahkan komponen lain di bawah sini
                              // e.g. history list, card lainnya, dll
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
