import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/constants/app_url.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_event.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc(): super(BalanceState.initial()) {
    on<BalanceRequested>(_onHandleBalance, transformer: sequential());
  }
  
  void _onHandleBalance(
    BalanceRequested event,
    Emitter<BalanceState> emit,
  ) async {
      emit(state.copyWith(isLoadingBalance: true));
      final String? token = await Utils.storageSecure.read(key: 'token');
    try {
      final response = await DioApp.instance.post(
        '${AppUrl.DashboardV2_1}/private/general/history/balance',
        data: {
          "accountList": event.accountList,
          "accountType": event.accountType,
          "currencyCode": event.currency,
          "lang": event.lang
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );
      print('HAI: ${response.data}');
      emit(state.copyWith(isLoadingBalance: false));
    } catch (e) {
      emit(
        state.copyWith(isLoadingBalance: false, messageError: '$e')
      );
    }
  }
}