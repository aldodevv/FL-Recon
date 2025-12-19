part of 'dummy_bloc.dart';

sealed class DummyEvent extends Equatable {
  const DummyEvent();

  @override
  List<Object> get props => [];
}

class FetchPosts extends DummyEvent {}
