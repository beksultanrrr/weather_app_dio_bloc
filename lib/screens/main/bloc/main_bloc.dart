import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/constants/api_routs.dart';
import 'package:weather_app/core/models/weather_days_model.dart';
import 'package:weather_app/core/models/weather_hours_model.dart';
import 'package:weather_app/core/services/dio/dio_service.dart';

import '../../../core/core/models/weather_model.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainState()) {
    on<InitialMainEvent>(_initialMainEvent);
    on<GetWeatherEvent>(_getWeatherEvent);
  }

  Future<void> _initialMainEvent(
      InitialMainEvent event, Emitter<MainState> emit) async {
    if (state.isLoading) return;

    add(GetWeatherEvent());
    // add(GetTodayEvent());
  }


  String FormatDate(String date){
DateTime dateTime = DateTime.parse(date).toLocal();
String formattedDate = "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  Future<void> _getWeatherEvent(
      GetWeatherEvent event, Emitter<MainState> emit) async {
    final firstDate = FormatDate(DateTime.now().toString());
    final secondDate = FormatDate(DateTime.now().add(const Duration(days: 7)).toString());
    print(firstDate);
    print(secondDate);
    final response = await DioService().request(
      HttpMethod.get,
      '$firstDate/$secondDate?unitGroup=metric&key=' + APIRouts.apiKey,
    );

    if (response.data != null) {
      final weather = WeatherModel.fromMap(response.data);

      print("weatherr ${weather}");
      emit(state.copyWith(
        weather: weather,
          weather7Days: weather.weatherDays,
          weatherToday: weather.weatherDays.first.hoursWeather,
          weatherTomorrow: weather.weatherDays[1].hoursWeather,
          
          status: MainStatus.success));
      // emit(state.copyWith(
      //     newWeather: items.map((e) =>  WeatherModel.fromMap(e)).toList()));
    } else {
      emit(state.copyWith(status: MainStatus.failure));
    }
  }

  // Future<void> _getTodayEvent(
  //     GetTodayEvent event, Emitter<MainState> emit) async {
  //   final response = await DioService().request(
  //     HttpMethod.get,
  //     APIRouts.todayWeather,
  //   );

  //   if (response.data != null) {
  //     print(response.data);
  //     final weather = WeatherModel.fromMap(response.data);
  //     emit(state.copyWith(weather: weather));
  //   }
  // }

  // Future<void> _getTomorowEvent(
  //     GetTomorrowEvent event, Emitter<MainState> emit) async {
  //   final response = await DioService().request(
  //     HttpMethod.get,
  //     APIRouts.tomorrowWeather,
  //   );

  //   if (response.data != null) {
  //     print(response.data);
  //     final weather = WeatherModel.fromMap(response.data);
  //     // emit(state.copyWith(weather: weather.weatherDays.we));
  //     // emit(state.copyWith(
  //     //     newWeather: items.map((e) =>  WeatherModel.fromMap(e)).toList()));
  //   }
  // }
}
