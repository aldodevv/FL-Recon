import 'package:json_annotation/json_annotation.dart';

part 'signin.g.dart';

@JsonSerializable()
class SigninEntity {
  final String? displayMessage;
  final String? message;
  final int? statusCode;
  final ResponseEntity? response;

  SigninEntity({
    required this.displayMessage,
    required this.message,
    required this.statusCode,
    required this.response,
  });

  factory SigninEntity.fromJson(Map<String, dynamic> json) =>
      _$SigninEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SigninEntityToJson(this);
}


@JsonSerializable()
class ResponseEntity {
  final String? page;
  final String? token;
  final String? roleCode;
  final List<MenuEntity>? menu;
  final bool? isConsent;
  final bool? firstLogin;

  ResponseEntity({
    this.page,
    this.token,
    this.roleCode,
    this.menu,
    this.isConsent,
    this.firstLogin,
  });

  factory ResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseEntityToJson(this);
}


@JsonSerializable()
class MenuEntity {
  final String? menuCode;

  MenuEntity({this.menuCode});

  factory MenuEntity.fromJson(Map<String, dynamic> json) =>
      _$MenuEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MenuEntityToJson(this);
}