import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/cubits/weather_cubit/weather_state.dart';

import '../../models/weather_model.dart';
import '../../services/weather_services.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherService weathrservice;
  WeatherModel? weatherModel;
  String? cityName;

  WeatherCubit(this.weathrservice) : super(WeathherInitial());

  void getWeather({required String cityName}) async {
    emit(WeathherLoding());
    
     weatherModel = await weathrservice.getWeather(cityName: cityName);
      emit(WeathherSuccess());

    if(weatherModel == null){
     emit(WeathherFailure());
    }
      
    }
  }

