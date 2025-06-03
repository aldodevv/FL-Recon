import 'package:equatable/equatable.dart';

abstract class MeEvent  extends Equatable{
  const MeEvent();

  @override
  List<Object?> get props => [];
}

class MeGet extends MeEvent {}