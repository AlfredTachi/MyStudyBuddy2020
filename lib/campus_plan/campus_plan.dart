import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CampusPlan extends StatefulWidget {
  @override
  CampusPlanState createState() => CampusPlanState();
}

class CampusPlanState extends State<CampusPlan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.orange,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlineButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(
                          Icons.arrow_back,
                          size: 36,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ),
              Expanded(
                child: PhotoView(
                  imageProvider:
                      AssetImage("assets/images/campusplan_hoch.jpg"),
                  minScale: PhotoViewComputedScale.contained *
                      1, //image can be scaled down to 100% of screenwidth
                  maxScale: PhotoViewComputedScale.covered *
                      2, //image can be scaled up to 400% of screenheight
                ),
              ),
            ],
          )),
    );
  }
}
