import 'package:equatable/equatable.dart';

abstract class HistorytransEvent extends Equatable {
  const HistorytransEvent();

  @override
  List<Object?> get props => [];
}

class HistoryTransRequested extends HistorytransEvent {
  final List<String> accountList;
  final List<String> accountType;
  final String currency;
  final String lang;
  final String year;

  const HistoryTransRequested({
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