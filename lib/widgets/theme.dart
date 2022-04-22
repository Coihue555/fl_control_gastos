import 'package:flutter/material.dart';

  BoxDecoration gradientePropia() {
    return const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.orange]
        )
      );
  }

  ThemeData themePropio() {
    return ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple,
            ),
            scaffoldBackgroundColor: Colors.transparent,
            textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white),),
            primaryColor: Colors.deepPurple,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(backgroundColor: Colors.deepPurple)
          );
  }