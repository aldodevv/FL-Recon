import 'package:equatable/equatable.dart';
import 'package:recon/domain/entitites/balance.dart';

class BalanceState extends Equatable {
  final bool isLoadingBalance;
  final String messageError;
  final List<BalanceHistory> balanceHisList;
  final String lastUpdated;

  const BalanceState({
    required this.isLoadingBalance,
    required this.messageError,
    required this.balanceHisList,
    required this.lastUpdated,
  });

  factory BalanceState.initial() => const BalanceState(
        isLoadingBalance: false,
        messageError: '',
        balanceHisList: [],
        lastUpdated: '-',
      );

  BalanceState copyWith({
    bool? isLoadingBalance,
    String? messageError,
    List<BalanceHistory>? balanceHisList,
    String? lastUpdated,
  }) {
    return BalanceState(
      isLoadingBalance: isLoadingBalance ?? this.isLoadingBalance,
      messageError: messageError ?? this.messageError,
      balanceHisList: balanceHisList ?? this.balanceHisList,
      lastUpdated: lastUpdated ?? this.lastUpdated,

    );
  }

  @override
  List<Object?> get props => [isLoadingBalance, messageError, balanceHisList, lastUpdated];
}
