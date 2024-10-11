part of 'app_appearance_bloc.dart';

@immutable
sealed class AppAppearanceState {}

final class AppAppearanceInitial extends AppAppearanceState {}

final class AppAppearanceUpdated extends AppAppearanceState {
  final String selectedTheme;
  final Color selectedColor;

  AppAppearanceUpdated(
      {required this.selectedTheme, required this.selectedColor});
}
