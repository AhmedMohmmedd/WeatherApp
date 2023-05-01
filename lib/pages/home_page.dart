import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/pages/search_page.dart';
import 'package:weatherapp/providers/weather_provider.dart';

import '../models/weather_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //WeatherModel? weatherData;

  void udateUi() {
    setState(() {});
  }

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    weatherData = Provider.of<WeatherProvider>(context).weatherData;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchPage(
                    udateUi: udateUi,
                  );
                }));
              },
              icon: Icon(Icons.search))
        ],
        title: Text('Weather App'),
      ),
// Provider.of<WeatherProvider>(context , listen: true).weatherData
      body: weatherData == null
          ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors:[
                Colors.blue,
                Colors.blue[300]!,
                Colors.blue[100]!,
              ])
            ),
            child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'there is no weather start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      '😔',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'searching now 🔍',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    )
                  ],
                ),
              ),
          )
          : Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  weatherData!.getColor(),
                  weatherData!.getColor()[300]!,
                  weatherData!.getColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    Provider.of<WeatherProvider>(context).cityName!,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Update at: ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()} ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(weatherData!.getImage()),
                      Text(
                        '${weatherData!.temp.toInt()}',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        children: [
                          Text('maxTemp: ${weatherData!.maxTemp.toInt()}',
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          Text('minTemp: ${weatherData!.minTemp.toInt()}',
                              style: TextStyle(
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    weatherData!.weatherStatename,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ),
    );
  }
}
