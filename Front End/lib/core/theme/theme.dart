import 'package:flutter/material.dart';
import 'package:musicly/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: BorderSide(color: color, width: 3));
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(

      enabledBorder: _border(Pallete.borderColor),
      contentPadding: EdgeInsets.all(27),
      focusedBorder: _border(Pallete.gradient2),
      
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Pallete.borderColor
    )
  );
}
