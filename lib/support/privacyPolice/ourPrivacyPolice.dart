import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class OurPrivacyPolice extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyPrivacyPolice(title: 'Datenschutzerklärung'),
    );
  }
}

class MyPrivacyPolice extends StatefulWidget {
  MyPrivacyPolice({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyPrivacyPoliceState createState() => new _MyPrivacyPoliceState();
}

class _MyPrivacyPoliceState extends State<MyPrivacyPolice> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: SingleChildScrollView(
          child: Html(
            data: """
    <div>
<p class=MsoPlainText><span style='font-family:"Courier New"'><h3>Datenschutzerklärung der MyStudybuddyApp2</h3><br>
Datenschutzerklärung gemäß Artikel 12 der EU Datenschutzgrundverordnung (DSGVO)
der MyStudyBuddy2 App.<br>
<br>
In der MyStudyBuddy2 App werden Nutzerdaten erhoben und verarbeitet.
Verantwortlich für den Datenschutz ist der Präsident, beratend steht ihn
der/die Datenschutzbeauftragte zur Seite.<br>
<br>
### Erreichbarkeit der Verantwortlichen<br>
<br>
#### Präsident<br>
Hochschule Worms<br>
Der Präsident<br>
Erenburgerstraße 19<br>
67549 Worms<br>
<br>
T: +49(0)6241.509-248<br>
F: +49(0)6241.509-222<br>
E: praesident@hs-worms.de<br>
<br>
#### Datenschutzbeauftragte<br>
Hochschule Worms<br>
Datenschutzbeauftragte<br>
Erenburgerstraße 19<br>
67549 Worms<br>
<br>
T: +49(0)6241.509-0<br>
F: +49(0)6241.509-280<br>
E: datenschutz@hs-worms.de<br>
<br>
Das Beschwerderecht gemäß Artikel 13 DS-GVO ist bei der für die Hochschule
Worms zuständigen Aufsichtsbehörde geltend zu machen:<br>
<br>
Der Landesbeauftragte<br>
für den Datenschutz und die Informationsfreiheit Rheinland-Pfalz LfDI<br>
Postfach 3040<br>
55020 Mainz<br>
<br>
Welche Daten während der Nutzung der App erfasst und wie diese verwendet
werden, erläutern wir in den nächsten Abschnitten.<br>
<br>
1. Erhebung und Verarbeitung personenbezogener Daten<br>
2. Datensicherheit<br>
3. Links zu Webseiten und Nutzung von Webdiensten anderer Anbieter<br>
4. Datenlöschung<br>
5. Aktualität und Gültigkeit der Datenschutzerklärung<br>
6. Rechte für Betroffene gemäß DSGVO<br>
<br>
## Erhebung und Verarbeitung personenbezogener Daten<br>
Bei der Nutzung der App werden nur Daten erfasst und gespeichert, die manuell
eingetragen werden. Das sind im Wesentlichen:<br>
- die inf-Nummer<br>
- die Matrikelnummer<br>
- gewählte Studiumsmodule<br>
- Prüfungsergebnisse<br>
Die Eingabe dieser Daten ist optional. Alle Funktionen, die nicht direkt von
diesen Daten abhängen, stehen auch dann zur Verfügung, wenn die Daten nicht
eingegeben wurden.<br>
<br>
Zur der Nutzung der LSF-Download-Funktion muss neben der inf-Nummer auch das
Passwort eingegeben werden. Diese Daten werden von der App nicht persistent
gespeichert. Das LSF überträgt technologisch bedingt neben den
Prüfungsergebnissen, die gespeichert werden, weitere personenbezogene Daten, wie
Namen, Geburtsdaten, Matrikelnummer und Adresse. Diese Daten, die nicht für die
Funktion der App nötig sind, werden nicht gespeichert oder weitergegeben.<br>
<br>
## Datensicherheit<br>
Die Speicherung der Daten geschieht durch das Betriebssystem und wird durch
dieses vor dem Zugriff Dritter geschützt. Die Datenübertragung zum LSF
geschieht über eine verschlüsselte https-Verbindung, und ist damit auch im
Rahmen der aktuell zur Verfügung stehenden technologischen Möglichkeiten vor
dem Zugriff Dritter geschützt.<br>
<br>
## Links zu Webseiten und Nutzung von Webdiensten anderer Anbieter<br>
Soweit über Querverweise (Links) auf Inhalte anderer Anbieter verwiesen wird,
kann deren Datenerhebung und Datennutzung nach anderen als den oben
dargestellten Grundsätzen erfolgen. Hinweise zur Verantwortung für die
bereitgestellten Inhalte einer Webseite finden Sie im jeweiligen Impressum der
Webseite.<br>
<br>
Die App macht von Webdiensten Gebrauch, deren Datenschutzerklärungen unter dem
Menüpunkt &quot;Hilfe &gt; Datenschutz&quot; zu finden sind.<br>
<br>
## Datenlöschung<br>
Da die Nutzerdaten nur auf dem lokalen Gerät gespeichert werden, auf das der
App-Anbieter keinen Zugriff hat, können die Daten nur durch den Nutzer gelöscht
werden.<br>
<br>
## Aktualität und Gültigkeit der Datenschutzerklärung<br>
Durch die Weiterentwicklung der App kann es notwendig werden, diese
Datenschutzerklärung zu ändern. Der Anbieter behält es sich vor, die
Datenschutzerklärung jederzeit mit Wirkung für die Zukunft zu ändern. Wir
empfehlen, die Datenschutzerklärung vor jedem App-Update erneut durchzulesen.<br>
<br>
## Rechte für Betroffene gemäß DSGVO<br>
<br>
### Artikel 13 DSGVO, Informationsrecht<br>
Sie haben das Recht, über die Kontaktdaten des Verantwortlichen, den Zweck
jeder einzelnen Art der Datenverarbeitung und deren Dauer informiert zu werden.
Weiterhin müssen sie über ihre Rechte aufgeklärt werden.<br>
<br>
### Artikel 15 DSGVO, Auskunftsrecht<br>
Sie haben das Recht, Auskunft darüber zu verlangen, ob und inwieweit Ihre
personenbezogenen Daten verarbeitet werden (Verarbeitungszweck, Empfänger,
Speicherdauer, etc.).<br>
<br>
### Artikel 16 DSGVO, Recht auf Berichtigung<br>
Sie haben das Recht, die Berichtigung Ihrer gespeicherten Daten zu verlangen,
sofern diese unrichtig oder unvollständig sein sollten. Dies umfasst das Recht
auf Vervollständigung.<br>
<br>
### Artikel 17 DSGVO, Recht auf Löschung<br>
Sie haben das Recht, die Löschung Ihrer personenbezogenen Daten zu verlangen,
sofern nicht übergeordnete Rechtsgründe dem Wunsch entgegenstehen.<br>
<br>
### Artikel 18 DSGVO, Recht auf Einschränkung der Verarbeitung<br>
Sie haben das Recht, die Verarbeitung ihrer personenbezogenen Daten
einschränken zu lassen. Dies ist etwa dann möglich, wenn Ihre Daten unrichtig
erfasst sind oder die Datenverarbeitung unrechtmäßig erfolgt. Im Falle der
Einschränkung der Verarbeitung dürfen die Daten nur noch in eng umgrenzten
Fällen verarbeitet werden.<br>
<br>
### Artikel 20 DSGVO, Recht auf Datenübertragbarkeit<br>
Sie haben das Recht, die Herausgabe der Sie betreffenden Daten in einem
gängigen elektronischen, maschinenlesbaren Datenformat an Sie oder an einen von
Ihnen zu benennenden Verantwortlichen zu verlangen, wenn Sie diese Daten selbst
bereitgestellt haben.<br>
<br>
### Artikel 21 DSGVO, Widerspruchsrecht<br>
Sie haben das Recht, aus Gründen, die sich aus ihrer besonderen Situation
ergeben, jederzeit der Verarbeitung sie betreffender personenbezogener Daten
für die Zukunft zu widersprechen.<br>
<br>
### Artikel 22 DSGVO, Recht, nicht ausschließlich automatisierter
Entscheidung<br>
Sie haben das Recht, nicht einer ausschließlich auf einer automatisierten
Verarbeitung – einschließlich Profiling – beruhenden Entscheidung unterworfen
zu werden, die Ihnen gegenüber rechtliche Wirkung entfaltet oder Sie in
ähnlicher Weise erheblich beeinträchtigt.<br>
<br>
### Artikel 77 DSGVO, Beschwerderecht<br>
Sie haben das Recht, sich wegen eventueller Verstöße gegen
datenschutzrechtliche Vorschriften jederzeit an die zuständige Aufsichtsbehörde
zu wenden. Die entsprechende Adresse finden Sie am Anfang des Dokuments.<br>
<o:p>&nbsp;</o:p></span></p>

</div>

  """,
            //Optional parameters:
            padding: EdgeInsets.all(8.0),
            linkStyle: const TextStyle(
              color: Colors.redAccent,
              decorationColor: Colors.redAccent,
              decoration: TextDecoration.underline,
            ),
            onLinkTap: (url) {
              print("Opening $url...");
            },
            onImageTap: (src) {
              print(src);
            },
            //Must have useRichText set to false for this to work
            customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "custom_tag":
                    return Column(children: children);
                }
              }
              return null;
            },
            customTextAlign: (dom.Node node) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return TextAlign.justify;
                }
              }
              return null;
            },
            customTextStyle: (dom.Node node, TextStyle baseStyle) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "p":
                    return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
                }
              }
              return baseStyle;
            },
          ),
        ),
      ),
    );
  }
}