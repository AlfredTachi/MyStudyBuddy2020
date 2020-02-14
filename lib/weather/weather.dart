import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  WeatherData data = WeatherData();

  @override
  void initState() {
    fetchWeather().then((_data) {
      setState(() {
        data = _data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text(data.timestamp.toString()),
            Text(data.trend.toString()),
            Text(data.barometer.toString()),
            Text(data.temperature.toString()),
            Text(data.humidity.toString()),
            OutlineButton(
                child: Text("Aktualisieren"),
                onPressed: () async {
                  fetchWeather().then((_data) {
                    setState(() {
                      data = _data;
                    });
                  });
                })
          ],
        ),
      ),
    );
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
  var timestamp;
  var trend;
  var barometer;
  var temperature;
  var humidity;

  WeatherData(
      {this.timestamp,
      this.trend,
      this.barometer,
      this.temperature,
      this.humidity});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      timestamp: json['ts'],
      trend: json['trend']["text"],
      barometer: json['baro'],
      temperature: json['temp']["out"]["c"],
      humidity: json['hum']['out'],
    );
  }
}
