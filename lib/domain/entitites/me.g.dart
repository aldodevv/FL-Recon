// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeResponseEntity _$MeResponseEntityFromJson(Map<String, dynamic> json) =>
    MeResponseEntity(
      statusCode: (json['statusCode'] as num).toInt(),
      message: json['message'] as String,
      displayMessage: json['displayMessage'] as String,
      response: MeUserEntity.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MeResponseEntityToJson(MeResponseEntity instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
      'displayMessage': instance.displayMessage,
      'response': instance.response,
    };

MeUserEntity _$MeUserEntityFromJson(Map<String, dynamic> json) => MeUserEntity(
  username: json['username'] as String,
  corporateId: json['corporateId'] as String,
  corporateName: json['corporateName'] as String,
);

Map<String, dynamic> _$MeUserEntityToJson(MeUserEntity instance) =>
    <String, dynamic>{
      'username': instance.username,
      'corporateId': instance.corporateId,
      'corporateName': instance.corporateName,
    };
