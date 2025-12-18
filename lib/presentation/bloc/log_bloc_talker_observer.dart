import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LogBlocTalkerObserver extends TalkerBlocObserver {
  final String _headerLog = 'TalkerBloc';
  final Talker talker;

  LogBlocTalkerObserver(this.talker);

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    talker.info(
      '$_headerLog → onCreate: ${bloc.runtimeType}',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    talker.debug(
      '$_headerLog → onEvent: ${bloc.runtimeType} | event: $event',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    talker.debug(
      '$_headerLog → onTransition: ${bloc.runtimeType} | transition: $transition',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    talker.error(
      '$_headerLog → onError: ${bloc.runtimeType} | error: $error',
      error,
      stackTrace,
    );

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    talker.info(
      '$_headerLog → onClose: ${bloc.runtimeType}',
    );
  }
}