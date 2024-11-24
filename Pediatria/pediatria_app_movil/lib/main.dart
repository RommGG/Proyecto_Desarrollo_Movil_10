import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login with Splash',
      theme: AppTheme.lightTheme, // Tema global definido.
      home: const SplashScreen(),
    );
  }
}
