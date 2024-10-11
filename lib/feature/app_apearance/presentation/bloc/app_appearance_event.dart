part of 'app_appearance_bloc.dart';

@immutable
sealed class AppAppearanceEvent {}
class ChangeThemeEvent extends AppAppearanceEvent {
  final String selectedTheme;
  ChangeThemeEvent(this.selectedTheme);
}

class ChangeColorEvent extends AppAppearanceEvent {
  final Color selectedColor;
  ChangeColorEvent(this.selectedColor);
}