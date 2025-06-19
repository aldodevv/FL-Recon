import 'package:json_annotation/json_annotation.dart';

part 'genbalance.g.dart';

@JsonSerializable()
class GenBalance {
  final int statusCode;
  final String status;
  final String message;
  final String displayMessage;
  final GenBalanceResponse response;

  GenBalance({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory GenBalance.fromJson(Map<String, dynamic> json) => _$GenBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$GenBalanceToJson(this);
}

@JsonSerializable()
class GenBalanceResponse {
  final double total;
  final String totalDesc;
  final AccountList accountList;

  GenBalanceResponse({
    required this.total,
    required this.totalDesc,
    required this.accountList,
  });

  factory GenBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$GenBalanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenBalanceResponseToJson(this);
}

@JsonSerializable()
class AccountList {
  final AccountCategory accListSaving;
  final AccountCategory accListCurrent;
  final DepositAccountCategory accListDeposit;
  final String lastUpdated;

  AccountList({
    required this.accListSaving,
    required this.accListCurrent,
    required this.accListDeposit,
    required this.lastUpdated,
  });

  factory AccountList.fromJson(Map<String, dynamic> json) =>
      _$AccountListFromJson(json);
  Map<String, dynamic> toJson() => _$AccountListToJson(this);
}

@JsonSerializable()
class AccountCategory {
  final double total;
  final String totalDesc;
  final List<AccountItem>? accList;

  AccountCategory({
    required this.total,
    required this.totalDesc,
    this.accList,
  });

  factory AccountCategory.fromJson(Map<String, dynamic> json) =>
      _$AccountCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$AccountCategoryToJson(this);
}

@JsonSerializable()
class DepositAccountCategory {
  final double total;
  final String totalDesc;
  final String dueDate;
  final List<DepositAccountItem> accList;

  DepositAccountCategory({
    required this.total,
    required this.totalDesc,
    required this.dueDate,
    required this.accList,
  });

  factory DepositAccountCategory.fromJson(Map<String, dynamic> json) =>
      _$DepositAccountCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$DepositAccountCategoryToJson(this);
}

@JsonSerializable()
class AccountItem {
  final String accNo;
  final String accCurrency;
  final String accName;
  final double accBalance;
  final String accType;
  final String accBalanceDesc;

  AccountItem({
    required this.accNo,
    required this.accCurrency,
    required this.accName,
    required this.accBalance,
    required this.accType,
    required this.accBalanceDesc,
  });

  factory AccountItem.fromJson(Map<String, dynamic> json) =>
      _$AccountItemFromJson(json);
  Map<String, dynamic> toJson() => _$AccountItemToJson(this);
}

@JsonSerializable()
class DepositAccountItem extends AccountItem {
  final String accTenor;
  final String accDueDate;
  final String accInterest;

  DepositAccountItem({
    required super.accNo,
    required super.accCurrency,
    required super.accName,
    required super.accBalance,
    required super.accType,
    required super.accBalanceDesc,
    required this.accTenor,
    required this.accDueDate,
    required this.accInterest,
  });

  factory DepositAccountItem.fromJson(Map<String, dynamic> json) =>
      _$DepositAccountItemFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$DepositAccountItemToJson(this);
}
