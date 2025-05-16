import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'sequential_event.dart';
import 'sequential_state.dart';

class SequentialBloc extends Bloc<SequentialEvent, SequentialState> {
  SequentialBloc() : super(SequentialState(0)) {
    on<IncrementSequential>(
      (event, emit) async {
        // await Future.delayed(const Duration(seconds: 1));
        emit(SequentialState(state.count + 1));
      },
      transformer: sequential(),
    );
  }
}