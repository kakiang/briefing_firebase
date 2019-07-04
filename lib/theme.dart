import 'package:briefing/colors.dart';
import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
//    accentColor: themeAppGrey800,
    accentColor: themeAppIndigo,
    primaryColor: themeAppWhite100,
    primaryColorBrightness: Brightness.light,
    bottomAppBarColor: themeAppWhite100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: themeAppWhite100,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: themeAppBackgroundWhite,
    cardColor: themeAppBackgroundWhite,
    textSelectionColor: themeAppGrey600,
    errorColor: themeAppErrorRed,
    canvasColor: Colors.white,
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
    accentIconTheme: IconThemeData().copyWith(color: Colors.blue[800]),
    primaryIconTheme: base.iconTheme.copyWith(color: themeAppGrey700),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
//        border: CutCornersBorder(),
    ),
    iconTheme: IconThemeData().copyWith(
      color: themeAppGrey700,
    ),
  );
}

TextTheme _buildAppTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontFamily: 'CrimsonText',
          fontWeight: FontWeight.bold,
        ),
        title: base.title.copyWith(
          fontFamily: 'Libre_Franklin',
          fontWeight: FontWeight.w600,
          fontSize: 22.0,
        ),
        subhead: base.subhead.copyWith(
          fontFamily: 'CrimsonText',
          fontSize: 18.0,
        ),
        body2: base.body2.copyWith(
          fontFamily: 'Libre_Franklin',
//          fontSize: 14.0,
        ),
        body1: base.body1.copyWith(
          fontFamily: 'CrimsonText',
//          fontSize: 14.0,
        ),
        caption: base.caption.copyWith(
          fontFamily: 'Libre_Franklin',
          fontSize: 16.0,
        ),
        button: base.button.copyWith(
          fontFamily: 'Libre_Franklin',
//          fontSize: 14.0,
        ),
        subtitle: base.subtitle.copyWith(
          fontFamily: 'Libre_Franklin',
//          color: themeAppGrey600,
//          fontWeight: FontWeight.w400,
        ),
      )
      .apply(
//        fontFamily: 'Merriweather',
        displayColor: themeAppGrey800,
        bodyColor: themeAppGrey800,
      );
}
