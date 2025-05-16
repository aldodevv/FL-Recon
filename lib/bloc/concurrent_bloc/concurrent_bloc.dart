import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'concurrent_event.dart';
import 'concurrent_state.dart';

class ConcurrentBloc extends Bloc<ConcurrentEvent, ConcurrentState> {
  ConcurrentBloc() : super(ConcurrentState(0)) {
    on<IncrementConcurrent>(
      (event, emit) async {
        // await Future.delayed(const Duration(seconds: 1));
        emit(ConcurrentState(state.count + 1));
      },
      transformer: concurrent(),
    );
  }
}