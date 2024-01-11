import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'bfc6a9ad72f81587054473aa06776ab6';
const CITY = 'Bandung';

const weatherAPIUrl =
    'http://api.weatherstack.com/current?access_key=$API_KEY&query=$CITY';

Future<WeatherData> fetchWeatherData() async {
  final response = await http.get(Uri.parse(weatherAPIUrl));

  if (response.statusCode == 200) {
    return WeatherData.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load weather data');
  }
}

class WeatherData {
  final String location;
  final double temperature;
  final double humidity;
  final String weatherDescription;

  WeatherData({
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.weatherDescription,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: json['location']['name'],
      temperature: json['current']['temperature'],
      humidity: json['current']['humidity'],
      weatherDescription: json['current']['weather_descriptions'][0],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Data',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
      ),
      home: DataPage(),
    );
  }
}

class DataPage extends StatefulWidget {
  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late Future<WeatherData> futureWeatherData;

  @override
  void initState() {
    super.initState();
    futureWeatherData = fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Data Page'),
      ),
      body: Center(
        child: FutureBuilder<WeatherData>(
          future: futureWeatherData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildInfoCard('Location', snapshot.data!.location),
                    _buildInfoCard(
                        'Temperature', '${snapshot.data!.temperature}°C'),
                    _buildInfoCard('Humidity', '${snapshot.data!.humidity}%'),
                    _buildInfoCard('Weather Description',
                        snapshot.data!.weatherDescription),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
