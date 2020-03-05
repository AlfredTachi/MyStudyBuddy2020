import 'package:MyStudyBuddy2/local_database/local_database.dart';
import 'package:MyStudyBuddy2/singleton/module_controller.dart';
import 'package:flutter/material.dart';

class GradesPrognosis extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GradesPrognosisState();
  }
}

class _GradesPrognosisState extends State<GradesPrognosis> {
  final db = DBProvider.db;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Noten Rechner"),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.format_list_numbered),
                onPressed: () {
                  Navigator.of(context).pushNamed("/gradesList");
                })
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                  child: Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Column(children: [
                    Text("Durchschnitt:", style: TextStyle(fontSize: 25)),
                    // FutureBuilder<double>(
                    //   future: average(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.hasData) {
                    //       return Text("${snapshot.data.toDouble()}");
                    //     } else
                    //       return Text('keinen Durchschnitt');
                    //   },
                    // )
                  ]),
                ),
              )),
            ),
            Expanded(
              flex: 6,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.orange,
                          Colors.deepOrange,
                        ],
                      )),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Worst Case:"),
                        ),
                        // Text(worstCase().toString()),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Text("Best Case:"),
                        ),
                        // Text(bestCase().toString())
                      ],
                    ),
                  )),
            ),
          ],
        ));
  }

  // Future<double> average() async {
  //   Future<double> myAverage;
  //   var examResults = await db.getAllExamResults();

  //   myAverage = examResults.map((m) => m['Exams']).reduce((a, b) => a + b) /
  //       examResults.length;

  //   return await myAverage;
  // }


//   double bestCase() {
//     double myBestCase = 0;
//     double averageNow;
//     int temp;

//     if (ModuleController().getSelectedModules().length == null) {
//       temp = 0;
//     } else {
//       temp = ModuleController().getSelectedModules().length;
//     }

//     average().then((val) => setState(() {
//           averageNow = val;
//         }));
//     if (averageNow == null) {
//       myBestCase = 0.0;
//     } else {
//       myBestCase = (averageNow + temp.toDouble()) / (temp + 1);
//     }

//     return myBestCase;

//   }

//   double worstCase() {
//     double myWorstCase = 0;

//     double averageNow;
//     int temp;

//     if (ModuleController().getSelectedModules().length == null) {
//       temp = 0;
//     } else {
//       temp = ModuleController().getSelectedModules().length * 4;
//     }

//     average().then((val) => setState(() {
//           averageNow = val;
//         }));
//     if (averageNow == null) {
//       myWorstCase = 0.0;
//     } else {
//       myWorstCase = (averageNow + temp.toDouble()) / (temp + 1);
//     }

// return myWorstCase;
// }
}