import 'package:json_annotation/json_annotation.dart';

part 'entity_language.g.dart';

@JsonSerializable()
class EntityLanguage {
  final int statusCode;
  final String status;
  final String message;
  final String displayMessage;
  final List<EntityItemLanguage> response;

  EntityLanguage({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory EntityLanguage.fromJson(Map<String, dynamic> json) =>
      _$EntityLanguageFromJson(json);
  Map<String, dynamic> toJson() => _$EntityLanguageToJson(this);
}

@JsonSerializable()
class EntityItemLanguage{
  final String id;
  final String label;
  final String group;

  EntityItemLanguage({
    required this.id,
    required this.label,
    required this.group,
  });

  factory EntityItemLanguage.fromJson(Map<String, dynamic> json) =>
      _$EntityItemLanguageFromJson(json);
  Map<String, dynamic> toJson() => _$EntityItemLanguageToJson(this);
}
