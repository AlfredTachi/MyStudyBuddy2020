import 'dart:convert';
import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  WeatherData data = WeatherData();

  TextStyle _itemStyle() {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    fetchWeather().then((_data) {
      setState(() {
        data = _data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return getCupertinoDesign();
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.blue,
                Colors.blue[300],
                Colors.blue[200],
                Colors.blue[100]
              ])),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Worms",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text("Zuletzt aktualisiert: " + dateTimeToString()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data.temperature.toString() + " °C",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Divider(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Icon(Icons.arrow_drop_down),
                    //     Text(" Sonstige Daten "),
                    //     Icon(Icons.arrow_drop_down),
                    //   ],
                    // ),
                    // Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    //Fehler abfangen
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
  int timestamp = 0;
  var forecast;
  var barometer;
  var temperature;
  var humidity;

  WeatherData({this.forecast, this.barometer, this.temperature, this.humidity});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      forecast: json['forecast']["text"],
      barometer: json['baro'],
      temperature: json['temp']["out"]["c"],
      humidity: json['hum']['out'],
    );
  }
}
