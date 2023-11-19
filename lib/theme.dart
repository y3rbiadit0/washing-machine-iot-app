import 'package:flutter/material.dart';

/*Exported Theme from Color Tool from Material Design*/
//Link: --> https://material.io/resources/color/#!/?view.left=0&view.right=0&secondary.color=69F0AE&secondary.text.color=212121&primary.color=424242

class WashingMachineAppTheme {
  static final lightColorScheme = ThemeData.light().colorScheme.copyWith(
        primary: const Color.fromRGBO(66, 66, 66, 1.0),
        background: const Color.fromRGBO(241, 242, 241, 1.0),
        secondary: const Color.fromRGBO(105, 240, 174, 1.0),
      );

  static final light =
      ThemeData.light().copyWith(colorScheme: lightColorScheme);
}
