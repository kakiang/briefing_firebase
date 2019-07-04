import 'package:briefing/colors.dart';
import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: themeAppWhite,
    accentColor: themeAppBlue700,
    primaryColorBrightness: Brightness.light,
    bottomAppBarColor: themeAppWhite,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: themeAppWhite,
      textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: themeAppWhite,
    cardColor: themeAppWhite,
    textSelectionColor: themeAppGrey500,
    errorColor: themeAppErrorRed,
    canvasColor: themeAppWhite,
    textTheme: _buildAppTextTheme(base.textTheme),
    primaryTextTheme: _buildAppTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildAppTextTheme(base.accentTextTheme),
    accentIconTheme: IconThemeData().copyWith(color: themeAppBlue700),
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
          color: themeAppGrey700,
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
        displayColor: themeAppGrey800,
        bodyColor: themeAppGrey800,
      );
}
