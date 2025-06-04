

import 'package:recon/core/network/failure_response.dart';
import 'package:recon/domain/entitites/ui/entity_language.dart';

abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final List<EntityItemLanguage> items;

  LanguageLoaded(this.items);
}

class LanguageError extends LanguageState {
  final ResponseFailed error;

  LanguageError(this.error);
}