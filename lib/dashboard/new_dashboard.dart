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
          title: Text('SliverAppBar'),
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 20,
          delegate: SliverChildListDelegate(
            [
              ListTile(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.arrow_forward),
                title: Text("Test"),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}
