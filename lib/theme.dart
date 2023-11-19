import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*Exported Theme from Color Tool from Material Design*/
//Link: --> https://material.io/resources/color/#!/?view.left=0&view.right=0&secondary.color=69F0AE&secondary.text.color=212121&primary.color=424242

class WashingMachineAppTheme {
  static const bodyText2Color = Color.fromRGBO(33, 33, 33, 1.0);
  static const TextStyle keyAidBodyText1 = TextStyle(color: Colors.white);
  static const TextStyle keyAidBodyText2 = TextStyle(color: bodyText2Color);

  static const TextStyle Function(
      {Paint? background,
      Color? backgroundColor,
      Color? color,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
      List<FontFeature>? fontFeatures,
      double? fontSize,
      FontStyle? fontStyle,
      FontWeight? fontWeight,
      Paint? foreground,
      double? height,
      double? letterSpacing,
      Locale? locale,
      List<Shadow>? shadows,
      TextBaseline? textBaseline,
      TextStyle? textStyle,
      double? wordSpacing}) techTextStyle = GoogleFonts.chakraPetch;

  static final lightColorScheme = ThemeData.light().colorScheme.copyWith(
        primary: const Color.fromRGBO(66, 66, 66, 1.0),
        background: const Color.fromRGBO(241, 242, 241, 1.0),
        secondary: const Color.fromRGBO(105, 240, 174, 1.0),
      );

  static final light = ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
    textTheme: const TextTheme(
        bodyLarge: keyAidBodyText1, bodyMedium: keyAidBodyText2),
  );
}
