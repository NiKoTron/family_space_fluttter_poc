import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle get body => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  static TextStyle get subText => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
      );

  static TextStyle get h1 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
      );

  static TextStyle get h2 => const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        fontFamily: 'Roboto',
      );

  static TextStyle get h3 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Roboto',
      );
}
