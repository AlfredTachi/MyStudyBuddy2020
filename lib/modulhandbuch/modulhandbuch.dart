import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:MyStudyBuddy2/drawer/drawer.dart';

class ModuleHandbooks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ModuleHandbooksState();
}

class ModuleHandbooksState extends State<ModuleHandbooks> {
  PDFDocument document;
  bool isLoading = true;

  Future<void> _loadPdf() async {
    document = await PDFDocument.fromURL(
        "https://hswocloud.hs-worms.de/hswocloud/index.php/s/9j6tyjaazmFKnNC/download?path=%2F&files=AnInf_Modulhandbuch_2019w.pdf");
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
          title: Text("MyStudyBuddy"),
        ),
        drawer: OwnDrawer(),
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

class DocumentControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Yihu");
  }
}
