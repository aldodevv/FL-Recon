import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hbalance_dto.g.dart';

@JsonSerializable()
final class HbalanceDto extends Equatable {
  final List<String> accountlist;
  final List<String> accounttype;
  final String currencycode;
  final String lang;

  const HbalanceDto({
    required this.accountlist,
    required this.accounttype,
    required this.currencycode,
    required this.lang,
  });

  factory HbalanceDto.fromDomain() => const HbalanceDto(
        accountlist: [],
        accounttype: [],
        currencycode: '',
        lang: '',
      );

  factory HbalanceDto.fromJson(Map<String, dynamic> json) =>
      _$HbalanceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HbalanceDtoToJson(this);

  @override
  List<Object?> get props => [accountlist, accounttype, currencycode, lang];
}
