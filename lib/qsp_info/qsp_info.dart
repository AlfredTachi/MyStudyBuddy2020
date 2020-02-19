import 'package:MyStudyBuddy2/qsp_info/staggered_view_qsp/StaggeredView.dart';
import 'package:flutter/material.dart';

class QSPInfo extends StatefulWidget {
  @override
  QSPInfoState createState() => QSPInfoState();
}

class QSPInfoState extends State<QSPInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QSP Informationen"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: StaggeredView(),
    );
  }
}
