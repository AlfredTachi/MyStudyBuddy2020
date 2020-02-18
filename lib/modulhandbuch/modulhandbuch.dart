import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:MyStudyBuddy2/drawer/drawer.dart';

class ModuleHandbooks extends StatefulWidget {
  @override
   State<StatefulWidget> createState() => ModuleHandbooksState();
}

class ModuleHandbooksState extends State<ModuleHandbooks> {
  PDFDocument document, documentAsset;
  bool isLoaded = false;

  _loadPdf() async {
    document =await PDFDocument.fromURL("https://hswocloud.hs-worms.de/hswocloud/index.php/s/9j6tyjaazmFKnNC/download?path=%2F&files=AnInf_Modulhandbuch_2019w.pdf");
    setState(() { 
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();    
    _loadPdf();
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
                  child: PDFViewer(
                    document: document,
                  ),
                )              
             
            ],
          ),)
    );
  }
}

class DocumentControl extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Text("Yihu");
  }
}
