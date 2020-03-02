import 'package:MyStudyBuddy2/model/module.dart';


class InformationTile {
  //Singleton
  InformationTile._internal();
  factory InformationTile() => _instance;
  //Instance
  static final InformationTile _instance = InformationTile._internal();

  final List<_Tile> _tiles = [
    _Tile("Modul Name", Module().title),
    _Tile("Note", Module().getGrade().toString()),
    _Tile("Modul ID", Module().id.toString()),
    _Tile("Credit Points", "6")
  ];

  List<_Tile> getTiles() {
    return _tiles;
  }
}

class _Tile {


  String title;
  String subtitle;

  _Tile(this.title, this.subtitle);
}
