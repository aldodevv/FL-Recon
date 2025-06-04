// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entity_language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntityLanguage _$EntityLanguageFromJson(Map<String, dynamic> json) =>
    EntityLanguage(
      statusCode: (json['statusCode'] as num).toInt(),
      status: json['status'] as String,
      message: json['message'] as String,
      displayMessage: json['displayMessage'] as String,
      response:
          (json['response'] as List<dynamic>)
              .map(
                (e) => EntityItemLanguage.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
    );

Map<String, dynamic> _$EntityLanguageToJson(EntityLanguage instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'status': instance.status,
      'message': instance.message,
      'displayMessage': instance.displayMessage,
      'response': instance.response,
    };

EntityItemLanguage _$EntityItemLanguageFromJson(Map<String, dynamic> json) =>
    EntityItemLanguage(
      id: json['id'] as String,
      label: json['label'] as String,
      group: json['group'] as String,
    );

Map<String, dynamic> _$EntityItemLanguageToJson(EntityItemLanguage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'group': instance.group,
    };
