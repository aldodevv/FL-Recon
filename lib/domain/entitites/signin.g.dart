// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninEntity _$SigninEntityFromJson(Map<String, dynamic> json) => SigninEntity(
  displayMessage: json['displayMessage'] as String?,
  message: json['message'] as String?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
  response:
      json['response'] == null
          ? null
          : ResponseEntity.fromJson(json['response'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SigninEntityToJson(SigninEntity instance) =>
    <String, dynamic>{
      'displayMessage': instance.displayMessage,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'response': instance.response,
    };

ResponseEntity _$ResponseEntityFromJson(Map<String, dynamic> json) =>
    ResponseEntity(
      page: json['page'] as String?,
      token: json['token'] as String?,
      roleCode: json['roleCode'] as String?,
      menu:
          (json['menu'] as List<dynamic>?)
              ?.map((e) => MenuEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
      isConsent: json['isConsent'] as bool?,
      firstLogin: json['firstLogin'] as bool?,
    );

Map<String, dynamic> _$ResponseEntityToJson(ResponseEntity instance) =>
    <String, dynamic>{
      'page': instance.page,
      'token': instance.token,
      'roleCode': instance.roleCode,
      'menu': instance.menu,
      'isConsent': instance.isConsent,
      'firstLogin': instance.firstLogin,
    };

MenuEntity _$MenuEntityFromJson(Map<String, dynamic> json) =>
    MenuEntity(menuCode: json['menuCode'] as String?);

Map<String, dynamic> _$MenuEntityToJson(MenuEntity instance) =>
    <String, dynamic>{'menuCode': instance.menuCode};
