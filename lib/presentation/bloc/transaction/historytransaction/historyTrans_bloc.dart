import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/core/constants/app_url.dart';
import 'package:recon/core/network/dio_app.dart';
import 'package:recon/core/utils/utils.dart';
import 'package:recon/domain/entitites/history.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_event.dart';
import 'package:recon/presentation/bloc/transaction/historytransaction/historyTrans_state.dart';

@injectable
class HistorytransBloc extends Bloc<HistorytransEvent, HistorytransState> {
  HistorytransBloc(): super(HistorytransState.initial()) {
    on<HistoryTransRequested>(_onHandleHistory, transformer: sequential());
  }
  
  void _onHandleHistory(
    HistoryTransRequested event,
    Emitter<HistorytransState> emit,
  ) async {
    emit(state.copyWith(isLoadingHistory: true));
    final String? token = await Utils.storageSecure.read(key: 'token');

    try {
      final response = await DioApp.instance.post(
        '${AppUrl.DashboardV2_1}/private/general/history/transaction',
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
      final historyData = HistoryResponseEntity.fromJson(response.data);
      emit(state.copyWith(historyData: historyData.response.tranHisList, lastUpdated: historyData.response.lastUpdated));
    } catch (e) {
      emit(
        state.copyWith(isLoadingHistory: false, messageError: '$e')
      );
    }
  }
}