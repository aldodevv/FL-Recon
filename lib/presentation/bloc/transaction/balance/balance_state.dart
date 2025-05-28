import 'package:equatable/equatable.dart';

class BalanceState extends Equatable {
  final bool isLoadingBalance;
  final String messageError;

  const BalanceState({
    required this.isLoadingBalance,
    required this.messageError,
  });

  factory BalanceState.initial() => const BalanceState(
        isLoadingBalance: false,
        messageError: '',
      );

  BalanceState copyWith({
    bool? isLoadingBalance,
    String? messageError,
  }) {
    return BalanceState(
      isLoadingBalance: isLoadingBalance ?? this.isLoadingBalance,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [isLoadingBalance, messageError];
}
