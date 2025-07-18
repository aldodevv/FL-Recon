import 'package:equatable/equatable.dart';

abstract class BalanceEvent extends Equatable {
  const BalanceEvent();

  @override
  List<Object?> get props => [];
}

class BalanceRequested extends BalanceEvent {
  final List<String> accountList;
  final List<String> accountType;
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

class GeneralBalance extends BalanceEvent {
  final String lang;
  final String currency;

  const GeneralBalance({
    required this.lang,
    required this.currency
  });

  @override
  List<Object> get props {
    return [currency, lang];
  }
}
