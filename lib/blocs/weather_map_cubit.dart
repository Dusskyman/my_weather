import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_weather/blocs/weather_map_state.dart';

class WeatherMapCubit extends Cubit<WeatherMapState> {
  WeatherMapCubit() : super(const WeatherMapIdle());
}
