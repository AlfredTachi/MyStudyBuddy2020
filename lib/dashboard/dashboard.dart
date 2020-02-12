import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  Map<String, double> dataMap = new Map();

  @override
  void initState() {
    dataMap.putIfAbsent("Flutter", () => 5);
    dataMap.putIfAbsent("React", () => 3);
    dataMap.putIfAbsent("Xamarin", () => 2);
    dataMap.putIfAbsent("Ionic", () => 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyStudyBuddy"),
      ),
      body: Column(
        children: <Widget>[
          Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 200,
                    padding: EdgeInsets.all(15),
                    child: PieChart(
                      dataMap: dataMap,
                      showLegends: false,
                      chartType: ChartType.ring,
                      showChartValues: false,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[Icon(Icons.headset), Text("0")],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.headset),
                          Text("Noch keinen")
                        ],
                      ),
                      Row(
                        children: <Widget>[Icon(Icons.person), Text("inf2802")],
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Modul hinzufügen',
        child: Icon(Icons.add),
      ),
    );
  }
}
