import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:MyStudyBuddy2/singleton/tile_controller.dart';
import 'package:MyStudyBuddy2/studyprogress/studyprogress.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OverviewState();
}

class OverviewState extends State<Overview> {
  GlobalKey _key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                'assets/images/header.png',
              ),
            ),
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return ListTile(
              leading: TileController().getTiles()[index].leading,
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
              ),
              title: Text(
                TileController().getTiles()[index].text,
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                if (TileController().getTiles()[index].route !=
                    "/studyprogress") {
                  Navigator.of(context)
                      .pushNamed(TileController().getTiles()[index].route);
                } else {
                  ModuleController().studyProgressKey = _key;
                  print("Setting StudyProgressKey to: " +
                      ModuleController().studyProgressKey.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Studyprogress(
                        key: _key,
                      ),
                    ),
                  );
                }
              },
            );
          }, childCount: TileController().getTiles().length),
        )
      ],
    );
  }
}
