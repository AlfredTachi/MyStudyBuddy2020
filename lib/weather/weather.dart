import 'dart:convert';
import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> with SingleTickerProviderStateMixin {
  WeatherData data = WeatherData();
  AnimationController animationCtrl;
  bool showDetails = false;
  String status = "";

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
    if (Platform.isIOS) {
      return getMaterialDesign();
    } else {
      return getMaterialDesign();
    }
  }

  Widget getCupertinoDesign() {
    ///TODO implement IOS Design
    return Container();
  }

  Widget getMaterialDesign() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wetter"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                fetchData();
              })
        ],
      ),
      drawer: OwnDrawer(),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF013D62),
                Color(0xBB013D62),
                Color(0x99013D62)
              ])),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5),
                          child: Column(
                            children: <Widget>[
                              (status.isNotEmpty) ? Text(status) : Container(),
                              Text(
                                "HS Worms",
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Zuletzt aktualisiert: " + dateTimeToString(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  data.temperature.toString() + " °C",
                                  style: TextStyle(
                                    fontSize: 44,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        MaterialButton(
                          onPressed: () {
                            if (animationCtrl.isCompleted) {
                              showDetails = true;
                              animationCtrl.reverse();
                            } else {
                              showDetails = false;
                              animationCtrl.forward();
                            }
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimatedIcon(
                                icon: AnimatedIcons.close_menu,
                                progress: animationCtrl,
                              ),
                              Text(
                                "Show more",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Divider(),
                        (showDetails) ? details() : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget details() {
    try {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Luftdruck: " + data.barometer.round().toString() + " hPa",),
          Text("Luftfeuchtigkeit: " + data.humidity.toString() + " %"),
          Text("Windgesch.: " +
              (data.windSpeed / 3.6).round().toString() +
              " m/s"),
          Text("Windrichtung: " + data.windDir.toString()),
          Text("UV Strahlung: " + data.getUvEvaluation()),
          Text("Regen: " + data.rainPerMM.toString() + "mm"),
          Text("Sonnenaufgang: " + data.sunRise.toString()),
          Text("Sonnenuntergang: " + data.sunSet.toString()),
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
