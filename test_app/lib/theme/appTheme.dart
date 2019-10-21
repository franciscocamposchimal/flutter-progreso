
 import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._();

  static const String fontName = 'WorkSans';
  static const Color darkerText = Color(0xFF17262A);

  static const TextTheme textTheme = TextTheme(
    display1: display1,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 20,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText
  );
}

