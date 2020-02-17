// For debugging add this line to the MyApp class in main.dart:
//   final examResultTestVariable = new ExamResults("<RZ-Account User Name>", "RZ-Account Password");
// You also need to add this to main.dart:
//   import './exam_results/exam_results.dart

import 'package:http/http.dart' as http;

import 'package:MyStudyBuddy2/exam_results/exam_result.dart';

class ExamResults {
  List<ExamResult> results;

  ExamResults(String userName, String userPassword) {
    this.results = new List<ExamResult>();
    fetchResultsRemotely(userName, userPassword);
  }

  void fetchResultsRemotely(String userName, String userPassword) async {
    final loginResponse = await postHttp(
        'https://lsf.hs-worms.de/qisserver/rds?state=user&type=1&category=auth.login&startpage=portal.vm&breadCrumbSource=portal&asdf=$userName&fdsa=$userPassword');
    if (!loginResponse.headers.keys.first.contains('location')) {
      print(loginResponse.headers.keys.first);
      return;
    }
    final homeScreenResponse =
        await getHttp(loginResponse.headers.values.first);
    final examAdministrationResponse = await getHttp(
        extractLink(homeScreenResponse.body, ">Prüfungsverwaltung"));
    final examExtractResponse = await getHttp(
        extractLink(examAdministrationResponse.body, ">Notenspiegel"));
    final degreeResponse =
        await getHttp(extractLink(examExtractResponse.body, ">Abschluss"));
    final gradesResponse = await getHttp(extractLink(degreeResponse.body,
        'title="Leistungen für Angewandte Informatik  (PO-Version 2018)'));
    parseHtml(gradesResponse.body);
  }

  void parseHtml(String htmlFile) {
    var htmlTable = htmlFile.substring(htmlFile.indexOf('<table border="0">'));
    htmlTable = htmlTable.substring(0, htmlTable.indexOf('</table>'));

    final htmlTableStrings = htmlTable.split('\n');
    var htmlTrimmedStrings = new List<String>();
    var useFlag = false;

    for (var string in htmlTableStrings) {
      if (string.contains('valign="top">') || string.contains('valign="top" >')) {
        useFlag = true;
        continue;
      } else if (useFlag == true) {
        htmlTrimmedStrings.add(string.trim());
        useFlag = false;
      }
    }

    var moduleList = new List<List<String>>();

    while (htmlTrimmedStrings.isNotEmpty) {
      moduleList.add(htmlTrimmedStrings.sublist(0, 9));
      htmlTrimmedStrings.removeRange(0, 9);
    }

    for (var module in moduleList) {
      module[3] = module[3].replaceFirst(',', '.');
      module[5] = module[5].replaceFirst(',', '.');
      if (module[8].isNotEmpty) {
        module[8] = module[8].substring(6, 10) +
            module[8].substring(3, 5) +
            module[8].substring(0, 2);
      }
      this.results.add(new ExamResult(
          int.tryParse(module[0]),
          module[1],
          module[2],
          double.tryParse(module[3]),
          module[4],
          double.tryParse(module[5]),
          module[6],
          int.tryParse(module[7]),
          module[8]));
    }
    for (var result in this.results) {
      print(result.number.toString() + ";" + result.name + ";" + result.term + ";" + result.grade.toString() + ";" + result.passed  + ";" + result.credits.toString() + ";" + result.note + ";" + result.numberOfTries.toString() + ";" + result.date.toString());
    }
  }

  void loadResultsLocally() {}
  void saveResultsLocally() {}

  String extractLink(String htmlBody, String linkText) {
    var htmlList = htmlBody.split('<a');
    var linkLine = getItemFromListContainingString(linkText, htmlList);
    linkLine = linkLine.trim();
    var splittedLine = linkLine.split('"');
    var link = getItemFromListContainingString('https', splittedLine);
    link = link.replaceAll('&amp;', '&');
    return link;
  }

  String getItemFromListContainingString(String string, List<String> list) {
    for (var listItem in list) {
      if (listItem.contains(string)) {
        return listItem;
      }
    }
    return null;
  }

  Future<http.Response> postHttp(String url) {
    return http.post(url);
  }

  Future<http.Response> getHttp(String url) {
    return http.get(url);
  }
}
