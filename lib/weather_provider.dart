import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WeatherProvider with ChangeNotifier {
  String _cityName = "Jakarta";
  late String _date;
  double _temperature = 0.0;
  String _description = "";
  double _windSpeed = 0.0;
  int _humidity = 0;
  int _visibility = 0;
  String _icon = "";

  WeatherProvider() {
    _date = DateFormat('d, MMMM yyyy').format(DateTime.now());
    fetchWeatherData();
  }

  String get cityName => _cityName;
  String get date => _date;
  double get temperature => _temperature;
  String get description => _description;
  double get windSpeed => _windSpeed;
  int get humidity => _humidity;
  int get visibility => _visibility;
  String get icon => _icon;

  void setCityName(String cityName) {
    _cityName = cityName;
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiKey = '1e74dcd7ade4948cadc916bcb886fcca';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _temperature = data['main']['temp'];
        _description = data['weather'][0]['description'];
        _windSpeed = data['wind']['speed'];
        _humidity = data['main']['humidity'];
        _visibility = data['visibility'];
        _icon = data['weather'][0]['icon'];
        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      throw error;
    }
  }
}
