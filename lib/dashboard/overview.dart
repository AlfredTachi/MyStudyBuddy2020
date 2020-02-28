import 'package:MyStudyBuddy2/qsp_info/qsp_info_icons.dart';
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
          pinned: false,
          floating: true,
          centerTitle: true,
          expandedHeight: 150.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FittedBox(
              fit: BoxFit.contain,
              child: Image.asset(
                'assets/icons/app_icon/app_icon.png',
              ),
            ),
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 30,
          delegate: SliverChildListDelegate(
            [
              Divider(),
              ListTile(
                leading: Icon(Icons.check_box),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Studienverlauf"),
                onTap: () {
                  Navigator.of(context).pushNamed("/studyprogress");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(QSPInfoIcons.calculator),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Noten Rechner"),
                onTap: () {
                  Navigator.of(context).pushNamed("/gradesPrognosis");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.chrome_reader_mode),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Modulhandbuch"),
                onTap: () {
                  Navigator.of(context).pushNamed("/moduleHandbook");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.map),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Campusplan"),
                onTap: () {
                  Navigator.of(context).pushNamed("/map");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Terminplan"),
                onTap: () {
                  Navigator.of(context).pushNamed("/planer");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Wetter"),
                onTap: () {
                  Navigator.of(context).pushNamed("/weather");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.local_library),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Studi Quiz"),
                onTap: () {
                  Navigator.of(context).pushNamed("/quiz");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.rate_review),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Evaluation"),
                onTap: () {
                  Navigator.of(context).pushNamed("/evaluation");
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.orange,
                ),
                title: Text("Hilfe"),
                onTap: () {
                  Navigator.of(context).pushNamed("/supportMain");
                },
              ),
              Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
