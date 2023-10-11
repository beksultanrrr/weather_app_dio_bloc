import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:weather_app/core/models/weather_hours_model.dart';


class WeatherDaysModel {
  final DateTime dateTime;
  final double temp;
  final String condition;
  final String icon;
  final List<WeatherHoursModel> hoursWeather;

  WeatherDaysModel({
    required this.dateTime,
    required this.temp,
    required this.condition,
    required this.icon,
    required this.hoursWeather,
  });

  WeatherDaysModel copyWith({
    DateTime? dateTime,
    double? temp,
    String? condition,
    String? icon,
    List<WeatherHoursModel>? hoursWeather,
  }) {
    return WeatherDaysModel(
      dateTime: dateTime ?? this.dateTime,
      temp: temp ?? this.temp,
      condition: condition ?? this.condition,
      icon: icon ?? this.icon,
      hoursWeather: hoursWeather ?? this.hoursWeather,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'datetime': dateTime.millisecondsSinceEpoch,
      'temp': temp,
      'conditions': condition,
      'icon': icon,
      'hoursWeather': hoursWeather.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherDaysModel.fromMap(Map<String, dynamic> map) {
    return WeatherDaysModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['datetimeEpoch'] * 1000 as int),
      temp: map['temp'] ?? 0.0,
      condition: map['conditions'][1] as String,
      icon: map['icon'] as String,
      hoursWeather: List<WeatherHoursModel>.from(
        (map['hours'] as List).map<WeatherHoursModel>(
          (x) => WeatherHoursModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDaysModel.fromJson(String source) => WeatherDaysModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherDaysModel(datetime: $dateTime, temp: $temp, conditions: $condition, icon: $icon, hoursWeather: $hoursWeather)';
  }

  @override
  bool operator ==(covariant WeatherDaysModel other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime && other.temp == temp && other.condition == condition && other.icon == icon && listEquals(other.hoursWeather, hoursWeather);
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^ temp.hashCode ^ condition.hashCode ^ icon.hashCode ^ hoursWeather.hashCode;
  }
}
