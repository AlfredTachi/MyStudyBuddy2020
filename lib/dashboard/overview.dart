import 'package:MyStudyBuddy2/singleton/tile_controller.dart';
import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OverviewState();
}

class OverviewState extends State<Overview> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          floating: true,
          centerTitle: true,
          title: Text(
            "My Study Buddy",
            style: TextStyle(color: Colors.black),
          ),
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(
                'assets/images/menu_picture.jpg',
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
              title: Text(TileController().getTiles()[index].text),
              onTap: () {
                Navigator.of(context)
                    .pushNamed(TileController().getTiles()[index].route);
              },
            );
          }, childCount: TileController().getTiles().length),
        )
      ],
    );
  }
}