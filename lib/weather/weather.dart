import 'dart:convert';
import 'package:MyStudyBuddy2/drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  WeatherData data = WeatherData();

  TextStyle _headerStyle() {
    return TextStyle(
      fontSize: 20,
    );
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Wetter"),
      ),
      drawer: OwnDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  data.temperature.toString() + " °C",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height / 9),
                ),
                Divider(),
                Text("Aktueller Wettertrend", style: _headerStyle()),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(data.trend.toString(), style: _itemStyle())),
                Divider(),
                Text("Luftdruck", style: _headerStyle()),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(data.barometer.toString() + " hPa",
                        style: _itemStyle())),
                Divider(),
                Text("Luftfeuchtigkeit", style: _headerStyle()),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(data.humidity.toString() + "%",
                        style: _itemStyle())),
              ],
            ),
            Divider(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 10,
              child: OutlineButton(
                  child: Text("Aktualisieren",
                      style: TextStyle(
                        fontSize: 24,
                      )),
                  onPressed: () async {
                    fetchData();
                  }),
            )
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
  int timestamp = 0;
  var trend;
  var barometer;
  var temperature;
  var humidity;

  WeatherData({this.trend, this.barometer, this.temperature, this.humidity});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      trend: json['trend']["text"],
      barometer: json['baro'],
      temperature: json['temp']["out"]["c"],
      humidity: json['hum']['out'],
    );
  }
}
