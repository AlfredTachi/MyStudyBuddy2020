import 'package:MyStudyBuddy2/singleton/profile_controller.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    ProfileController().loadData();
    ProfileController().setStudyType(ProfileController().getStudyTypeIndex());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void achivementsPageButtonPressed() {
      Navigator.of(context).pushNamed("/achievement");
    }

    Image getImage() {
      return Image.asset("assets/icons/app_icon/transparent_app_icon.png");
    }

    Widget getProfileCardContent() {
      return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: (Platform.isIOS)
                    ? const EdgeInsets.only(left: 25, right: 25, top: 25)
                    : const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 50),
                child: TextField(
                  onChanged: (_val) {
                    ProfileController().saveData();
                  },
                  controller: ProfileController().getInfNumberController(),
                  style: (Platform.isIOS)
                      ? Styles.profileText
                      : TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    fillColor: (Platform.isIOS)
                        ? Styles.textFieldColor
                        : Colors.white.withAlpha(40),
                    filled: true,
                    hintStyle: (Platform.isIOS)
                        ? Styles.profilePlaceholder
                        : TextStyle(color: Colors.black45),
                    hintText: "inf Nummer (z.B. inf9876)",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: (Platform.isIOS)
                    ? const EdgeInsets.only(left: 25, right: 25, top: 25)
                    : const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: TextField(
                  onChanged: (_val) {
                    ProfileController().saveData();
                  },
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  controller: ProfileController().getMatrikelController(),
                  style: (Platform.isIOS)
                      ? Styles.profileText
                      : TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    counterText: "",
                    fillColor: (Platform.isIOS)
                        ? Styles.textFieldColor
                        : Colors.white.withAlpha(40),
                    filled: true,
                    hintStyle: (Platform.isIOS)
                        ? Styles.profilePlaceholder
                        : TextStyle(color: Colors.black45),
                    hintText: "Matrikel Nummer",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: (Platform.isIOS)
                    ? const EdgeInsets.only(left: 25, right: 25, top: 25)
                    : const EdgeInsets.only(left: 20, right: 20, bottom: 5),
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
                  controller: ProfileController().getQSPController(),
                  style: (Platform.isIOS)
                      ? Styles.profileText
                      : TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    fillColor: (Platform.isIOS)
                        ? Styles.textFieldColor
                        : Colors.white.withAlpha(40),
                    filled: true,
                    hintStyle: (Platform.isIOS)
                        ? Styles.profilePlaceholder
                        : TextStyle(color: Colors.black45),
                    hintText: "Klick mich um ein QSP zu wählen!",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: (Platform.isIOS)
                    ? const EdgeInsets.all(25)
                    : const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: TextField(
                  maxLines: null,
                  onTap: () {
                    return showDialog(
                        context: context, child: _DualStudyDialog());
                  },
                  readOnly: true,
                  controller: ProfileController().getDualStudyController(),
                  style: (Platform.isIOS)
                      ? Styles.profileText
                      : TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    fillColor: (Platform.isIOS)
                        ? Styles.textFieldColor
                        : Colors.white.withAlpha(40),
                    filled: true,
                    hintStyle: (Platform.isIOS)
                        ? Styles.profilePlaceholder
                        : TextStyle(color: Colors.black45),
                    hintText: "Klick mich für eine Studienvariante!",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: (Platform.isIOS)
                          ? BorderRadius.circular(5)
                          : BorderRadius.circular(25),
                      borderSide: (Platform.isIOS)
                          ? BorderSide(
                              color: Styles.textFieldColor.withAlpha(0))
                          : BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget getProfileCard() {
      return Padding(
        padding: (Platform.isIOS)
            ? const EdgeInsets.only(top: 15, bottom: 25, left: 15, right: 15)
            : const EdgeInsets.all(0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: (Platform.isIOS)
                  ? BorderRadius.circular(15)
                  : BorderRadius.vertical(top: Radius.circular(30)),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: (Platform.isIOS)
                    ? [
                        CupertinoColors.systemOrange,
                        CupertinoColors.systemOrange
                      ]
                    : [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
              )),
          child: Column(
            children: (Platform.isIOS)
                ? <Widget>[getProfileCardContent()]
                : <Widget>[
                    Expanded(
                      flex: 3,
                      child: getProfileCardContent(),
                    ),
                  ],
          ),
        ),
      );
    }

    List<Widget> getColumnChildren() {
      List<Widget> _list = List<Widget>();
      if (!Platform.isIOS) {
        _list.add(
          Row(
            children: <Widget>[
              Expanded(
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
                child: Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: ImageIcon(
                          AssetImage(
                              "assets/icons/achievement/achievement.png"),
                          size: 36,
                        ),
                      ),
                      onPressed: () {
                        achivementsPageButtonPressed();
                      }),
                ),
              ),
            ],
          ),
        );
      }
      _list.add(
        (Platform.isIOS)
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Image(
                    image: getImage().image,
                    height: MediaQuery.of(context).size.height / 3),
              )
            : Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    child: getImage(),
                  ),
                ),
              ),
      );
      _list.add(
        (Platform.isIOS)
            ? getProfileCard()
            : Expanded(flex: 6, child: getProfileCard()),
      );
      return _list;
    }

    return Scaffold(
      appBar: (Platform.isIOS)
          ? CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Mein Studium",
                style: Styles.navBarTitle,
              ),
              trailing: Builder(
                builder: (BuildContext context) {
                  return CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Icon(
                      IOSQuickAccessIcons.rosette,
                      color: CupertinoColors.activeOrange,
                      size: 25,
                    ),
                    onPressed: () {
                      achivementsPageButtonPressed();
                    },
                  );
                },
              ),
            )
          : null,
      body: (Platform.isIOS)
          ? GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                  child: Column(children: getColumnChildren())),
            )
          : SafeArea(
              child: Column(
                children: getColumnChildren(),
              ),
            ),
    );
  }
}

class _DualStudyDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DualStudyDialogState();
}

class _DualStudyDialogState extends State<_DualStudyDialog> {
  int _groupValue = 0;

  void getCorrectGroupValue() {
    ProfileController().loadData();
    _groupValue = ProfileController().getStudyTypeIndex();
    if (_groupValue == null) {
      _groupValue = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    getCorrectGroupValue();
  }

  @override
  Widget build(BuildContext context) {
    return dualStudyDialog();
  }

  Widget dualStudyDialog() {
    return AlertDialog(
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Radio(
                    activeColor: Colors.blue,
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (_val) => changeStudyType(_val),
                  ),
                  Text(
                    "Ohne Praxissemester (6. Semester)",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (_val) => changeStudyType(_val),
                  ),
                  Text(
                    "Mit Praxissemester (7. Semester)",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: <Widget>[
                  Radio(
                    value: 2,
                    groupValue: _groupValue,
                    onChanged: (_val) => changeStudyType(_val),
                  ),
                  Text(
                    "Duales Studium",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  changeStudyType(int _val) {
    setState(() {
      _groupValue = _val;
      ProfileController().setStudyType(_val);
      ProfileController().adjustMaxCP();
      ProfileController().saveData();
    });
  }
}
