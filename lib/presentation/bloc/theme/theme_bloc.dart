import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';


enum ThemeEvent { light, dark, system }

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  
  const ThemeState(this.themeMode);
  
  @override
  List<Object> get props => [themeMode];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.system)) {
    on<ThemeEvent>(_onThemeChanged, transformer: droppable());
  }

  void _onThemeChanged(ThemeEvent event, Emitter<ThemeState> emit) {
    final themeMode = switch (event) {
      ThemeEvent.light => ThemeMode.light,
      ThemeEvent.dark => ThemeMode.dark,
      ThemeEvent.system => ThemeMode.system,
    };
    
    if (state.themeMode != themeMode) {
      emit(ThemeState(themeMode));
    }
  }
}
