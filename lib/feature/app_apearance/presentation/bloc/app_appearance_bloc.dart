import 'dart:developer';
import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'app_appearance_event.dart';
part 'app_appearance_state.dart';

class AppAppearanceBloc extends Bloc<AppAppearanceEvent, AppAppearanceState> {
  AppAppearanceBloc() : super(AppAppearanceInitial()) {
    final initialTheme = 'System';
    final initialColor = AppPallete.initialAppAppearanceColor;

    emit(AppAppearanceUpdated(
      selectedTheme: initialTheme,
      selectedColor: initialColor,
    ));

    on<ChangeThemeEvent>((event, emit) {
      String theme = event.selectedTheme;
      Color color = AppPallete.initialAppAppearanceColor;

      emit(AppAppearanceUpdated(selectedTheme: theme, selectedColor: color));
    });

    on<ChangeColorEvent>((event, emit) {
      if (state is AppAppearanceUpdated) {
        String currentTheme = (state as AppAppearanceUpdated).selectedTheme;
        log('color is : ${event.selectedColor.toString()}');
        emit(AppAppearanceUpdated(
          selectedTheme: currentTheme,
          selectedColor: event.selectedColor,
        ));
      }
    });
  }
}
