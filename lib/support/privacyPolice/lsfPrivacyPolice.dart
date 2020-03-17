import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class LsfPrivacyPolice extends StatefulWidget {
  @override
  LsfPrivacyPoliceState createState() => LsfPrivacyPoliceState();
}

class LsfPrivacyPoliceState extends State<LsfPrivacyPolice> {
  PDFDocument document;
  bool isLoading = true;

  Future<void> _loadPdf() async {
    document = await PDFDocument.fromURL(
        "https://www.hs-worms.de/fileadmin/media/SG2/Informieren/Datenschutz/Datenschutzinformationen_aktuell.pdf");
    return document;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
          body: Center(
            child: Column(
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
                    child: Text("Lsf Datenschutzerklärung",style:TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
                Expanded(
                                child: SingleChildScrollView(
                                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: FutureBuilder(
                        future: _loadPdf(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return PDFViewer(
                              document: document,
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
