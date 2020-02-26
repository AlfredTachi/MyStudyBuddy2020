import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:MyStudyBuddy2/planer/planer_list.dart';
import 'package:MyStudyBuddy2/planer/upcoming_events.dart';
import 'package:flutter/material.dart';

class Planer extends StatefulWidget{
  const Planer({ Key key }) : super(key: key);
  @override
  State<StatefulWidget> createState() {

    return _PlanerState();
  }
}

class _PlanerState extends State<Planer>with SingleTickerProviderStateMixin{

final List<Tab> myTabs = <Tab>[
    Tab(text: 'Deine Termine'),
    Tab(text: 'Aktuelles'),
  ];

TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
   _tabController.dispose();
   super.dispose();
 }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:Text('Termin Planer'),
      bottom: TabBar(controller:_tabController ,tabs:myTabs)),
      drawer: OwnDrawer(),
      body:TabBarView(
        controller: _tabController,
        children: <Widget>[
          PlanerList(),
          EventList()
        ],
      )

    );
  }}

// }
// final makeBody = Container(
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount: 10,
//         itemBuilder: (BuildContext context, int index) {
//           return makeCard;
//         },
//       ),
//     );
//     final makeCard = Card(
//       elevation: 8.0,
//       margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
//         child: makeListTile,
//       ),
//     );

    // final makeListTile = ListTile(

    //     contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    //     leading: Container(
    //       child:Text('test')
    //     ),
    //     trailing: Icon(Icons.favorite),
    //     );
