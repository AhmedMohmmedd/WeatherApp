import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/providers/weather_provider.dart';

import '../services/weather_services.dart';

class SearchPage extends StatelessWidget {
  SearchPage({this.udateUi});

  String? cityName;
  VoidCallback? udateUi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Container(
        color: Colors.black26,
      
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (data) {
                cityName = data;
              },
              onSubmitted: (data) async {
                cityName = data;
                WeatherService service = WeatherService();
                WeatherModel? weather =
                    await service.getWeather(cityName: cityName!);
      
                Provider.of<WeatherProvider>(context, listen: false).weatherData =
                    weather;
      
                Provider.of<WeatherProvider>(context, listen: false).cityName =
                    cityName;
      
                Navigator.pop(context);
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                hintText: 'Enter a City',
                label: Text('search'),
                suffixIcon: GestureDetector(
                  onTap: ()async {
                     WeatherService service =  WeatherService();
                WeatherModel? weather =
                    await service.getWeather(cityName: cityName!);
      
                Provider.of<WeatherProvider>(context, listen: false).weatherData =
                    weather;
      
                Provider.of<WeatherProvider>(context, listen: false).cityName =
                    cityName;
      
                Navigator.pop(context);
                  },
                  child: (Icon(Icons.search))),
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
