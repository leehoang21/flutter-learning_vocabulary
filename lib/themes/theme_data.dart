import 'package:flutter/material.dart';
import '../common/constants/layout_constants.dart';
import 'themes.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'QS',
    primaryColor: AppColor.primaryColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(LayoutConstants.roundedRadius),
      ),
    ),
    scaffoldBackgroundColor: AppColor.backgroundColor,
    iconTheme: ThemeIcon.getDefaultIconTheme(),
    appBarTheme:
        const AppBarTheme(color: AppColor.backgroundColor, elevation: 0.0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: AppColor.ebonyClay),
      unselectedIconTheme: IconThemeData(color: AppColor.grey),
      unselectedLabelStyle: TextStyle(color: AppColor.grey),
      selectedLabelStyle: TextStyle(color: AppColor.ebonyClay),
      unselectedItemColor: AppColor.grey,
      selectedItemColor: AppColor.ebonyClay,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.ebonyClay,
      foregroundColor: Colors.white,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColor.primaryColor,
    ),
  );
}
