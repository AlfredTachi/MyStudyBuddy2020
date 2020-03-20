// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

abstract class Styles {
  static const hsBlue = Color(0xFF003D62);

  static const listLabel = TextStyle(
    fontSize: 18,
    color: CupertinoColors.black,
    fontFamily: "SF",
    fontWeight: FontWeight.normal
  );

  static const listSubtitle = TextStyle(
    fontSize: 14,
    color: CupertinoColors.systemGrey,
    fontFamily: "SF",
    fontWeight: FontWeight.normal
  );

  static const weatherDetails = TextStyle(
      fontSize: 20,
      color: CupertinoColors.black,
      fontFamily: "SF",
      fontWeight: FontWeight.normal);

  static const weatherTitle = TextStyle(
      fontSize: 32,
      color: CupertinoColors.black,
      fontFamily: "SF",
      fontWeight: FontWeight.w700);

  static const weatherTime = TextStyle(
      fontSize: 16,
      color: CupertinoColors.placeholderText,
      fontFamily: "SF",
      fontWeight: FontWeight.w500);

  static const weatherTemperature = TextStyle(
      fontSize: 36,
      color: CupertinoColors.black,
      fontFamily: "SF",
      fontWeight: FontWeight.w900);

  static const studyprogressCardTitle = TextStyle(
    fontSize: 20,
    color: CupertinoColors.black,
    fontFamily: "SF",
    fontWeight: FontWeight.w700,
  );

  static const moduleCode = TextStyle(
    fontSize: 16,
    color: CupertinoColors.white,
    fontFamily: "SF",
  );

  static const moduleGradePassed = TextStyle(
    fontSize: 10,
    color: CupertinoColors.systemGreen,
    fontFamily: "SF",
  );

  static const moduleGradeNotPassed = TextStyle(
    fontSize: 10,
    fontFamily: "SF",
    color: CupertinoColors.systemRed,
  );

  static const qspLink = TextStyle(
    fontSize: 14,
    fontFamily: "SF",
  );

  static const qspDetailsText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "SF");

  static const qspDetailsTitle = TextStyle(
      color: CupertinoColors.black,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "SF");

  static const minorText = TextStyle(
      color: Color.fromRGBO(128, 128, 128, 1),
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "SF");

  static const TextStyle textFieldText = TextStyle(
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "SF");

  static const navBarTitle =
      TextStyle(fontFamily: "SF", fontWeight: FontWeight.w700, fontSize: 18);

  static const alertDialogActionText = TextStyle(
    fontFamily: "SF",
  );

  static const alertDialogTitleText = TextStyle(
      fontFamily: "SF",
      fontSize: 18,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700);

  static const detailsTitleText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 30,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontFamily: "SF");

  static const detailsDescriptionText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      fontFamily: "SF");

  static const moduleInformationTitle = TextStyle(
    color: CupertinoColors.activeOrange,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
    fontFamily: "SF",
  );

  static const moduleInformationText = TextStyle(
      color: CupertinoColors.black,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: "SF");

  static const gradeInputError = TextStyle(
      color: CupertinoColors.destructiveRed,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      fontFamily: "SF");

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
