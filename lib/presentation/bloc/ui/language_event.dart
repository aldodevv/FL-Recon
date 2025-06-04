part of 'language_bloc.dart';

abstract class LanguageEvent {}

class FetchLanguageData extends LanguageEvent {}

class ClearLanguageData extends LanguageEvent {}