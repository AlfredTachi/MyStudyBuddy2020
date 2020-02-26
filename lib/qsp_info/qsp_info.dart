import 'package:MyStudyBuddy2/qsp_info/qsp_view.dart';
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
      ),
      body: QSPView(),
    );
  }
}
