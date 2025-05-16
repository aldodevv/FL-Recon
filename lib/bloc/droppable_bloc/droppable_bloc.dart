import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'droppable_event.dart';
import 'droppable_state.dart';

class DroppableBloc extends Bloc<DroppableEvent, DroppableState> {
  DroppableBloc() : super(DroppableState(0)) {
    on<IncrementDroppable>(
      (event, emit) async {
        // await Future.delayed(const Duration(seconds: 1));
        emit(DroppableState(state.count + 1));
      },
      transformer: droppable(),
    );
  }
}