import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TileController {
  //Singleton
  TileController._internal();
  factory TileController() => _instance;
  //Instance
  static final TileController _instance = TileController._internal();

  final List<_Tile> _tiles = [
    _Tile(Icon(Icons.check_box), "Studienverlauf", "/studyprogress"),
    _Tile(Icon(QSPInfoIcons.calculator), "Notenrechner", "/gradesPrognosis"),
    _Tile(Icon(Icons.chrome_reader_mode), "Modulhandbuch", "/moduleHandbook"),
    _Tile(Icon(Icons.map), "Campusplan", "/map"),
    _Tile(Icon(Icons.calendar_today), "LSF Frontend", "/planer"),
    _Tile(Icon(Icons.wb_sunny), "Wetter", "/weather"),
    _Tile(Icon(Icons.local_library), "Studi Quiz", "/quiz"),
    // _Tile(Icon(Icons.rate_review), "Evaluation", "/evaluation"),
    _Tile(Icon(Icons.help), "Hilfe", "/supportMain"),
  ];

  List<_Tile> getTiles() {
    return _tiles;
  }
}

class _Tile {
  Icon leading;
  String text;
  String route;

  _Tile(this.leading, this.text, this.route);
}
