import 'package:flutter/material.dart';

import '../color.dart';

final darkModeTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColor.mainColor,
  colorScheme: ColorScheme.light(background: Colors.black),
);

final lightModeTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColor.mainColor,
  colorScheme: ColorScheme.light(background: Colors.white),
);
