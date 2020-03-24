import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class Impressum extends StatefulWidget {
  @override
  ImpressumState createState() => ImpressumState();
}

class ImpressumState extends State<Impressum> {
  final String verantwTitle = "Verantwortliche und Ansprechpartner";
  final String verantwSubtitle1 =
      "Ansprechpartner für Pflege und Aktualisierungen";
  final String verantwText1 =
      "Webredaktion des Studiengangs Angewandte Informatik: ";
  final String verantwText2 =
      "Für Kommentare, Anmerkungen oder Fehlerkorrekturen benutzen Sie bitte den E-Mail Support im Hilfe Menü.";
  final Link verantwLink1 = Link(
    child: Text("ai.it.hs-worms.de"),
    url: "https://ai.it.hs-worms.de",
  );
  final String verantwSubtitle2 =
      "Verantwortlich für die App des Studiengangs Angewandte Informatik";
  final String verantwText3 = "Prof. Dr.-Ing. Herbert Thielen";
  final MailOptions verantwMail = MailOptions(
    subject: 'MyStudyBuddy2',
    recipients: ["h.thielen@it.hs-worms.de"],
  );
  final String verantwText4 = """Hochschule Worms
Fachbereich Informatik
Raum N317""";

  final String dienstAnbieterTitle = "Angaben zum Dienstanbieter";
  final String dienstAnbieterText1 =
      """Hochschule Worms University of Applied Sciences
Erenburgerstraße 19
67549 Worms
Deutschland""";
  final String dienstAnbieterText2 = """Telefon: +49 6241/509-0
Telefax: +49 6241/509-222""";
  final MailOptions dienstAnbieterMail = MailOptions(
    subject: 'MyStudyBuddy2',
    recipients: ["kontakt@hs-worms.de"],
  );
  final Link dienstAnbieterLink = Link(
    child: Text("www.hs-worms.de"),
    url: "https://hs-worms.de",
  );
  final String dienstAnbieterText3 =
      "Umsatzsteueridentifikationsnummer gemäß §27a Umsatzsteuergesetz: DE813351149";
  final String dienstAnbieterText4 =
      "Die Hochschule Worms ist eine Körperschaft des Öffentlichen Rechts. Sie wird durch den Präsidenten Prof. Dr. Jens Hermsdorf gesetzlich vertreten.";

  final String aufsichtTitle = "Zuständige Aufsichtsbehörde";
  final String aufsichtText = """Ministerium für Wissenschaft,
Weiterbildung und Kultur (MWWK)
des Landes Rheinland-Pfalz
Mittlere Bleiche 61
55116 Mainz
Deutschland""";

  final String haftungTitle = "Haftung / Disclaimer";
  final String haftungText =
      """Der Anbieter versucht, die Richtigkeit und Aktualität der in dieser App bereitgestellten Informationen zu gewährleisten. Trotzdem können Fehler und Unklarheiten nicht vollständig ausgeschlossen werden. Der Anbieter übernimmt daher keine Gewähr für die Aktualität, Richtigkeit, Vollständigkeit oder Qualität der veröffentlichten Informationen.

Für Schäden materieller oder immaterieller Art, die durch die Nutzung oder Nichtnutzung der dargebotenen Informationen unmittelbar oder mittelbar verursacht werden, haftet der Anbieter nicht, sofern ihm nicht vorsätzliches oder grob fahrlässiges Verschulden angelastet werden kann.

Der Anbieter behält es sich vor, Teile der App oder die gesamte App ohne Vorankündigung zu verändern, zu ergänzen oder die App zeitweise oder endgültig aus dem App Store zu entfernen.

Die App des Anbieters enthält direkte oder indirekte Verknüpfungen bzw. Verlinkungen zu externen Webseiten Dritter, auf deren Inhalte der Anbieter keinen Einfluss hat. Die Verantwortlichkeit für verlinkte Inhalte liegt bei dem Betreiber dieser Webseiten. Zum Zeitpunkt der Verlinkung wurde eine Überprüfung auf mögliche Rechtsverstöße vorgenommen, wobei keine rechtswidrigen oder anstößigen Inhalte erkennbar waren. Sollten auf den verlinkten Seiten Rechtswidriges oder Anstößiges auftauchen, distanziert sich die Hochschule Worms ausdrücklich von diesen Inhalten und entfernt bei Bekanntwerden die jeweilige Verlinkung unverzüglich.""";

