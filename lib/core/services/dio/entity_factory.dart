

import '../../models/weather_model.dart';

class EntityFactory {
  static T generateOBJ<T>(map) {
        return WeatherModel.fromMap(map) as T;
    
    
  }
}
