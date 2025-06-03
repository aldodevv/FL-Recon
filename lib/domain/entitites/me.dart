import 'package:json_annotation/json_annotation.dart';

part 'me.g.dart';

@JsonSerializable()
class MeResponseEntity {
  final int statusCode;
  final String message;
  final String displayMessage;
  final MeUserEntity response;

  MeResponseEntity({
    required this.statusCode,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory MeResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MeResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MeResponseEntityToJson(this);
}

@JsonSerializable()
class MeUserEntity {
  final String username;
  final String corporateId;
  final String corporateName;

  MeUserEntity({
    required this.username,
    required this.corporateId,
    required this.corporateName,
  });

  factory MeUserEntity.fromJson(Map<String, dynamic> json) =>
      _$MeUserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MeUserEntityToJson(this);
}
