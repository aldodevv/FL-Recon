// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hbalance_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HbalanceDto _$HbalanceDtoFromJson(Map<String, dynamic> json) => HbalanceDto(
  accountlist:
      (json['accountlist'] as List<dynamic>).map((e) => e as String).toList(),
  accounttype:
      (json['accounttype'] as List<dynamic>).map((e) => e as String).toList(),
  currencycode: json['currencycode'] as String,
  lang: json['lang'] as String,
);

Map<String, dynamic> _$HbalanceDtoToJson(HbalanceDto instance) =>
    <String, dynamic>{
      'accountlist': instance.accountlist,
      'accounttype': instance.accounttype,
      'currencycode': instance.currencycode,
      'lang': instance.lang,
    };
