import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const SystemUiOverlayStyle SystemUiLight = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);
const SystemUiOverlayStyle SystemUiDark = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

enum AppTheme {
  Pure,
  PureLight,
  PureDark,
  Blue,
  BlueLight,
  BlueDark,
}

final appThemeData = {
  AppTheme.PureLight: ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4B7BFF),
      onPrimary: Color(0xff4B7BFF),
      secondary: Color(0xff4B7BFF),
      onSecondary: Color(0xff4B7BFF),
      error: Colors.red,
      onError: Colors.red,
      background: Color.fromRGBO(246, 247, 248, 1),
      onBackground: Color.fromRGBO(246, 247, 248, 1),
      surface: Colors.white,
      onSurface: Color(0xff000000),
    ),
    brightness: Brightness.light,
    primaryColor: Color(0xff658AFF),
    disabledColor: Color(0x553A3D47),
    hintColor: Color(0xFFA3A8B8),
    unselectedWidgetColor: Color(0xff8B91A0),
    focusColor: Color.fromRGBO(234, 240, 250, 1),
    canvasColor: Colors.white,
    cardColor: Colors.white,
    primaryColorLight: Color(0xFFE7F0FF),
    dividerColor: Color(0xFFEFF1F4),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xFF070707), opacity: 1),
    fontFamily: 'PingFang SC',
    textTheme: TextTheme(bodyLarge: TextStyle(color: Color(0xFF4A4E59))),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Colors.white,
      iconTheme: IconThemeData(color: Color(0xFF4A4E59), opacity: 1),
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: Color(0xffffffff),
    ),
  ),
  AppTheme.PureDark: ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: Color(0xff658AFF),
    disabledColor: Color(0xff3A3D47),
    unselectedWidgetColor: Color(0xff8B91A0),
    canvasColor: Color(0xff000000),
    focusColor: Color(0xaa767680),
    cardColor: Color(0xFF25262A),
    primaryColorLight: Color(0x99E7F0FF),
    fontFamily: 'PingFang SC',
    dividerColor: Color(0x994A4E59),
    textTheme: TextTheme(bodyLarge: TextStyle(color: Color(0xFFFFFFFF))),
    appBarTheme: AppBarTheme(
      elevation: 0,
      color: Color(0xFF25262A),
      iconTheme: IconThemeData(color: Color(0xff4b7bff), opacity: 1),
    ),
    bottomAppBarTheme: BottomAppBarTheme(color: Color(0xFF25262A)),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff658AFF),
      onPrimary: Color(0xff658AFF),
      secondary: Color(0xff658AFF),
      onSecondary: Color(0xff658AFF),
      error: Colors.red,
      onError: Colors.red,
      background: Color(0xff111111),
      onBackground: Color(0xff111111),
      surface: Color(0xFF25262A),
      onSurface: Color(0xffffffff),
    ),
  ),
};
