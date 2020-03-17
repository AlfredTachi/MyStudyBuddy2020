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
    return Scaffold(
        appBar: AppBar(
          title: Text("Lsf Datenschutzerklärung"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
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
              )
            ],
          ),
        ));
  }
}
