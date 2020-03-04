import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    try {
      ProfileController().loadData();
    } catch (ex) {
      print("Failed to load shared preference with following error: \n" + ex);
    }
    ProfileController().loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Align(
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
            Expanded(
              flex: 4,
              child: Container(
                child: Image.asset(
                    "assets/icons/app_icon/transparent_app_icon.png"),
              ),
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
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5, top: 50),
                                child: TextField(
                                  onChanged: (_val) {
                                    ProfileController().saveData();
                                  },
                                  controller: ProfileController()
                                      .getInfNumberController(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withAlpha(40),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      hintText: "Inf Nummer",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                child: TextField(
                                  onChanged: (_val) {
                                    ProfileController().saveData();
                                  },
                                  maxLength: 6,
                                  keyboardType: TextInputType.number,
                                  controller: ProfileController()
                                      .getMatrikelController(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      fillColor: Colors.white.withAlpha(40),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      hintText: "Matrikel Nummer",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                child: TextField(
                                  maxLines: null,
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed("/qspinfo")
                                        .whenComplete(() {
                                      ProfileController().saveData();
                                    });
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  controller:
                                      ProfileController().getQSPController(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withAlpha(40),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.black45, fontSize: 16),
                                      hintText:
                                          "Klick mich um ein QSP zu wählen!",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
