import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //Controller
  TextEditingController _infCtrl = TextEditingController();
  TextEditingController _matrikelCtrl = TextEditingController();
  TextEditingController _qspCtrl = TextEditingController();

  @override
  void initState() {
    loadData();
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
                        padding: const EdgeInsets.only(top: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                child: TextField(
                                  controller: _infCtrl,
                                  style: TextStyle(color: Colors.white),
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
                                  keyboardType: TextInputType.number,
                                  controller: _matrikelCtrl,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
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
                                  onTap: () {
                                    Navigator.of(context).pushNamed("/qspinfo");
                                  },
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  controller: _qspCtrl,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white.withAlpha(40),
                                      filled: true,
                                      hintStyle:
                                          TextStyle(color: Colors.black45, fontSize: 16),
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
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: MaterialButton(
                            height: 70,
                            minWidth: 150,
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20))),
                            child: Text(
                              "Speichern",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            onPressed: () {
                              saveData();
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("infNummer", _infCtrl.text);
    prefs.setString("matrikelNummer", _matrikelCtrl.text);
    prefs.setString("qsp", _qspCtrl.text);
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _infCtrl.text = prefs.getString("infNummer");
    _matrikelCtrl.text = prefs.getString("matrikelNummer");
    _qspCtrl.text = prefs.getString("qsp");
  }
}
