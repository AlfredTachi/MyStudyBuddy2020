import 'package:flutter/material.dart';

class PrivacyPolice extends StatefulWidget {
  @override
  PrivacyPoliceState createState() => PrivacyPoliceState();
}

class PrivacyPoliceState extends State<PrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          body: Column(
            children: <Widget>[
              Row(
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, top: 3, bottom: 3),
                      child: Text("Datenschutzerklärung",
                          style: TextStyle(fontSize: 25)),
                    ),
                  )
                ],
              ),
              Expanded(child: SingleChildScrollView(child: Column(children:createList()),))
            ],
          )),
    );
  }

  List<Widget> createList() {
    List<Widget> _items = [
      ListTile(
        leading: Icon(Icons.account_circle),
        title: Text('Unsere Datenschutzerklärung'),
        onTap: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/ourPrivacyPolice');
        },
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Studierendenwerk Datenschutzerklärung'),
        onTap: () {
          Navigator.pushNamed(context,
              '/supportMain/privacyPolice/studierendenwerkPrivacyPolice');
        },
      ),
      ListTile(
        leading: Icon(Icons.lock_outline),
        title: Text('LSF Datenschutzerklärung'),
        onTap: () {
          Navigator.pushNamed(
              context, '/supportMain/privacyPolice/lsfPrivacyPolice');
        },
      ),
    ];

    return _items;
  }
}
