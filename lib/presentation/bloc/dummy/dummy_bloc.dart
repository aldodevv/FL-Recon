import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recon/core/network/failure_response.dart';
import 'package:recon/domain/model/dummy_model.dart';
import 'package:recon/domain/repository/dummy_repository.dart';

part 'dummy_event.dart';
part 'dummy_state.dart';

class DummyBloc extends Bloc<DummyEvent, DummyState> {
  final DummyRepository repository;

  DummyBloc(this.repository) : super(DummyState.initial()) {
    on<FetchPosts>(_fetchPosts);
  }

  Future<void> _fetchPosts(FetchPosts event, Emitter<DummyState> emit) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await repository.getPosts();

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, failure: l));
      },
      (r) {
        emit(state.copyWith(isLoading: false, posts: r, failure: null));
      },
    );
  }
}
