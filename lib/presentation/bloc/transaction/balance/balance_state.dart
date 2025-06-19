import 'package:equatable/equatable.dart';
import 'package:recon/domain/balance/general/genbalance.dart';
import 'package:recon/domain/balance/history/balance.dart';

class BalanceState extends Equatable {
  final bool isLoadingBalance;
  final String messageError;
  final List<BalanceHistory> balanceHisList;
  final String lastUpdated;
  // general balance
  final bool isLoadingGeneralBalance;
  final String messageErrorGeneral;
  final GenBalance? generalBalance;

  const BalanceState({
    required this.isLoadingBalance,
    required this.messageError,
    required this.balanceHisList,
    required this.lastUpdated,
    // general balance
    required this.isLoadingGeneralBalance,
    required this.messageErrorGeneral,
    this.generalBalance,
  });

  factory BalanceState.initial() => const BalanceState(
    isLoadingBalance: false,
    messageError: '',
    balanceHisList: [],
    lastUpdated: '-',
    // general balance
    isLoadingGeneralBalance: false,
    messageErrorGeneral: '',
    generalBalance: null,
  );

  BalanceState copyWith({
    bool? isLoadingBalance,
    String? messageError,
    List<BalanceHistory>? balanceHisList,
    String? lastUpdated,
    // general balance
    bool? isLoadingGeneralBalance,
    String? messageErrorGeneral,
    GenBalance? generalBalance,
  }) {
    return BalanceState(
      isLoadingBalance: isLoadingBalance ?? this.isLoadingBalance,
      messageError: messageError ?? this.messageError,
      balanceHisList: balanceHisList ?? this.balanceHisList,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isLoadingGeneralBalance:
          isLoadingGeneralBalance ?? this.isLoadingGeneralBalance,
      messageErrorGeneral: messageErrorGeneral ?? this.messageErrorGeneral,
      generalBalance: generalBalance ?? this.generalBalance,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingBalance,
    messageError,
    balanceHisList,
    lastUpdated,
    isLoadingGeneralBalance,
    messageErrorGeneral,
    generalBalance,
  ];
}
