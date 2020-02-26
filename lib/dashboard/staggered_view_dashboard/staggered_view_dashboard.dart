import 'package:MyStudyBuddy2/singleton/module_module_selection_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import '../progress_bar/progress_bar.dart';

Widget progress(Widget progressBar) {
  return Material(
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    child: progressBar,
  );
}

Widget module() {
  return Material(
    elevation: 14.0,
    borderRadius: BorderRadius.circular(24.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Text("Deine Module", style: TextStyle(fontSize: 25)),
              ),
            ],
          ),
          (ModuleController().getSelectedModules().length == 0)
              ? Container(
                  child: Align(
                      heightFactor: 10,
                      child: FittedBox(
                          child: Text(
                        "Du hast zurzeit keine Module geplant!",
                        style: TextStyle(color: Colors.grey[400]),
                      ))))
              : Container(
                  padding: EdgeInsets.only(left: 18, right: 18),
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 0,
                    runSpacing: 5,
                    children: ModuleController().getSelectedModulesWidgets(),
                  ),
                ),
        ],
      ),
    ),
  );
}

class StaggeredView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StaggeredViewState();
  }
}

int _creditPoints = 0;
int _maxCreditPoints = 210;

class _StaggeredViewState extends State<StaggeredView> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: progress(GestureDetector(
                onTap: () {
                  setState(() {
                    _creditPoints += 6;
                  });
                },
                child: ProgressBar(_creditPoints, _maxCreditPoints))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
            child: module(),
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(2, screenHeight / 3),
          StaggeredTile.extent(2, screenHeight / 2),
        ],
      ),
    );
  }
}
