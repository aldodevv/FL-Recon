import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object?> get props => [];
}

class BalanceRequested extends BalanceEvent {
  final List accountList;
  final List accountType;
  final String currency;
  final String lang;
  final String year;

  const BalanceRequested({
    required this.accountList,
    required this.accountType,
    required this.currency,
    required this.lang,
    required this.year,
  });

  @override
  List<Object> get props {
    return [accountList, accountType, currency, lang, year];
  }
}
