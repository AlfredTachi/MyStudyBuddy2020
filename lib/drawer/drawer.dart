import 'package:flutter/material.dart';

class OwnDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OwnDrawerState();
  }
}

class _OwnDrawerState extends State<OwnDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: (ListView(padding: EdgeInsets.zero, children: [
        Container(
          height: MediaQuery.of(context).size.height / 7,
          child: DrawerHeader(
            child: Text('ToDo Icon,Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                )),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.deepOrange[300], Colors.orangeAccent]),
            ),
          ),
        ),
        ListTile(                
                leading: Icon(Icons.home),
                title: Text('Übersicht'),
                onTap: () {
                 Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: Icon(Icons.check_box),
                title: Text('Semsterverlauf'),
                onTap: () {
                 Navigator.pushNamed(context, '/semesterverlauf');
                },
              ),
              ListTile(
                leading: Icon(Icons.chrome_reader_mode),
                title: Text('Modulhandbuch'),
                onTap: () {
                 // Navigator.pushNamed(context, '/todo');
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Campusplan'),
                onTap: () {
                 // Navigator.pushNamed(context, '/todo');
                },
              ),
              ListTile(
                leading: Icon(Icons.restaurant),
                title: Text('Mensa Plan'),
                onTap: () {
                 // Navigator.pushNamed(context, '/todo');
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Terminplan'),
                onTap: () {
                 // Navigator.pushNamed(context, '/todo');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Einstellungen'),
                onTap: () {
                 // Navigator.pushNamed(context, '/todo');
                },
              ),
          leading: Icon(Icons.home),
          title: Text('Übersicht'),
          onTap: () {
            Navigator.pushNamed(context, '/');
          },
        ),
        ListTile(
          leading: Icon(Icons.check_box),
          title: Text('Semsterverlauf'),
          onTap: () {
            // Navigator.pushNamed(context, '/second');
          },
        ),
        ListTile(
          leading: Icon(Icons.exposure),
          title: Text('Noten Rechner'),
          onTap: () {
            Navigator.pushNamed(context, '/grades_prognosis');
          },
        ),
        ListTile(
          leading: Icon(Icons.chrome_reader_mode),
          title: Text('Modulhandbuch'),
          onTap: () {
            // Navigator.pushNamed(context, '/todo');
          },
        ),
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Campusplan'),
          onTap: () {
            // Navigator.pushNamed(context, '/todo');
          },
        ),
        ListTile(
          leading: Icon(Icons.restaurant),
          title: Text('Mensa Plan'),
          onTap: () {
            Navigator.pushNamed(context, '/mensa_plan');
          },
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('Terminplan'),
          onTap: () {
            // Navigator.pushNamed(context, '/todo');
          },
        ),
        ListTile(
          leading: Icon(Icons.wb_sunny),
          title: Text('Wetter'),
          onTap: () {
            Navigator.pushNamed(context, '/weather');
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Einstellungen'),
          onTap: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ])),
    );
  }
}
