import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection_QSP/staggered_view_cloud.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection_QSP/staggered_view_media.dart';
import 'package:MyStudyBuddy2/dashboard/module_selection/staggered_view_module_selection/staggered_view_module_selection_QSP/staggered_view_software.dart';
import 'package:flutter/material.dart';

class ModuleSelectionQSP extends StatefulWidget {
  @override
  ModuleSelectionQSPState createState() => ModuleSelectionQSPState();
}

class ModuleSelectionQSPState extends State<ModuleSelectionQSP> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    StaggeredViewCloud(),
    StaggeredViewMedia(),
    StaggeredViewSoftware()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QSP-Auswahl"),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icons/QSP/Cloud_Icon.png', height: 30, width: 30),
            title: Text('Cloud und Internet', style: TextStyle(fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icons/QSP/Medieninformatik_Icon.png', height: 30, width: 30),
            title: Text('Medieninformatik', style: TextStyle(fontSize: 12)),
          ),
          new BottomNavigationBarItem(
            icon: Image.asset('assets/icons/QSP/Software_Icon.png', height: 30, width: 30),
            title: Text('Software-Konstruktion', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}