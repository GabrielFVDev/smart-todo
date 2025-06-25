import 'package:bank/config/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme().apply(
          fontFamily: 'Poppins',
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500, // Medium
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500, // Medium
            ),
          ),
        ),
      ),
    );
  }
}
