import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'restartable_event.dart';
import 'restartable_state.dart';

class RestartableBloc extends Bloc<RestartableEvent, RestartableState> {
  RestartableBloc() : super(RestartableState(0)) {
    on<IncrementRestartable>(
      (event, emit) async {
        // await Future.delayed(const Duration(seconds: 1));
        emit(RestartableState(state.count + 1));
      },
      transformer: sequential(),
    );
  }
}