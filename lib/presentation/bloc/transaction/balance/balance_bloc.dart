import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/core/constants/app_url.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/domain/balance/general/genbalance.dart';
import 'package:recon/domain/balance/history/balance.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_event.dart';
import 'package:recon/presentation/bloc/transaction/balance/balance_state.dart';

@injectable
class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc(): super(BalanceState.initial()) {
    on<BalanceRequested>(_onHandleBalance, transformer: concurrent());
    on<GeneralBalance>(_getGeneralBalance, transformer: concurrent());
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
      final balanceResponse = BalanceResponseEntity.fromJson(response.data);
      final BalanceEntity balance = balanceResponse.response;
      emit(state.copyWith(isLoadingBalance: false, balanceHisList: balance.balanceHisList, lastUpdated: balance.lastUpdated));
    } catch (e) {
      emit(
        state.copyWith(isLoadingBalance: false, messageError: '$e')
      );
    }
  }

  void _getGeneralBalance(
    GeneralBalance event,
    Emitter<BalanceState> emit,
  ) async {
    emit(state.copyWith(isLoadingGeneralBalance: true));
    final String? token = await Utils.storageSecure.read(key: 'token');
    try {
      final response = await DioApp.instance.get(
        '${AppUrl.DashboardV1_2_0}/private/general/balance/${event.lang}/${event.currency}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          }
        )
      );

      final data = response.data;
      final genBalance = GenBalance.fromJson(data);

      emit(
        state.copyWith(
          isLoadingGeneralBalance: false,
          generalBalance: genBalance
        )
      );

    } catch (e) {
      emit(
        state.copyWith(isLoadingGeneralBalance: false, messageErrorGeneral: '$e')
      );
    }
  }
}