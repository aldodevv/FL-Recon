part of 'dummy_bloc.dart';

final class DummyState extends Equatable {
  final bool isLoading;
  final List<ResponsePost> posts;
  final AppFailure? failure;

  const DummyState({required this.isLoading, required this.posts, required this.failure});

  factory DummyState.initial() => const DummyState(isLoading: false, posts: [], failure: null);

  DummyState copyWith({bool? isLoading, List<ResponsePost>? posts, AppFailure? failure}) {
    return DummyState(isLoading: isLoading ?? this.isLoading, posts: posts ?? this.posts, failure: failure);
  }

  @override
  List<Object?> get props => [isLoading, posts, failure];
}
