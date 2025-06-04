import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/presentation/bloc/me/me_bloc.dart';
import 'package:recon/presentation/bloc/me/me_event.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_bloc.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_event.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_state.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_bloc.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_event.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_state.dart';
import 'package:recon/presentation/pages/home/widgets/home.dart';

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
    _getGeneralBalance();
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

  void _getGeneralBalance() {
    _balanceBloc.add(GeneralBalance(lang: 'ID', currency: 'IDR'));
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<BalanceBloc, BalanceState>(listener: (context, state) {
            if (state.isLoadingBalance) {
              Center(child: CircularProgressIndicator());
            }
          }),
          BlocListener<HistorytransBloc, HistorytransState>(listener: (context, state) {
            if (state.isLoadingHistory) {
              Center(child: CircularProgressIndicator());
            }
          }),
        ],
        child: Home(),
      ),
    );
  }
}
