import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:weather_report/models/weather';

class WeatherPage2 extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage2> {
  String city = '';
  int temperature = 0;
  String description = '';
  String iconUrl = '';

  void fetchWeather(String cityName) async {
    final apiKey = '1dacae4c127c7796b15c911a3ee07500';
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      setState(() {
        city = cityName;
        temperature = (jsonData['main']['temp'] - 273.15).round();

        description = jsonData['weather'][0]['description'];

        iconUrl =
            'https://openweathermap.org/img/wn/${jsonData['weather'][0]['icon']}.png';
      });
    } else {
      print('Error fetching weather data: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/asset/cloud.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    city = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter city',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    fetchWeather(city);
                  },
                  child: Text('Get Weather'),
                ),
                SizedBox(height: 100),
                if (city.isNotEmpty) ...[
                  Text(
                    'City: $city',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          width: 100,
                          height: 100,
                          color: Colors.amber,
                          imageUrl: iconUrl,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Temperature: $temperature°C',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        Text(
                          'Condition: $description',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
