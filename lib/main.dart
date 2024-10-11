import 'package:domi_assignment/feature/app_apearance/presentation/bloc/app_appearance_bloc.dart';
import 'package:domi_assignment/feature/bottomsheet/presentation/bloc/bottom_sheet_bloc.dart';
import 'package:domi_assignment/feature/map_screen/presentation/bloc/map_bloc.dart';
import 'package:domi_assignment/init_dependencies.dart';
import 'package:domi_assignment/routes/app_route_config.dart';
import 'package:domi_assignment/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AppAppearanceBloc>(
          create: (context) => getIt<AppAppearanceBloc>(),
        ),
        BlocProvider<MapBloc>(
          create: (context) => getIt<MapBloc>(),
        ),
        BlocProvider<BottomSheetBloc>(
          create: (context) => getIt<BottomSheetBloc>(),
        ),
       
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAppearanceBloc, AppAppearanceState>(
      builder: (context, state) {
        ThemeData themeData;
        if (state is AppAppearanceUpdated) {
          switch (state.selectedTheme) {
            case 'Light':
              themeData = AppThemes.lightTheme;
              break;
            case 'Dark':
              themeData = AppThemes.darkTheme;
              break;
            case 'System':
            default:
              themeData = Theme.of(context).brightness == Brightness.light
                  ? AppThemes.lightTheme
                  : AppThemes.darkTheme;
              break;
          }
        } else {
          themeData = AppThemes.lightTheme;
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Domi',
          theme: themeData,
          routerConfig: AppRouter().router,
        );
      },
    );
  }
}

