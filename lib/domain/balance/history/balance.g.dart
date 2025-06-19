// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceResponseEntity _$BalanceResponseEntityFromJson(
  Map<String, dynamic> json,
) => BalanceResponseEntity(
  statusCode: (json['statusCode'] as num).toInt(),
  status: json['status'] as String,
  message: json['message'] as String,
  displayMessage: json['displayMessage'] as String,
  response: BalanceEntity.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BalanceResponseEntityToJson(
  BalanceResponseEntity instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'status': instance.status,
  'message': instance.message,
  'displayMessage': instance.displayMessage,
  'response': instance.response,
};

BalanceEntity _$BalanceEntityFromJson(Map<String, dynamic> json) =>
    BalanceEntity(
      balanceHisList:
          (json['balanceHisList'] as List<dynamic>)
              .map((e) => BalanceHistory.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastUpdated: json['lastUpdated'] as String,
    );

Map<String, dynamic> _$BalanceEntityToJson(BalanceEntity instance) =>
    <String, dynamic>{
      'balanceHisList': instance.balanceHisList,
      'lastUpdated': instance.lastUpdated,
    };

BalanceHistory _$BalanceHistoryFromJson(Map<String, dynamic> json) =>
    BalanceHistory(
      balance: (json['balance'] as num).toInt(),
      month: (json['month'] as num).toInt(),
      accountType: json['accountType'] as String,
    );

Map<String, dynamic> _$BalanceHistoryToJson(BalanceHistory instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'month': instance.month,
      'accountType': instance.accountType,
    };
