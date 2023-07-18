import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/cubits/weather_cubit/weather_cubit.dart';
import 'package:weatherapp/cubits/weather_cubit/weather_state.dart';
import 'package:weatherapp/pages/search_page.dart';
import 'package:weatherapp/providers/weather_provider.dart';

import '../models/weather_model.dart';

class HomePage extends StatelessWidget {
  //WeatherModel? weatherData;

  WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SearchPage();
                    },
                  ),
                );
              },
              icon: Icon(Icons.search))
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, State) {
          if (State is WeathherLoding) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (State is WeathherSuccess) {
           weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;
            return successBody(weatherData: weatherData);
          } else if (State is WeathherFailure) {
            return Center(
              child: Text('SomeThing went wrong please try agin'),
            );
          } else {
            return DefaultlHomePahe();
          }
        },
      ),
    );
  }
}

class DefaultlHomePahe extends StatelessWidget {
  const DefaultlHomePahe({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

class successBody extends StatelessWidget {
  const successBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            BlocProvider.of<WeatherCubit>(context).cityName!,
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
    );
  }
}
