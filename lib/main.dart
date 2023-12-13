import 'package:flutter/material.dart';
import 'package:marvel/helpers/consts.dart';
import 'package:marvel/providers/movies_provider.dart';
import 'package:marvel/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoviesProvider>(
            create: (context) => MoviesProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: mainColor),
            useMaterial3: true,
          ),
          home: const SplashScreen()),
    );
  }
}
