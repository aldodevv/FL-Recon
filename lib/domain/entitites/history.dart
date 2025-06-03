import 'package:json_annotation/json_annotation.dart';

part 'history.g.dart';

@JsonSerializable()
class HistoryResponseEntity {
  final int statusCode;
  final String status;
  final String message;
  final String displayMessage;
  final HistoryEntity response;

  HistoryResponseEntity({
    required this.statusCode,
    required this.status,
    required this.message,
    required this.displayMessage,
    required this.response,
  });

  factory HistoryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseEntityToJson(this);
}

@JsonSerializable()
class HistoryEntity {
  final List<TranHistoryEntity> tranHisList;
  final LastUpdatedEntity lastUpdated;

  HistoryEntity({
    required this.tranHisList,
    required this.lastUpdated,
  });

  factory HistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$HistoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryEntityToJson(this);
}

@JsonSerializable()
class TranHistoryEntity {
  final int totalOut;
  final int totalIn;
  final int month;

  TranHistoryEntity({
    required this.totalOut,
    required this.totalIn,
    required this.month,
  });

  factory TranHistoryEntity.fromJson(Map<String, dynamic> json) =>
      _$TranHistoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TranHistoryEntityToJson(this);
}

@JsonSerializable()
class LastUpdatedEntity {
  final String date;

  LastUpdatedEntity({required this.date});

  factory LastUpdatedEntity.fromJson(Map<String, dynamic> json) =>
      _$LastUpdatedEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LastUpdatedEntityToJson(this);
}
