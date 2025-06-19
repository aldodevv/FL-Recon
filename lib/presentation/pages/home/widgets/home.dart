import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/presentation/bloc/me/me_bloc.dart';
import 'package:recon/presentation/bloc/me/me_state.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_bloc.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_state.dart';
import 'package:recon/presentation/pages/home/widgets/RowInformasi.dart';
import 'package:recon/presentation/pages/home/widgets/SaldoCard.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        BlocBuilder<MeBloc, MeState>(
                          builder: (context, state) {                            
                            return InformasiRow(
                              greeting: 'Selamat Datang',
                              companyName: state.username,
                              logoAssetPath:
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg/500px-Kantor_Pusat_Bank_Rakyat_Indonesia_%282025%29.jpg",
                              notificationCount: 12,
                              onNotificationTap: () => print('Notifikasi ditekan'),
                              onSearchTap: () => print('Cari ditekan'),
                            );
                          },
                        ),
                        BlocBuilder<BalanceBloc, BalanceState>(
                          builder: (context, state) {
                            final currentAccounts = state.generalBalance
                                    ?.response.accountList.accListCurrent.accList ??
                                [];
                            final depositAccounts = state.generalBalance
                                    ?.response.accountList.accListDeposit.accList ??
                                [];

                            final totalGiroBalance = currentAccounts.isNotEmpty
                                ? currentAccounts.fold<double>(
                                    0.0,
                                    (sum, acc) => sum + (acc.accBalance ?? 0.0),
                                  )
                                : 0.0;

                            final totalDepositoBalance = depositAccounts.isNotEmpty
                                ? depositAccounts.fold<double>(
                                    0.0,
                                    (sum, acc) => sum + (acc.accBalance ?? 0.0),
                                  )
                                : 0.0;

                            final totalSaldo = totalGiroBalance + totalDepositoBalance;

                            final lastUpdated =
                                state.generalBalance?.response.accountList.lastUpdated ?? '';

                            final totalSaldoFormatted = Utils.convertMoney(totalSaldo, 'IDR');
                            return Saldocard(
                              title: 'Total Saldo',
                              currencySymbol: 'IDR',
                              value: '$totalSaldoFormatted',
                              dateTime: lastUpdated,
                              isHidden: false,
                              onToggleVisibility: () {},
                              onTapDetail: () {},
                              selectedCurrency: 'IDR',
                              onCurrencyChange: (val) {},
                            );
                          },
                        ),
                        const SizedBox(height: 20),

                        // Tambahkan komponen lain di bawah sini jika perlu
                        // Misal history list, dll
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
