import 'dart:io';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class OurPrivacyPolice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OurPrivacyPoliceState();
  }
}

class _OurPrivacyPoliceState extends State<OurPrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: (Platform.isIOS)
                ? CupertinoNavigationBar(
                    actionsForegroundColor: CupertinoColors.activeOrange,
                    middle: Text(
                      "Datenschutzerklärung",
                      style: Styles.navBarTitle,
                    ),
                  )
                : null,
            body: getBody(context))
        : SafeArea(
            child: Scaffold(
              body: getBody(context),
            ),
          );
  }

  Widget getBody(BuildContext context) {
    return Column(
      children: <Widget>[
        if (!Platform.isIOS)
          Container(
            color: Colors.orange,
            child: Row(
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
                    child: Text("Datenschutzerklärung", style: TextStyle(fontSize: 25)),
                  ),
                )
              ],
            ),
          ),
        Expanded(
            child: SingleChildScrollView(
                child: (Platform.isIOS)
                    ? Padding(
                        padding: EdgeInsets.only(
                            left: 15.0, right: 15.0, top: 10.0, bottom: 25.0),
                        child: PhysicalModel(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: CupertinoColors.white,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: getText()),
                            )),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: getText(),
                      )))
      ],
    );
  }

  Widget getText() {
    MarkdownStyleSheet stylesheet = MarkdownStyleSheet(
      blockSpacing: 20,
      h1: TextStyle(
        fontFamily: "Roboto",
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      h2: TextStyle(
        fontFamily: "Roboto",
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      h3: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      h4: TextStyle(
        fontFamily: "Roboto",
        fontSize: 20,
        fontStyle: FontStyle.italic,
        color: Colors.black
      ),
    );

    return FutureBuilder(
      future: getFile(),
      builder: (BuildContext con, AsyncSnapshot snap) {
        String data = snap.data;
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.done)
            return MarkdownBody(
              styleSheet: (Platform.isIOS) ? null : stylesheet,
              data: data,
              onTapLink: (address) async {
                final MailOptions mailOptions = MailOptions(
                  subject: "MyStudyBuddy2 App",
                  recipients: [address],
                );
                try {
                  await FlutterMailer.send(mailOptions);
                } catch (error) {}
              },
            );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<String> getFile() async {
    return await rootBundle.loadString('assets/support/datenschutz.md');
  }
}
