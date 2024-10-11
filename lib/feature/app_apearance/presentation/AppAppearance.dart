import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';
import 'package:domi_assignment/theme/app_pallete.dart';
import 'package:domi_assignment/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppearanceSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAppearanceBloc, AppAppearanceState>(
      builder: (context, state) {
        String selectedTheme = 'Dark';
        Color selectedColor = AppPallete.defaultSelectedColor;

        if (state is AppAppearanceUpdated) {
          selectedTheme = state.selectedTheme;
          selectedColor = state.selectedColor;
        }
        ThemeData themeData = selectedTheme == 'Light'
            ? AppThemes.lightTheme
            : AppThemes.darkTheme;

        return Scaffold(
          backgroundColor: themeData.scaffoldBackgroundColor,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: themeData.textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Customize App's Appearance".toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeData.textTheme.bodyLarge?.color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                buildSettingCard(
                  'Theme',
                  buildThemeSelector(selectedTheme, selectedColor, context),
                  themeData,
                ),
                buildSettingCard(
                  'Highlight Color',
                  buildHighlightColorSelector(selectedColor, context),
                  themeData,
                ),
                buildSettingCard(
                  'Text',
                  ListTile(
                    title: Text('Font', style: themeData.textTheme.bodyLarge),
                    trailing: const Icon(Icons.chevron_right,
                        color: AppPallete.iconGrey),
                  ),
                  themeData,
                ),
                buildSettingCard(
                  'Animation',
                  Column(
                    children: [
                      ListTile(
                        title: Text('Page Transition',
                            style: themeData.textTheme.bodyLarge),
                        trailing: const Icon(Icons.chevron_right,
                            color: AppPallete.iconGrey),
                      ),
                      ListTile(
                        title: Text('Animation Speed',
                            style: themeData.textTheme.bodyLarge),
                        trailing: const Icon(Icons.chevron_right,
                            color: AppPallete.iconGrey),
                      ),
                    ],
                  ),
                  themeData,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildThemeSelector(
      String selectedTheme, Color selectedColor, BuildContext context) {
    final List<String> themes = ['Light', 'Dark', 'System'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: themes.map((theme) {
        bool isSelected = selectedTheme == theme;
        return GestureDetector(
          onTap: () {
            BlocProvider.of<AppAppearanceBloc>(context)
                .add(ChangeThemeEvent(theme));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              color: AppPallete.greyShade800,
              borderRadius: BorderRadius.circular(12),
              border: isSelected
                  ? Border.all(color: selectedColor, width: 3)
                  : Border.all(color: Colors.transparent),
            ),
            child: Column(
              children: [
                Icon(
                  theme == 'Light'
                      ? Icons.wb_sunny
                      : theme == 'Dark'
                          ? Icons.nights_stay
                          : Icons.brightness_auto,
                  color: AppPallete.whiteColor,
                  size: 28,
                ),
                const SizedBox(height: 5),
                Text(
                  theme,
                  style: const TextStyle(
                    color: AppPallete.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildHighlightColorSelector(
      Color selectedColor, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: AppThemes.highlightColors.map((color) {
        bool isSelected = selectedColor == color;
        return GestureDetector(
          onTap: () {
            BlocProvider.of<AppAppearanceBloc>(context)
                .add(ChangeColorEvent(color));
          },
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: color, width: 3) : null,
            ),
            child: CircleAvatar(
              backgroundColor: color,
              radius: 18,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget buildSettingCard(String title, Widget content, ThemeData themeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: themeData.textTheme.bodyLarge?.color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: themeData.brightness == Brightness.light
                  ? AppPallete.greyShade200.withOpacity(0.6)
                  : AppPallete.greyShade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}
