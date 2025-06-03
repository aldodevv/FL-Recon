import 'package:equatable/equatable.dart';

class MeState extends Equatable {
  final String corpId;
  final String username;
  final String corporateName;

  const MeState({
    required this.corpId,
    required this.username,
    required this.corporateName,
  });


  factory MeState.initial() => const MeState(
    corpId: '',
    username: '',
    corporateName: '',
  );

  MeState copyWith({
    String? corpId,
    String? username,
    String? corporateName,
  }) {
    return MeState(corpId: corpId ?? this.corpId, username: username ?? this.username, corporateName: corporateName ?? this.corporateName);
  }

  @override
  List<Object?> get props => [
    corpId,
    username,
    corporateName,
  ];}