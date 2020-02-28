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
      body:TabBarView(
        controller: _tabController,
        children: <Widget>[
          PlanerList(),
          EventList()
        ],
      )

    );
  }}