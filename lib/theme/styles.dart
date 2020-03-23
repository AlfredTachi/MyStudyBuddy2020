// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const hsBlue = Color(0xFF013D62);
  static const textFieldColor = Color.fromARGB(128, 255, 255, 255);

  static TextStyle liquidCircularProgressIndicatorText = TextStyle(
      fontSize: 20,
      color: Color(0xFF263238),
      fontWeight: FontWeight.w700,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle profileText = TextStyle(
      fontSize: 18,
      color: CupertinoColors.black,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.normal);

  static TextStyle profilePlaceholder = TextStyle(
      fontSize: 18,
      color: CupertinoColors.inactiveGray.withAlpha(128),
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.normal);

  static TextStyle listLabel = TextStyle(
      fontSize: 18,
      color: CupertinoColors.black,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.normal);

  static TextStyle listSubtitle = TextStyle(
      fontSize: 14,
      color: CupertinoColors.systemGrey,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.normal);

  static TextStyle weatherDetails = TextStyle(
      fontSize: 20,
      color: CupertinoColors.black,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.normal);

  static TextStyle weatherTitle = TextStyle(
      fontSize: 32,
      color: CupertinoColors.black,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.w700);

  static TextStyle weatherTime = TextStyle(
      fontSize: 16,
      color: CupertinoColors.placeholderText,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.w500);

  static TextStyle weatherTemperature = TextStyle(
      fontSize: 36,
      color: CupertinoColors.black,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontWeight: FontWeight.w900);

  static TextStyle studyprogressCardTitle = TextStyle(
    fontSize: 20,
    color: hsBlue,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
    fontWeight: FontWeight.w700,
  );

  static TextStyle moduleCode = TextStyle(
    fontSize: 16,
    color: CupertinoColors.white,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
  );

  static TextStyle moduleGradePassed = TextStyle(
    fontSize: 10,
    color: CupertinoColors.systemGreen,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
  );

  static TextStyle moduleGradeNotPassed = TextStyle(
    fontSize: 10,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
    color: CupertinoColors.systemRed,
  );

  static TextStyle qspLink = TextStyle(
    fontSize: 14,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
  );

  static TextStyle qspDetailsText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle qspDetailsTitle = TextStyle(
      color: CupertinoColors.black,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle minorText = TextStyle(
      color: Color.fromRGBO(128, 128, 128, 1),
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle textFieldText = TextStyle(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle navBarTitle =
      TextStyle(fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily, fontWeight: FontWeight.w700, fontSize: 18);

  static TextStyle alertDialogActionText = TextStyle(
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
  );

  static TextStyle alertDialogTitleText = TextStyle(
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
      fontSize: 24,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700);

  static TextStyle detailsTitleText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 30,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle detailsDescriptionText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle moduleInformationTitle = TextStyle(
    color: CupertinoColors.activeOrange,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily,
  );

  static TextStyle moduleInformationText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static TextStyle gradeInputError = TextStyle(
      color: CupertinoColors.destructiveRed,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontFamily: CupertinoTextThemeData().navLargeTitleTextStyle.fontFamily);

  static Color appBackground = CupertinoColors.lightBackgroundGray;

  static Color scaffoldBackground = CupertinoColors.lightBackgroundGray;

  static const searchBackground = Color(0xffe0e0e0);

  static const closeButtonUnpressed = Color(0xff101010);

  static const closeButtonPressed = Color(0xff808080);

  static const Color searchCursorColor = Color.fromRGBO(0, 122, 255, 1);

  static const Color searchIconColor = Color.fromRGBO(128, 128, 128, 1);

  static const seasonBorder = Border(
    top: BorderSide(color: Color(0xff606060)),
    left: BorderSide(color: Color(0xff606060)),
    bottom: BorderSide(color: Color(0xff606060)),
    right: BorderSide(color: Color(0xff606060)),
  );

  static const uncheckedIcon = IconData(
    0xf372,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage,
  );

  static const checkedIcon = IconData(
    0xf373,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage,
  );

  static const transparentColor = Color(0x00000000);

  static const shadowColor = Color(0xa0000000);

  static const shadowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [transparentColor, shadowColor],
  );

  static const Color settingsMediumGray = Color(0xffc7c7c7);

  static Color settingsItemPressed = CupertinoThemeData().barBackgroundColor;

  static const Color settingsLineation = Color(0xffbcbbc1);

  static const Color settingsBackground = Color(0xffefeff4);

  static const Color settingsGroupSubtitle = Color(0xff777777);

  static const Color iconBlue = Color(0xff0000ff);

  static const Color iconGold = Color(0xffdba800);

  static const preferenceIcon = IconData(
    0xf443,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage,
  );

  static const calorieIcon = IconData(
    0xf3bb,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage,
  );

  static const checkIcon = IconData(
    0xf383,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage,
  );

  static const servingInfoBorderColor = Color(0xffb0b0b0);

  static const ColorFilter desaturatedColorFilter =
      // 222222 is a random color that has low color saturation.
      ColorFilter.mode(Color(0xFF222222), BlendMode.saturation);
}
