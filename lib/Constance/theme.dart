// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Constance/constance.dart';
import '../utils/color.dart';

import '../utils/local_storage_data.dart';

class AppTheme extends ChangeNotifier {
  static bool isLightTheme = true;
  bool isLight = true;
  AppTheme() {
    LocalDataStorage.getTheme().then((value) {
      isLight = value;
      notifyListeners();
    });
  }

  ThemeData getTheme() {
    if (isLight) {
      return lightTheme();
    } else {
      return darkTheme();
    }
  }

  changeThemeData() {
    isLight = !isLight;
    LocalDataStorage.saveTheme(isLight);
    notifyListeners();
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      subtitle1: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.subtitle1!.color, fontSize: 15)),
      subtitle2: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.caption!.color,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
      bodyText1: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.bodyLarge!.color, fontSize: 14)),
      bodyText2: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.bodyText2!.color, fontSize: 16)),
      button: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.button!.color,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
      headline1: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.subtitle1!.color,
              fontSize: 15,
              fontWeight: FontWeight.w500)),
      caption: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.caption!.color, fontSize: 12)),
      headline4: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.headline4!.color, fontSize: 24)),
      headline3: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.headline3!.color,
              fontSize: 40,
              fontWeight: FontWeight.w600)),
      headline2: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.headline2!.color, fontSize: 60)),
      headline5: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.headline5!.color,
              fontSize: 20.5,
              fontWeight: FontWeight.w700)),
      headline6: GoogleFonts.urbanist(
          textStyle: TextStyle(
              color: base.headline6!.color,
              fontSize: 20,
              fontWeight: FontWeight.w500)),
      overline: GoogleFonts.urbanist(
          textStyle: TextStyle(color: base.overline!.color, fontSize: 10)),
    );
  }

  static ThemeData lightTheme() {
    Color primaryColor = HexColor(primaryColorString);
    Color secondaryColor = HexColor(secondaryColorString);
    final ColorScheme colorScheme = ColorScheme.light().copyWith(
      primary: secondaryColor,
      secondary: Colors.white,
    );

    final ThemeData base = ThemeData.light();
    return base.copyWith(
      dividerColor: Colors.grey,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18)),
      popupMenuTheme: PopupMenuThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Color(0xff2b2b2b)),
      colorScheme: colorScheme,
      primaryColor: AppColor.mainColor,
      // buttonColor: primaryColor,
      splashColor: Colors.white.withOpacity(0.1),
      hoverColor: Colors.transparent,
      splashFactory: InkRipple.splashFactory,
      highlightColor: Colors.transparent,
      // accentColor: primaryColor,
      canvasColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      errorColor: Colors.red,
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.textTheme),
      platform: TargetPlatform.iOS,
      indicatorColor: primaryColor,
      disabledColor: HexColor("#949292"),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      cardColor: Colors.white,
    );
  }

  static ThemeData darkTheme() {
    Color primaryColor = HexColor(primaryColorString);
    Color secondaryColor = HexColor(secondaryColorString);
    final ColorScheme colorScheme = ColorScheme.dark().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      dividerColor: Colors.grey,
      appBarTheme: AppBarTheme(
        color: AppColor.mainColor,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),

      popupMenuTheme: PopupMenuThemeData(color: Colors.black),
      colorScheme: colorScheme,
      iconTheme: IconThemeData(color: Colors.white),
      primaryColor: Colors.black,
      // buttonColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      // accentColor: secondaryColor,
      canvasColor: Colors.transparent,
      backgroundColor: Color(0xff1c1d21),
      scaffoldBackgroundColor: Color(0xff111827),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      // accentTextTheme: _buildTextTheme(base.accentTextTheme),
      platform: TargetPlatform.iOS,
      disabledColor: HexColor("#949292"),
      cardColor: HexColor("#23262F"),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
