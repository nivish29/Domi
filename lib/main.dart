import 'package:domi_assignment/provider/bottomsheetProvider.dart';
import 'package:domi_assignment/provider/mapProvider.dart';
import 'package:domi_assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomSheetProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       navigatorKey: navigatorKey,
      title: 'Domi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
