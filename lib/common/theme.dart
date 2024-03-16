import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xffF9F9FB),
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: const ColorScheme.light(
      primary: Color(0xff2DBE5F),
      secondary: Color(0xff070707),
      tertiary: Color(0xffA9A9AB),
      surface: Color(0xffF3F3F3),
      background: Color(0xffF5F5F5),
      secondaryContainer: Colors.white),
);
