import 'dart:convert';

class WeatherHoursModel {
  final DateTime dateTime;
  final double temp;
  final String condition;
  final String icon;

  WeatherHoursModel({
    required this.dateTime,
    required this.temp,
    required this.condition,
    required this.icon,
  });

  WeatherHoursModel copyWith({
    DateTime? dateTime,
    double? temp,
    String? condition,
    String? icon,
  }) {
    return WeatherHoursModel(
      dateTime: dateTime ?? this.dateTime,
      temp: temp ?? this.temp,
      condition: condition ?? this.condition,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'temp': temp,
      'conditions': condition,
      'icon': icon,
    };
  }

  factory WeatherHoursModel.fromMap(Map<String, dynamic> map) {
    return WeatherHoursModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['datetimeEpoch'] *1000 as int),
      temp: map['temp'] ?? 0.0,
      condition: map['conditions'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherHoursModel.fromJson(String source) => WeatherHoursModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherHoursModel(dateTime: $dateTime, temp: $temp, conditions: $condition, icon: $icon)';
  }

  @override
  bool operator ==(covariant WeatherHoursModel other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime && other.temp == temp && other.condition == condition && other.icon == icon;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^ temp.hashCode ^ condition.hashCode ^ icon.hashCode;
  }
}
