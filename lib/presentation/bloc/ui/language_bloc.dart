import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recon/domain/repositories/ui_repository.dart';
import 'package:recon/presentation/bloc/ui/language_state.dart';

part 'language_event.dart';
@injectable
class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final UiLanguageRepository _languageRepository;

  LanguageBloc(this._languageRepository) : super(LanguageInitial()) {
    on<FetchLanguageData>(_onGetLanguage, transformer: concurrent());
    // on<ClearLanguageData>(_onClearLanguage, transformer: concurrent());
  }

  FutureOr<void> _onGetLanguage(
    FetchLanguageData event,
    Emitter<LanguageState> emit,
  ) async {
    emit(LanguageLoading());

    final result = await _languageRepository.getUIData();

    await result.fold(
      (failure) async {
        emit(LanguageError(failure));
      },
      (response) async {
        emit(LanguageLoaded(response.data!.response));
      },
    );
  }

  // FutureOr<void> _onClearLanguage(
  //   ClearLanguageData event,
  //   Emitter<LanguageState> emit,
  // ) async {
  //   _languageRepository.clearCache();
  //   emit(LanguageInitial());
  // }
}
