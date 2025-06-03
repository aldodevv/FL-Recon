// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryResponseEntity _$HistoryResponseEntityFromJson(
  Map<String, dynamic> json,
) => HistoryResponseEntity(
  statusCode: (json['statusCode'] as num).toInt(),
  status: json['status'] as String,
  message: json['message'] as String,
  displayMessage: json['displayMessage'] as String,
  response: HistoryEntity.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HistoryResponseEntityToJson(
  HistoryResponseEntity instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'status': instance.status,
  'message': instance.message,
  'displayMessage': instance.displayMessage,
  'response': instance.response,
};

HistoryEntity _$HistoryEntityFromJson(Map<String, dynamic> json) =>
    HistoryEntity(
      tranHisList:
          (json['tranHisList'] as List<dynamic>)
              .map((e) => TranHistoryEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
      lastUpdated: LastUpdatedEntity.fromJson(
        json['lastUpdated'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$HistoryEntityToJson(HistoryEntity instance) =>
    <String, dynamic>{
      'tranHisList': instance.tranHisList,
      'lastUpdated': instance.lastUpdated,
    };

TranHistoryEntity _$TranHistoryEntityFromJson(Map<String, dynamic> json) =>
    TranHistoryEntity(
      totalOut: (json['totalOut'] as num).toInt(),
      totalIn: (json['totalIn'] as num).toInt(),
      month: (json['month'] as num).toInt(),
    );

Map<String, dynamic> _$TranHistoryEntityToJson(TranHistoryEntity instance) =>
    <String, dynamic>{
      'totalOut': instance.totalOut,
      'totalIn': instance.totalIn,
      'month': instance.month,
    };

LastUpdatedEntity _$LastUpdatedEntityFromJson(Map<String, dynamic> json) =>
    LastUpdatedEntity(date: json['date'] as String);

Map<String, dynamic> _$LastUpdatedEntityToJson(LastUpdatedEntity instance) =>
    <String, dynamic>{'date': instance.date};
