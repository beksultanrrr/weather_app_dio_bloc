// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'main_bloc.dart';

enum MainStatus { initial, loading, success, failure }

class MainState extends Equatable {
  final List<WeatherDaysModel> weather7Days;
  final List<WeatherHoursModel> weatherTomorrow;
  final List<WeatherHoursModel> weatherToday;
  final WeatherModel? weather;
  final MainStatus status;
  const MainState({
    this.weather,
    this.weather7Days = const [],
    this.weatherTomorrow = const [],
    this.weatherToday = const [],
    this.status = MainStatus.initial,
  });
  @override
  List<Object?> get props =>
      [weather7Days, weatherTomorrow, weatherToday, weather, status];

  bool get isInitial => status == MainStatus.initial;
  bool get isLoading => status == MainStatus.loading;
  bool get isSuccess => status == MainStatus.success;
  bool get isFailure => status == MainStatus.failure;

  MainState copyWith({
    List<WeatherDaysModel>? weather7Days,
    List<WeatherHoursModel>? weatherTomorrow,
    List<WeatherHoursModel>? weatherToday,
    WeatherModel? weather,
    MainStatus? status,
  }) {
    return MainState(
      weather7Days: weather7Days ?? this.weather7Days,
      weatherTomorrow: weatherTomorrow ?? this.weatherTomorrow,
      weatherToday: weatherToday ?? this.weatherToday,
      weather: weather ?? this.weather,
      status: status ?? this.status,
    );
  }
}
