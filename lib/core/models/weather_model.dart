// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather_app/core/models/weather_days_model.dart';



class WeatherModel {
  final DateTime dateTime;
  final double temp;
  final String city;
  final String condition;
  final String icon;
  final List<WeatherDaysModel> weatherDays;

  WeatherModel({required this.dateTime, required this.temp, required this.condition, required this.icon, required this.city, this.weatherDays = const [] });

  WeatherModel copyWith({DateTime? dateTime, double? temp, String? condition, String? icon, String? city, List<WeatherDaysModel>? weatherDays}) {
    return WeatherModel(
        dateTime: dateTime ?? this.dateTime,
        temp: temp ?? this.temp,
        condition: condition ?? this.condition,
        icon: icon ?? this.icon,
        city: city ?? this.city,
        weatherDays: weatherDays ?? this.weatherDays);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'temp': temp,
      'condition': condition,
      'icon': icon,
      'city': city,
      'weatherDays': weatherDays.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> currentConditions = map['currentConditions'] ?? {};
    
    return WeatherModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(currentConditions['datetimeEpoch'] as int),
      temp: currentConditions['temp'] ?? 0.0,
      condition: currentConditions['conditions'] ?? 'Unknown',
      icon: currentConditions['icon'] ?? 'sun',
      city: map['resolvedAddress'] ?? '',
      weatherDays: List<WeatherDaysModel>.from(
        (map['days'] as List<dynamic>).map<WeatherDaysModel>(
          (x) => WeatherDaysModel.fromMap(x as Map<String, dynamic>),
        ),



      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(dateTime: $dateTime, temp: $temp, condition: $condition, icon: $icon,city: $city, weatherDay: $weatherDays)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime && other.temp == temp && other.condition == condition && other.icon == icon && other.city == city && other.weatherDays == weatherDays;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^ temp.hashCode ^ condition.hashCode ^ icon.hashCode ^ city.hashCode ^ weatherDays.hashCode;
  }
}
