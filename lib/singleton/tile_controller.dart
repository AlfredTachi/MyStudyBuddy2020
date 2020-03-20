import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class TileController {
  //Singleton
  TileController._internal();
  factory TileController() => _instance;
  //Instance
  static final TileController _instance = TileController._internal();

  final List<_Tile> _tiles = [
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf374,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.check_box,
      CupertinoColors.systemGreen,
      "Studienverlauf",
      "/studyprogress",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf3f2,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : QSPInfoIcons.calculator,
      CupertinoColors.systemBlue,
      "Notenrechner",
      "/gradesPrognosis",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf3e8,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.chrome_reader_mode,
      CupertinoColors.systemGrey,
      "Modulhandbuch",
      "/moduleHandbook",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf393,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.map,
      CupertinoColors.systemBlue,
      "Campusplan",
      "/map",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf3f4,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.calendar_today,
      CupertinoColors.systemRed,
      "LSF Frontend",
      "/planer",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf476,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.wb_sunny,
      CupertinoColors.systemBlue,
      "Wetter",
      "/weather",
    ),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf418,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.local_library,
      CupertinoColors.systemOrange,
      "Studi Quiz",
      "/quiz",
    ),
    // _Tile(Icon(Icons.rate_review), "Evaluation", "/evaluation",),
    _Tile(
      (Platform.isIOS)
          ? IconData(
              0xf446,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            )
          : Icons.help,
      CupertinoColors.systemGrey,
      "Hilfe",
      "/supportMain",
    ),
  ];

  List<_Tile> getTiles() {
    return _tiles;
  }
}

class _Tile {
  IconData leading;
  String text;
  String route;
  Color iosBackgroundColor;

  _Tile(this.leading, this.iosBackgroundColor, this.text, this.route);
}
