import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStatename;

  WeatherModel(
      {required this.date,
      required this.temp,
      required this.maxTemp,
      required this.minTemp,
      required this.weatherStatename});

  factory WeatherModel.fromJison(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    return WeatherModel(
        date: DateTime.parse(data['location']['localtime']),
        temp: jsonData['avgtemp_c'],
        maxTemp: jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        weatherStatename: jsonData['condition']['text']);
  }
  @override
  String toString() {
    return 'tem= $temp, date= $date';
  }

  String getImage() {
    if (weatherStatename == 'Clear' || weatherStatename == 'Sunny') {
      return 'assets/images/clear.png';
    } else if (weatherStatename == 'Sleet' ||
        weatherStatename == 'Snow' ||
        weatherStatename == 'Hail') {
      return 'assets/images/snow.png';
    } else if (weatherStatename == 'Heavy Cloud' ||
        weatherStatename == 'Cloudy' ||
        weatherStatename == 'Partly cloudy') {
      return 'assets/images/cloudy.png';
    } else if (weatherStatename == 'Light Rain' ||
        weatherStatename == 'Heavy Rain' ||
        weatherStatename == 'Showers' ||
        weatherStatename == 'Patchy rain possible') {
      return 'assets/images/rainy.png';
    } else if (weatherStatename == 'Thunderstorm' ||
        weatherStatename == 'Heavy rain' ||
        weatherStatename == 'Thunder') {
      return 'assets/images/thunderstorm.png';
    } else {
      return 'assets/images/clear.png';
    }
  }

  MaterialColor getColor() {
    if (weatherStatename == 'Clear' || weatherStatename == 'Sunny') {
      return Colors.orange;
    } else if (weatherStatename == 'Sleet' ||
        weatherStatename == 'Snow' ||
        weatherStatename == 'Hail') {
      return Colors.lightBlue;
    } else if (weatherStatename == 'Heavy Cloud' ||
        weatherStatename == 'Cloudy' ||
        weatherStatename == 'Partly cloudy') {
      return Colors.indigo;
    } else if (weatherStatename == 'Light Rain'  ||
        weatherStatename == 'Showers' ||
        weatherStatename == 'Patchy rain possible') {
      return Colors.blue;
    } else if (weatherStatename == 'Thunderstorm' ||
        weatherStatename == 'Heavy rain'||
        weatherStatename == 'Thunder') {
      return Colors.purple;
    } else {
      return Colors.orange;
    }
  }
}
