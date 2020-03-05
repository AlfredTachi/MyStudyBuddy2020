import 'dart:convert';
import 'package:MyStudyBuddy2/link/link.dart';
import 'package:flutter/material.dart';
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
    return getMaterialDesign();
  }

  Widget getMaterialDesign() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF013D62),
        onPressed: () {
          fetchData();
        },
        tooltip: 'Aktualisieren',
        child: Icon(Icons.refresh),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
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
                        )),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3, bottom: 3),
                        child: Icon(Icons.info_outline,
                            size: 28, color: Colors.black),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
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
                                    url: "http://wetter.hs-worms.de/"),
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
            Container(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Hs Worms",
                      style:
                          TextStyle(fontSize: 42, fontWeight: FontWeight.w100),
                    ),
                    Text(
                      dateTimeToString(),
                      style: TextStyle(color: Colors.black45),
                    ),
                    Text(
                      data.temperature.toString() + " °C",
                      style:
                          TextStyle(fontSize: 46, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.orange,
                        Colors.deepOrange,
                      ],
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 15, top: 5, bottom: 15),
                              child: Text(
                                "Details",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          alignment: Alignment.topLeft,
                          child: Center(
                            child: Align(
                              child: FittedBox(child: details()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget details() {
    try {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Luftdruck: " + data.barometer.round().toString() + " hPa",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Luftfeuchtigkeit: " + data.humidity.toString() + " %",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Windgesch.: " + (data.windSpeed / 3.6).round().toString() + " m/s",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Windrichtung: " + data.windDir.toString(),
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "UV Strahlung: " + data.getUvEvaluation(),
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Regen: " + data.rainPerMM.toString() + "mm",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Sonnenaufgang: " + data.sunRise.toString(),
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Sonnenuntergang: " + data.sunSet.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ],
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
