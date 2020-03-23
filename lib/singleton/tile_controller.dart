import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
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
          ? IOSQuickAccessIcons.checkmark_square_fill
          : Icons.check_box,
      CupertinoColors.systemGreen,
      "Studienverlauf",
      "/studyprogress",
    ),
    _Tile(
      (Platform.isIOS)
          ? IOSQuickAccessIcons.f_cursive_circle_fill
          : QSPInfoIcons.calculator,
      CupertinoColors.systemBlue,
      "Notenrechner",
      "/gradesPrognosis",
    ),
    _Tile(
      (Platform.isIOS)
          ? IOSQuickAccessIcons.book_fill
          : Icons.chrome_reader_mode,
      CupertinoColors.systemIndigo,
      "Modulhandbuch",
      "/moduleHandbook",
    ),
    _Tile(
      (Platform.isIOS) ? IOSQuickAccessIcons.map_fill : Icons.map,
      CupertinoColors.systemBlue,
      "Campusplan",
      "/map",
    ),
    _Tile(
      (Platform.isIOS) ? IOSQuickAccessIcons.calendar : Icons.calendar_today,
      CupertinoColors.systemRed,
      "LSF Frontend",
      "/planer",
    ),
    _Tile(
      (Platform.isIOS) ? IOSQuickAccessIcons.cloud_sun_fill : Icons.wb_sunny,
      CupertinoColors.systemBlue,
      "Wetter",
      "/weather",
    ),
    _Tile(
      (Platform.isIOS)
          ? IOSQuickAccessIcons.pencil_circle_fill
          : Icons.local_library,
      CupertinoColors.systemOrange,
      "Studi Quiz",
      "/quiz",
    ),
    // _Tile(Icon(Icons.rate_review), "Evaluation", "/evaluation",),
    _Tile(
      (Platform.isIOS)
          ? IOSQuickAccessIcons.questionmark_circle_fill
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
