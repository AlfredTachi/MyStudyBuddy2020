import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../drawer/drawer.dart';

class CampusPlan extends StatefulWidget {
  @override
  CampusPlanState createState() => CampusPlanState();
}

class CampusPlanState extends State<CampusPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Campusplan"),
      ),
      drawer: OwnDrawer(),
      body: PhotoView(
        imageProvider: AssetImage("assets/images/campusplan_hoch.jpg"
        ),
        minScale: PhotoViewComputedScale.contained*0.5,      //image can be scaled down to 50% of screenwidth
        maxScale: PhotoViewComputedScale.covered*2,         //image can be scaled up to 400% of screenheight
       
      )

    );
  }
}