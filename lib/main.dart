import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main(List<String> args) {
  runApp(MaterialApp(
    title: "Weather app ",
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  var temp, description, humidity, windSpeed;

  Future getWeather() async {
    var url = Uri.parse(
        "http://api.openweathermap.org/data/2.5/weather?q=kolkata&units=imperial&appid=835e3ed2b4c5ea777b75990abb541722");
    http.Response response = await http.get(url);
    var result = jsonDecode(response.body);

    setState(() {
      temp = result['main']['temp'];
      description = result['weather'][0]['description'];
      humidity = result['main']['humidity'];
      windSpeed = result['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.pexels.com/photos/1905054/pexels-photo-1905054.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          // MAIN
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Temp",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  Text(
                    temp != null ? temp.toString() + "\u00B0 F" : "Loading..",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            // Divider(
            //   height: MediaQuery.of(context).size.height / 2,
            // ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.cloud,
                  color: Colors.white,
                ),
                title: Text("Weather", style: TextStyle(color: Colors.white)),
                trailing: Text(
                    description != null ? description.toString() : "Loading..",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.water,
                  color: Colors.white,
                ),
                title: Text("Humidity", style: TextStyle(color: Colors.white)),
                trailing: Text(
                    humidity != null ? humidity.toString() + "%" : "Loading..",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: ListTile(
                leading: Icon(
                  Icons.air,
                  color: Colors.white,
                ),
                title: Text(
                  "Wind Speed",
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Text(
                    windSpeed != null
                        ? windSpeed.toString() + " mph"
                        : "Loading..",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
