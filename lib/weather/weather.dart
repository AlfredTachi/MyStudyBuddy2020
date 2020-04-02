import 'dart:io';
import 'dart:convert';
import 'dart:ui';
import 'package:MyStudyBuddy2/dashboard/profile_page/achievement/achievement.dart';
import 'package:MyStudyBuddy2/theme/ios_quick_access_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:MyStudyBuddy2/theme/styles.dart';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> with SingleTickerProviderStateMixin {
  WeatherData data = WeatherData();
  AnimationController animationCtrl;
  bool showDetails = false;
  String status = "";
  String showMore = "Details zeigen";
  String weatherLink = "http://wetter.hs-worms.de/";

  @override
  void initState() {
    super.initState();
    animationCtrl = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationCtrl.animateTo(1);
    fetchData();
  }

  void fetchData() async {
    await fetchWeather().then((_data) {
      setState(() {
        data = _data;
        status = "";
      });
    }).catchError((err) {
      setState(() {
        status =
            "Es ist ein Problem bei der Verbindung zum angeforderten Dienst aufgetreten!";
        print(err);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (Platform.isIOS)
          ? CupertinoNavigationBar(
              actionsForegroundColor: CupertinoColors.activeOrange,
              middle: Text(
                "Wetter",
                style: Styles.navBarTitle,
              ),
              trailing: Builder(
                builder: (BuildContext context) {
                  return FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            IOSQuickAccessIcons.arrow_2_circlepath,
                            size: 25,
                          ),
                          onPressed: () {
                            fetchData();
                          },
                        ),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            IOSQuickAccessIcons.info_circle,
                            size: 25,
                          ),
                          onPressed: () {
                            return showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoAlertDialog(
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text(
                                        "Informationen zu den Daten",
                                        style: Styles.alertDialogTitleText,
                                      ),
                                    ),
                                    content: Text(
                                        "Die Daten werden bereitgestellt vom TOP Wetter Team WWW und der Hochschule Worms. " +
                                            "Weitere Informationen finden Sie auf der Wetter Seite der HS Worms.",
                                        style: Styles.minorText),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text("Abbrechen",
                                            style:
                                                Styles.alertDialogActionText),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text("Zur Website",
                                            style:
                                                Styles.alertDialogActionText),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _launchURL();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          : null,
      floatingActionButton: (Platform.isIOS)
          ? null
          : FloatingActionButton(
              backgroundColor: Color(0xFF013D62),
              onPressed: () {
                fetchData();
              },
              tooltip: 'Aktualisieren',
              child: Icon(Icons.refresh),
            ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(children: getColumnChildren()),
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
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topRight,
                child: OutlineButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 3, bottom: 3),
                    child: Icon(
                      Icons.info_outline,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  )),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      child: SimpleDialog(
                        contentPadding: EdgeInsets.all(25),
                        title: FittedBox(
                            child: Text("Informationen zu den Daten")),
                        children: <Widget>[
                          Text("Die Daten werden bereitgestellt vom TOP Wetter Team WWW und der Hochschule Worms. " +
                              "Weitere Informationen finden Sie auf der Wetter Seite der HS Worms."),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Link(
                                child: Text(
                                  "Hier geht es zur Website!",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                ),
                                url: weatherLink),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    _list.add(
      Expanded(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Hs Worms",
                  style: (Platform.isIOS)
                      ? Styles.weatherTitle
                      : TextStyle(fontSize: 42, fontWeight: FontWeight.w100),
                ),
                Text(
                  dateTimeToString(),
                  style: (Platform.isIOS)
                      ? Styles.weatherTime
                      : TextStyle(fontSize: 20, color: Colors.black45),
                ),
                Text(
                  data.temperature.toString() + " °C",
                  style: (Platform.isIOS)
                      ? Styles.weatherTemperature
                      : TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
    _list.add(
      Expanded(
        flex: 2,
        child: (Platform.isIOS)
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: PhysicalModel(
                      shape: BoxShape.rectangle,
                      color: CupertinoColors.white.withOpacity(0.5),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            details(),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Center(
                    child: details(),
                  ),
                ),
              ),
      ),
    );
    return _list;
  }

  void _launchURL() async {
    if (await canLaunch(weatherLink)) {
      await launch(weatherLink);
    } else {
      throw 'Could not launch $weatherLink';
    }
  }

  TextStyle detailTextStyle() {
    return (Platform.isIOS)
    ? Styles.weatherDetails
    : TextStyle(
      color: Colors.black,
      fontSize: 24,
    );
  }

  Widget details() {
    try {
      return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FittedBox(
              child: Text(
                "Luftdruck: " + data.barometer.round().toString() + " hPa",
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Luftfeuchtigkeit: " + data.humidity.toString() + " %",
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Windgesch.: " +
                    (data.windSpeed / 3.6).round().toString() +
                    " m/s",
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Windrichtung: " + data.windDir.toString(),
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "UV Strahlung: " + data.getUvEvaluation(),
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Regen: " + data.rainPerMM.toString() + "mm",
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Sonnenaufgang: " + data.sunRise.toString(),
                style: detailTextStyle(),
              ),
            ),
            FittedBox(
              child: Text(
                "Sonnenuntergang: " + data.sunSet.toString(),
                style: detailTextStyle(),
              ),
            ),
          ],
        ),
      );
    } catch (ex) {
      return Text("Fehler beim abrufen der Daten!");
    }
  }

  String dateTimeToString() {
    DateTime _date = DateTime.now();
    return fixMissingZero(_date.hour) +
        ":" +
        fixMissingZero(_date.minute) +
        " Uhr";
  }

  String fixMissingZero(int number) {
    if (number < 10) {
      return "0" + number.toString();
    } else {
      return number.toString();
    }
  }

  Future<WeatherData> fetchWeather() async {
    final http.Response response =
        await http.get('http://wetter2.mt-labor.it.hs-worms.de/api/data');
    if (response.statusCode == 200) {
      return WeatherData.fromJson(json.decode(response.body));
    } else {
      if (response.statusCode == 404) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Achievement().showAchievement(context, 11);
        });
      }
      throw Exception('Failed to load Weather Data');
    }
  }
}

class WeatherData {
  String forecast;
  double barometer;
  var temperature;
  var humidity;
  var windSpeed;
  String windDir;
  var uvImpact;
  var rainPerMM;
  var sunRise;
  var sunSet;
  String uvEvaluation = "";

  String getUvEvaluation() {
    if (uvImpact <= 2) {
      uvEvaluation = "Niedrig";
    } else if (2 < uvImpact && uvImpact <= 5) {
      uvEvaluation = "Mäßig";
    } else if (5 < uvImpact && uvImpact <= 7) {
      uvEvaluation = "Hoch";
    } else if (7 < uvImpact && uvImpact <= 10) {
      uvEvaluation = "Sehr hoch";
    } else if (uvImpact > 10) {
      uvEvaluation = "Extrem";
    }
    return uvEvaluation;
  }

  WeatherData(
      {this.forecast,
      this.barometer,
      this.temperature,
      this.humidity,
      this.windSpeed,
      this.windDir,
      this.uvImpact,
      this.rainPerMM,
      this.sunRise,
      this.sunSet});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      forecast: json['forecast']["text"],
      barometer: json['baro'],
      temperature: json['temp']["out"]["c"],
      humidity: json['hum']['out'],
      windSpeed: json["wind"]["speed"]["kmh"],
      windDir: json["wind"]["dir"]["text"],
      uvImpact: json["sun"]["uv"],
      rainPerMM: json["rain"]["day"],
      sunRise: json["sun"]["rise"],
      sunSet: json["sun"]["set"],
    );
  }
}
