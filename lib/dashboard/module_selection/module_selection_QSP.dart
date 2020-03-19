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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          new BottomNavigationBarItem(
            icon: _currentIndex == 0
                ? ImageIcon(AssetImage("assets/icons/QSP/Cloud_Icon.png"),
                    size: 30, color: setBottomNavigationBarIconSelectedColor())
                : ImageIcon(AssetImage("assets/icons/QSP/Cloud_Icon.png"),
                    size: 30, color: setBottomNavigationBarColor()),
            title: Text('Security and Network', style: TextStyle(fontSize: 12, color: setBottomNavigationBarColor())),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 1
                ? ImageIcon(
                    AssetImage("assets/icons/QSP/Medieninformatik_Icon.png"),
                    size: 30,
                    color: setBottomNavigationBarIconSelectedColor())
                : ImageIcon(
                    AssetImage("assets/icons/QSP/Medieninformatik_Icon.png"),
                    size: 30,
                    color: setBottomNavigationBarColor()),
            title: Text('Visual Computing', style: TextStyle(fontSize: 12,color: setBottomNavigationBarColor())),
          ),
          new BottomNavigationBarItem(
            icon: _currentIndex == 2
                ? ImageIcon(AssetImage("assets/icons/QSP/Software_Icon.png"),
                    size: 30, color: setBottomNavigationBarIconSelectedColor())
                : ImageIcon(AssetImage("assets/icons/QSP/Software_Icon.png"),
                    size: 30, color: setBottomNavigationBarColor()),
            title: Column(children: [
              FittedBox(child: Text('Software Engineering ', style: TextStyle(fontSize: 12, color: setBottomNavigationBarColor()))),
              Center(child: Text('and Development', style: TextStyle(fontSize: 12, color: setBottomNavigationBarColor())))
            ]),
          ),
        ],
      ),
    );
  }

  Color setBottomNavigationBarIconSelectedColor() {
    Color color = Colors.orange;
    return color;
  }

  Color setBottomNavigationBarColor() {
    Color color = Colors.black;
    return color;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