  final String copyrightTitle = "Copyright";
  final String copyrightText =
      "Die Inhalte dieser App sind urheberrechtlich geschützt und dürfen nicht ohne Zustimmung der Rechteinhaber weiterverwendet werden.";

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS)
        ? Scaffold(
            appBar: CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text("Impressum", style: Styles.navBarTitle),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: PhysicalModel(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(verantwTitle,
                                          textAlign: TextAlign.center,
                                          style: Styles.detailsTitleText),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        verantwSubtitle1,
                                        textAlign: TextAlign.center,
                                        style: Styles.detailsSubtitle,
                                      ),
                                    ),
                                    Text(
                                      verantwText1,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                    CupertinoButton(
                                        child: verantwLink1.child,
                                        onPressed: () {
                                          verantwLink1.press();
                                        }),
                                    Text(
                                      verantwText2,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, bottom: 10.0),
                                      child: Text(
                                        verantwSubtitle2,
                                        textAlign: TextAlign.center,
                                        style: Styles.detailsSubtitle,
                                      ),
                                    ),
                                    Text(
                                      verantwText3,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                    CupertinoButton(
                                        minSize: Styles
                                            .detailsDescriptionText.fontSize,
                                        padding: EdgeInsets.all(0),
                                        child: Text(verantwMail.recipients[0]),
                                        onPressed: () async {
                                          try {
                                            await FlutterMailer.send(
                                                verantwMail);
                                          } catch (error) {}
                                        }),
                                    Text(
                                      verantwText4,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                  ],
                                ),
                              )))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: PhysicalModel(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(dienstAnbieterTitle,
                                          textAlign: TextAlign.center,
                                          style: Styles.detailsTitleText),
                                    ),
                                    Text(
                                      dienstAnbieterText1,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                    Text(
                                      dienstAnbieterText2,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                    CupertinoButton(
                                        minSize: Styles
                                            .detailsDescriptionText.fontSize,
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                            dienstAnbieterMail.recipients[0]),
                                        onPressed: () async {
                                          try {
                                            await FlutterMailer.send(
                                                dienstAnbieterMail);
                                          } catch (error) {}
                                        }),
                                    CupertinoButton(
                                        minSize: Styles
                                            .detailsDescriptionText.fontSize,
                                        padding: EdgeInsets.all(0),
                                        child: dienstAnbieterLink.child,
                                        onPressed: () {
                                          dienstAnbieterLink.press();
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        dienstAnbieterText3,
                                        textAlign: TextAlign.center,
                                        style: Styles.detailsDescriptionText,
                                      ),
                                    ),
                                    Text(
                                      dienstAnbieterText4,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                  ],
                                ),
                              )))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: PhysicalModel(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(aufsichtTitle,
                                          textAlign: TextAlign.center,
                                          style: Styles.detailsTitleText),
                                    ),
                                    Text(
                                      aufsichtText,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                  ],
                                ),
                              )))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: PhysicalModel(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(haftungTitle,
                                          textAlign: TextAlign.center,
                                          style: Styles.detailsTitleText),
                                    ),
                                    Text(
                                      haftungText,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                  ],
                                ),
                              )))),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: PhysicalModel(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15),
                          color: CupertinoColors.white,
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text(copyrightTitle,
                                          textAlign: TextAlign.center,
                                          style: Styles.detailsTitleText),
                                    ),
                                    Text(
                                      copyrightText,
                                      textAlign: TextAlign.center,
                                      style: Styles.detailsDescriptionText,
                                    ),
                                  ],
                                ),
                              )))),
                              Container(height: 25,)
                ],
              ),
            ),
          )
        : Scaffold();
  }
}
