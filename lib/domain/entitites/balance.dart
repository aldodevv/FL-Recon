import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class BalanceResponseEntity {
  final int statusCode;
  final String status;
  final String message;
  final String displayMessage;
  final BalanceEntity response;

  BalanceResponseEntity({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory BalanceResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BalanceResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceResponseEntityToJson(this);
}

@JsonSerializable()
class BalanceEntity {
  final List<BalanceHistory> balanceHisList;

  @JsonKey(name: 'lastUpdated')
  final String lastUpdated;

  BalanceEntity({
    required this.balanceHisList,
    required this.lastUpdated,
  });

  factory BalanceEntity.fromJson(Map<String, dynamic> json) =>
      _$BalanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceEntityToJson(this);
}


@JsonSerializable()
class BalanceHistory {
  final int balance;
  final int month;
  final String accountType;

  BalanceHistory({
    required this.balance,
    required this.month,
    required this.accountType,
  });

  factory BalanceHistory.fromJson(Map<String, dynamic> json) =>
      _$BalanceHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$BalanceHistoryToJson(this);
}
