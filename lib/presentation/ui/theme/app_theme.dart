import 'package:flutter/material.dart';

import 'app_constants.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      primaryColor: Colors.white,
      textTheme: AppTextTheme.darkTextTheme,
      fontFamily: 'Ubuntu',
      backgroundColor: Constants.darkestColor,

      // appBarTheme: AppBarTheme(
      //   backgroundColor: Constants.darkestColor,
      //
      // ),
    );
  }
}
