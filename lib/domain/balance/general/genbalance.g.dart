// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genbalance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenBalance _$GenBalanceFromJson(Map<String, dynamic> json) => GenBalance(
  statusCode: (json['statusCode'] as num).toInt(),
  status: json['status'] as String,
  message: json['message'] as String,
  displayMessage: json['displayMessage'] as String,
  response: GenBalanceResponse.fromJson(
    json['response'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$GenBalanceToJson(GenBalance instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'status': instance.status,
      'message': instance.message,
      'displayMessage': instance.displayMessage,
      'response': instance.response,
    };

GenBalanceResponse _$GenBalanceResponseFromJson(Map<String, dynamic> json) =>
    GenBalanceResponse(
      total: (json['total'] as num).toDouble(),
      totalDesc: json['totalDesc'] as String,
      accountList: AccountList.fromJson(
        json['accountList'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$GenBalanceResponseToJson(GenBalanceResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalDesc': instance.totalDesc,
      'accountList': instance.accountList,
    };

AccountList _$AccountListFromJson(Map<String, dynamic> json) => AccountList(
  accListSaving: AccountCategory.fromJson(
    json['accListSaving'] as Map<String, dynamic>,
  ),
  accListCurrent: AccountCategory.fromJson(
    json['accListCurrent'] as Map<String, dynamic>,
  ),
  accListDeposit: DepositAccountCategory.fromJson(
    json['accListDeposit'] as Map<String, dynamic>,
  ),
  lastUpdated: json['lastUpdated'] as String,
);

Map<String, dynamic> _$AccountListToJson(AccountList instance) =>
    <String, dynamic>{
      'accListSaving': instance.accListSaving,
      'accListCurrent': instance.accListCurrent,
      'accListDeposit': instance.accListDeposit,
      'lastUpdated': instance.lastUpdated,
    };

AccountCategory _$AccountCategoryFromJson(Map<String, dynamic> json) =>
    AccountCategory(
      total: (json['total'] as num).toDouble(),
      totalDesc: json['totalDesc'] as String,
      accList:
          (json['accList'] as List<dynamic>?)
              ?.map((e) => AccountItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AccountCategoryToJson(AccountCategory instance) =>
    <String, dynamic>{
      'total': instance.total,
      'totalDesc': instance.totalDesc,
      'accList': instance.accList,
    };

DepositAccountCategory _$DepositAccountCategoryFromJson(
  Map<String, dynamic> json,
) => DepositAccountCategory(
  total: (json['total'] as num).toDouble(),
  totalDesc: json['totalDesc'] as String,
  dueDate: json['dueDate'] as String,
  accList:
      (json['accList'] as List<dynamic>)
          .map((e) => DepositAccountItem.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DepositAccountCategoryToJson(
  DepositAccountCategory instance,
) => <String, dynamic>{
  'total': instance.total,
  'totalDesc': instance.totalDesc,
  'dueDate': instance.dueDate,
  'accList': instance.accList,
};

AccountItem _$AccountItemFromJson(Map<String, dynamic> json) => AccountItem(
  accNo: json['accNo'] as String,
  accCurrency: json['accCurrency'] as String,
  accName: json['accName'] as String,
  accBalance: (json['accBalance'] as num).toDouble(),
  accType: json['accType'] as String,
  accBalanceDesc: json['accBalanceDesc'] as String,
);

Map<String, dynamic> _$AccountItemToJson(AccountItem instance) =>
    <String, dynamic>{
      'accNo': instance.accNo,
      'accCurrency': instance.accCurrency,
      'accName': instance.accName,
      'accBalance': instance.accBalance,
      'accType': instance.accType,
      'accBalanceDesc': instance.accBalanceDesc,
    };

DepositAccountItem _$DepositAccountItemFromJson(Map<String, dynamic> json) =>
    DepositAccountItem(
      accNo: json['accNo'] as String,
      accCurrency: json['accCurrency'] as String,
      accName: json['accName'] as String,
      accBalance: (json['accBalance'] as num).toDouble(),
      accType: json['accType'] as String,
      accBalanceDesc: json['accBalanceDesc'] as String,
      accTenor: json['accTenor'] as String,
      accDueDate: json['accDueDate'] as String,
      accInterest: json['accInterest'] as String,
    );

Map<String, dynamic> _$DepositAccountItemToJson(DepositAccountItem instance) =>
    <String, dynamic>{
      'accNo': instance.accNo,
      'accCurrency': instance.accCurrency,
      'accName': instance.accName,
      'accBalance': instance.accBalance,
      'accType': instance.accType,
      'accBalanceDesc': instance.accBalanceDesc,
      'accTenor': instance.accTenor,
      'accDueDate': instance.accDueDate,
      'accInterest': instance.accInterest,
    };
